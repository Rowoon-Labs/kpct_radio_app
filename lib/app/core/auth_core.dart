import 'dart:async';

import 'package:kpct_switcher/kpct_switcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app/model/sync.dart';
import 'package:kpct_radio_app/model/transaction_response.dart';
import 'package:kpct_radio_app_common/app/misc/utils.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

class AuthCore {
  final Synchronizer _synchronizer;
  final Inventory inventory;

  StreamSubscription<User?>? _authStateChanges;
  StreamSubscription<DocumentSnapshot<CustomUser>>? _userDocumentChanges;

  User? _currentUser;
  bool _isEnsuringUserDocument = false;
  // User? get currentUser => _currentUser;

  Stream<List<Equipment>> get equipmentsChanges => inventory.equipmentsChanges;
  Stream<List<Pack>> get packsChanges => inventory.packsChanges;
  Stream<List<Kit>> get kitsChanges => inventory.kitsChanges;

  CustomUser? get customUser => _synchronizer._syncedCustomUser;
  bool get canPlay => _synchronizer.canPlay;
  bool get tick => _synchronizer.tick;

  AuthCore() : _synchronizer = Synchronizer(), inventory = Inventory();

  Future<void> initialize() async {
    _authStateChanges = FirebaseAuth.instance.authStateChanges().listen(
      _onAuthStateChanges,
    );
  }

  void _onAuthStateChanges(User? user) async {
    if (user != null) {
      _currentUser = user;
      if (kDebugMode) {
        print(
          "AuthCore: _onAuthStateChanges(${user.uid}) - Reserved 데이터 로딩 시작",
        );
      }

      await App.instance.reserved.load;
      if (kDebugMode) {
        print("AuthCore: Reserved 데이터 로딩 완료. 유저 문서 감시 시작");
      }

      _userDocumentChanges = FirebaseFirestore.instance
          .collection("users")
          .withConverter(
            fromFirestore: CustomUser.fromFirstore,
            toFirestore: CustomUser.toFirestore,
          )
          .doc(user.uid)
          .snapshots()
          .listen(_synchronizer._onUserDocumentChanges);
      inventory._equipmentCollectionChanges = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("equipments")
          .withConverter(
            fromFirestore: Equipment.fromFirstore,
            toFirestore: Equipment.toFirestore,
          )
          .snapshots()
          .listen(inventory._onEquipmentCollectionChanges);
    } else {
      _currentUser = null;

      _synchronizer._cancel();

      _userDocumentChanges?.cancel();

      inventory._equipments.clear();
      inventory._equipmentCollectionChanges?.cancel();

      App.instance.navigator.go("/sign");
      App.instance.overlay.cover(on: false);
    }
  }

  Future<String?> signInWithGoogle() async {
    String? result;

    await GoogleSignIn()
        .signIn()
        .then((account) async {
          if (account != null) {
            await account.authentication
                .then((authentication) async {
                  final OAuthCredential credential =
                      GoogleAuthProvider.credential(
                        accessToken: authentication.accessToken,
                        idToken: authentication.idToken,
                      );

                  await FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                        //
                      })
                      .catchError((error) {
                        result = error.toString();
                      });
                })
                .catchError((error) {
                  result = error.toString();
                });
          } else {
            result = "Can't Get Google Account";
          }
        })
        .catchError((error) {
          result = error.toString();
        });

    return result;
  }

  Future<String?> signInWithApple() async {
    String? result;

    await FirebaseAuth.instance
        .signInWithProvider(AppleAuthProvider())
        .then((value) {
          //
        })
        .catchError((error) {
          result = error.toString();
        });

    App.instance.log.d(result);

    return result;
  }

  Future<String?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    String? result;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      result = e.message ?? e.code;
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  Future<String?> signOut() async {
    String? result;
    App.instance.log.d(
      FirebaseAuth.instance.currentUser?.providerData.firstOrNull?.providerId,
    );

    if (FirebaseAuth
            .instance
            .currentUser
            ?.providerData
            .firstOrNull
            ?.providerId !=
        null) {
      if (FirebaseAuth
              .instance
              .currentUser
              ?.providerData
              .firstOrNull
              ?.providerId ==
          "google.com") {
        await GoogleSignIn()
            .signOut()
            .then((value) async {
              await FirebaseAuth.instance
                  .signOut()
                  .then((value) {
                    //
                  })
                  .catchError((error) {
                    result = error.toString();
                  });
            })
            .catchError((error) {
              result = error.toString();
            });
      } else if (FirebaseAuth
              .instance
              .currentUser
              ?.providerData
              .firstOrNull
              ?.providerId ==
          "apple.com") {
        await FirebaseAuth.instance
            .signOut()
            .then((value) {
              //
            })
            .catchError((error) {
              result = error.toString();
            });
      } else {
        await FirebaseAuth.instance.signOut().catchError((error) {
          result = error.toString();
        });
      }
    } else {
      result = "Not Logged In";
    }

    return result;
  }

  Future<void> ensureUserDocument() async {
    if (_isEnsuringUserDocument) {
      if (kDebugMode) {
        print("AuthCore: ensureUserDocument 이미 실행 중입니다.");
      }
      return;
    }

    _isEnsuringUserDocument = true;
    try {
      await FirebaseFunctions.instanceFor(
        region: "asia-northeast3",
      ).httpsCallable("ensureUserDocument").call();
      if (kDebugMode) {
        print("AuthCore: ensureUserDocument 호출 성공");
      }
    } catch (e) {
      if (kDebugMode) {
        print("AuthCore: ensureUserDocument 실패: $e");
      }
      // 실패했을 경우 다음 이벤트나 재시도시 다시 실행할 수 있도록 플래그 초기화
      _isEnsuringUserDocument = false;
    }
  }
}

class Synchronizer {
  final StreamController<CustomUser?> _syncedCustomUserStreamController;

  CustomUser? _syncedCustomUser;
  CustomUser? _originCustomUser;

  final Sync _sync;

  Timer? _periodicTimer;

  Synchronizer()
    : _sync = Sync(),
      _syncedCustomUserStreamController = StreamController.broadcast();

  void _onUserDocumentChanges(
    DocumentSnapshot<CustomUser> documentSnapshot,
  ) async {
    if (kDebugMode) {
      print(
        "AuthCore: _onUserDocumentChanges 수신 (Exists: ${documentSnapshot.exists})",
      );
    }
    if (documentSnapshot.exists && (documentSnapshot.data() != null)) {
      final CustomUser customUser = documentSnapshot.data()!;

      final user = FirebaseAuth.instance.currentUser;
      final providerId = user?.providerData.firstOrNull?.providerId;

      if (providerId == "password" && !customUser.bonded) {
        unawaited(documentSnapshot.reference.update({"bonded": true}));
      }

      if (kDebugMode) {
        print("AuthCore: 유저 데이터 확인됨 (${customUser.email})");
      }

      if (_syncedCustomUser != null) {
        _syncedFromRemote(customUser: customUser);
      } else {
        _syncedFromRemote(customUser: customUser);

        _periodicTimer = Timer.periodic(
          const Duration(seconds: 1),
          _periodicTick,
        );

        if (kDebugMode) {
          print("AuthCore: 홈으로 이동");
        }
        App.instance.navigator.go("/home");
        App.instance.overlay.cover(on: false);
      }
    } else {
      if (kDebugMode) {
        print("AuthCore: Firestore에 유저 문서가 없습니다. (ID: ${documentSnapshot.id})");
      }

      final user = FirebaseAuth.instance.currentUser;
      final providerId = user?.providerData.firstOrNull?.providerId;

      if (providerId == "password") {
        if (kDebugMode) {
          print("AuthCore: ID/Password 유저 확인됨. 유저 문서 직접 생성 시도");
        }

        final now = koreaNow();
        final defaultStamina =
            App.instance.reserved.level(level: 1)?.stamina ?? 100;
        final defaultExp =
            App.instance.reserved.level(level: 1)?.exp.toDouble() ?? 100.0;

        final newUser = CustomUser(
          id: documentSnapshot.id,
          bonded: true,
          role: CustomUserRole.user,
          profileImageUrl: user?.photoURL,
          email: user?.email ?? "",
          createdAt: now,
          walletAddress: null,
          level: 1,
          stamina: defaultStamina,
          maxStamina: defaultStamina,
          consumedStamina: 0,
          exp: 0,
          maxExp: defaultExp,
          listeningGauge: 0,
          ep: 0,
          accumulatedEp: 0,
          accumulatedPlayDuration: Duration.zero,
          radioSsp: 0,
          accumulatedRadioSsp: 0,
          hodSsp: 0,
          referralCode: null,
          installedEquipments: {},
          nextRandomBoxAt: now,
          nextPeriodic12: null,
          nextPeriodic24: null,
          overcomeLevels: [],
          items: [],
        );

        try {
          await documentSnapshot.reference.set(newUser);
          if (kDebugMode) {
            print("AuthCore: ID/Password 유저 문서 생성 성공");
          }
        } catch (e) {
          if (kDebugMode) {
            print("AuthCore: ID/Password 유저 문서 생성 실패: $e");
          }
          App.instance.overlay.cover(on: false, message: "유저 정보 생성에 실패했습니다.");
        }
      } else {
        // 문서가 없는 경우 서버에 생성을 요청 ( Google / Apple 로그인의 경우 )
        unawaited(App.instance.auth.ensureUserDocument());

        // Functions가 문서를 생성할 때까지 기다리거나, 실패했음을 알림
        App.instance.overlay.cover(
          on: true,
          message: "유저 정보를 생성 중이거나 찾을 수 없습니다.\n잠시만 기다려 주세요...",
        );
      }
    }
  }

  Future<void> _periodicTick(Timer timer) async {
    if (_syncedCustomUser != null) {
      final DateTime? nextPeriodic12 = _syncedCustomUser!.nextPeriodic12;
      final DateTime? nextPeriodic24 = _syncedCustomUser!.nextPeriodic24;

      final DateTime now = koreaNow();

      if ((nextPeriodic12 == null) || (nextPeriodic24 == null)) {
        await __periodicTick(now: now);
      } else {
        if (now.isAfter(nextPeriodic12) || now.isAfter(nextPeriodic24)) {
          await __periodicTick(now: now);
        }
      }
    }
  }

  Future<void> __periodicTick({required DateTime now}) async {
    final DocumentReference<CustomUser> userReference = FirebaseFirestore
        .instance
        .collection("users")
        .doc(App.instance.auth.customUser?.id)
        .withConverter(
          fromFirestore: CustomUser.fromFirstore,
          toFirestore: CustomUser.toFirestore,
        );

    await FirebaseFirestore.instance.runTransaction<void>((transaction) async {
      final DocumentSnapshot<CustomUser> snapshot = await transaction
          .get<CustomUser>(userReference);

      final CustomUser? user = snapshot.exists ? snapshot.data() : null;

      if (user != null) {
        final DateTime? nextPeriodic12 = user.nextPeriodic12;
        final DateTime? nextPeriodic24 = user.nextPeriodic24;

        if ((nextPeriodic12 == null) || (nextPeriodic24 == null)) {
          transaction.update(userReference, {
            "nextPeriodic24": Timestamp.fromDate(
              DateTime(now.year, now.month, now.day + 1),
            ),
            if (now.hour < 12) ...{
              "nextPeriodic12": Timestamp.fromDate(
                DateTime(now.year, now.month, now.day, 12),
              ),
            } else ...{
              "nextPeriodic12": Timestamp.fromDate(
                DateTime(now.year, now.month, now.day + 1),
              ),
            },
          });
        } else {
          if (now.isAfter(nextPeriodic12) || now.isAfter(nextPeriodic24)) {
            final Map<String, dynamic> data = {};

            if (now.isAfter(nextPeriodic12)) {
              data["nextPeriodic12"] =
                  (now.hour < 12)
                      ? Timestamp.fromDate(
                        DateTime(now.year, now.month, now.day, 12),
                      )
                      : Timestamp.fromDate(
                        DateTime(now.year, now.month, now.day + 1),
                      );

              data["stamina"] = user.adjustedStaminaMax;
            }

            if (now.isAfter(nextPeriodic24)) {
              data["nextPeriodic24"] = Timestamp.fromDate(
                DateTime(now.year, now.month, now.day + 1),
              );

              final int getSsp24HAmount = user.adjustedGetSsp24HAmount;
              final int getEp24HAmount = user.adjustedGetEp24HAmount;

              if ((getSsp24HAmount > 0) &&
                  user.inAdjustedLuckRange(
                    App.instance.reserved.global.luck,
                    user.adjustedGetSsp24HRate,
                  )) {
                data["radioSsp"] = FieldValue.increment(getSsp24HAmount);
                data["accumulatedRadioSsp"] = FieldValue.increment(
                  getSsp24HAmount,
                );
              }

              if ((getEp24HAmount > 0) &&
                  user.inAdjustedLuckRange(
                    App.instance.reserved.global.luck,
                    user.adjustedGetEp24HRate,
                  )) {
                data["ep"] = FieldValue.increment(getEp24HAmount);
                data["accumulatedEp"] = FieldValue.increment(getEp24HAmount);
              }
            }

            if (data.isNotEmpty) {
              transaction.update(userReference, data);
            }
          }
        }
      }
    });
  }

  void _cancel() {
    _syncedFromRemote(customUser: null);
    _periodicTimer?.cancel();
    _periodicTimer = null;
  }

  void _syncedFromRemote({required CustomUser? customUser}) {
    if (customUser != null) {
      _originCustomUser = customUser;

      _syncFromLocal(
        gainedExp: _sync.gainedExp,
        consumedStamina: _sync.consumedStamina,
        elapsedPlayDuration: _sync.elapsedPlayDuration,
        gainedListeningGauge: _sync.gainedListeningGauge,
      );
    } else {
      _sync.clear();
      _syncedCustomUser = null;
      _originCustomUser = null;

      _syncedCustomUserStreamController.add(null);
    }
  }

  bool get canPlay =>
      (_syncedCustomUser?.stamina ?? 0) >=
      (_originCustomUser?.adjustedListeningPower(
            App.instance.reserved.global.staminaUse,
          ) ??
          0);

  bool get tick {
    if ((_originCustomUser != null) && (_syncedCustomUser != null)) {
      final int currentListeningPower =
          (_originCustomUser?.adjustedListeningPower(
                App.instance.reserved.global.staminaUse,
              ) ??
              0);

      final double gainedExp =
          currentListeningPower *
          (_originCustomUser?.adjustedGetExp(
                App.instance.reserved.global.expStamina,
              ) ??
              1);

      final int gainedListeningGauge =
          currentListeningPower *
          App.instance.reserved.global.configuration.listeningGaugeGain;

      final Duration elapsedPlayDuration = Duration(
        seconds:
            App.instance.reserved.global.configuration.tickSeconds.inSeconds,
      );

      _sync
        ..tick += 1
        ..gainedExp += gainedExp
        ..consumedStamina += currentListeningPower
        ..gainedListeningGauge += gainedListeningGauge
        ..elapsedPlayDuration += elapsedPlayDuration;

      _syncFromLocal(
        gainedExp: _sync.gainedExp,
        consumedStamina: _sync.consumedStamina,
        gainedListeningGauge: _sync.gainedListeningGauge,
        elapsedPlayDuration: _sync.elapsedPlayDuration,
      );

      if ((_sync.tick ==
              App.instance.reserved.global.configuration.syncTickCount) ||
          (_syncedCustomUser!.stamina < currentListeningPower)) {
        // Call FirebaseFunction
        unawaited(
          _syncToRemote(
            gainedExp: _sync.gainedExp,
            consumedStamina: _sync.consumedStamina,
            gainedListeningGauge: _sync.gainedListeningGauge,
            elapsedPlayDuration: _sync.elapsedPlayDuration,
          ),
        );

        _sync.clear();
      }

      return (_syncedCustomUser!.stamina >= currentListeningPower);
    } else {
      return false;
    }
  }

  void _syncFromLocal({
    required double gainedExp,
    required int consumedStamina,
    required int gainedListeningGauge,
    required Duration elapsedPlayDuration,
  }) {
    final CustomUser? originCustomUser = _originCustomUser;

    if (originCustomUser != null) {
      _syncedCustomUserStreamController.add(
        _syncedCustomUser = _originCustomUser?.copyWith(
          stamina: (originCustomUser.stamina - consumedStamina).clamp2() as int,
          consumedStamina:
              (originCustomUser.consumedStamina + consumedStamina).clamp2(
                    max:
                        App
                            .instance
                            .reserved
                            .global
                            .configuration
                            .staminaBoxRequirement,
                  )
                  as int,
          exp:
              (originCustomUser.exp + gainedExp).clamp2(
                    max: originCustomUser.maxExp,
                  )
                  as double,
          listeningGauge:
              (originCustomUser.listeningGauge + gainedListeningGauge).clamp2(
                    min: 0,
                    max: App.instance.reserved.global.listeningGauge,
                  )
                  as int,
          accumulatedPlayDuration:
              (originCustomUser.accumulatedPlayDuration + elapsedPlayDuration),
        ),
      );
    }
  }

  Future<void> _syncToRemote({
    required double gainedExp,
    required int consumedStamina,
    required int gainedListeningGauge,
    required Duration elapsedPlayDuration,
  }) async {
    final DocumentReference<CustomUser> userReference = FirebaseFirestore
        .instance
        .collection("users")
        .doc(App.instance.auth.customUser?.id)
        .withConverter(
          fromFirestore: CustomUser.fromFirstore,
          toFirestore: CustomUser.toFirestore,
        );

    final TransactionResponse<void> response = await FirebaseFirestore.instance
        .runTransaction<TransactionResponse<void>>((transaction) async {
          final DocumentSnapshot<CustomUser> userSnapshot = await transaction
              .get<CustomUser>(userReference);

          final CustomUser? user =
              userSnapshot.exists ? userSnapshot.data() : null;

          if (user != null) {
            transaction.update(userReference, {
              "stamina": (user.stamina - consumedStamina).clamp2(),
              "consumedStamina": (user.consumedStamina + consumedStamina)
                  .clamp2(
                    max:
                        App
                            .instance
                            .reserved
                            .global
                            .configuration
                            .staminaBoxRequirement,
                  ),
              "exp": (user.exp + gainedExp).clamp2(max: user.maxExp),
              "listeningGauge": (user.listeningGauge + gainedListeningGauge)
                  .clamp2(max: App.instance.reserved.global.listeningGauge),
              "accumulatedPlayDuration":
                  (user.accumulatedPlayDuration + elapsedPlayDuration)
                      .inSeconds,
            });

            return TransactionResponse<List<String>>.success();
          } else {
            return TransactionResponse<List<String>>.fail(
              error: "유저 정보를 가져올 수 없습니다",
            );
          }
        })
        .catchError((error) {
          return TransactionResponse<List<String>>.fail(error: "소켓 언락 실패");
        });
  }
}

class Inventory {
  // 내가 보유한 장비
  final List<Equipment> _equipments;

  /// 내가 보유한 장비(Equipment)의 Instance
  /// Home - Gear 페이지엔 내가 보유한 장비 목록이 나오기 떄문
  final List<Pack> _packs;

  /// 전체 기어 목록(내가 보유 하지 않은것 + 내가 보유 한것)
  /// Home - Crafting 페이지엔 전체 기어 목록이 나오되, 내가 보유한건 밝게 + 갯수 표기하기 때문
  final List<Kit> _kits;

  StreamSubscription<QuerySnapshot<Equipment>>? _equipmentCollectionChanges;

  final StreamController<List<Equipment>> _equipmentsStreamController;
  final StreamController<List<Pack>> _packsStreamController;
  final StreamController<List<Kit>> _kitsStreamController;

  Stream<List<Equipment>> get equipmentsChanges async* {
    yield _equipments;
    yield* _equipmentsStreamController.stream;
  }

  Stream<List<Pack>> get packsChanges async* {
    yield _packs;
    yield* _packsStreamController.stream;
  }

  Stream<List<Kit>> get kitsChanges async* {
    yield _kits;
    yield* _kitsStreamController.stream;
  }

  Inventory()
    : _kits = List<Kit>.empty(growable: true),
      _packs = List<Pack>.empty(growable: true),
      _equipments = List<Equipment>.empty(growable: true),
      _kitsStreamController = StreamController.broadcast(),
      _packsStreamController = StreamController.broadcast(),
      _equipmentsStreamController = StreamController.broadcast();

  void _onEquipmentCollectionChanges(QuerySnapshot<Equipment> querySnapshot) {
    _equipments
      ..clear()
      ..addAll(querySnapshot.docs.map((element) => element.data()).toList());

    _packs.clear();
    _kits.clear();

    final List<Gear> gears = List.of(App.instance.reserved.gears);
    final List<Equipment> temporaryEquipments = List.of(_equipments);

    for (final Gear gear in gears) {
      final List<Equipment> equipments = List.of(
        temporaryEquipments.where((element) => (element.gearId == gear.id)),
      );
      temporaryEquipments.removeWhere((element) => (element.gearId == gear.id));

      if (equipments.isNotEmpty) {
        if (gear.stackable) {
          _packs.add(
            Pack.generate(gear: gear, equipments: List.of(equipments)),
          );
        } else {
          for (Equipment equipment in equipments) {
            _packs.add(
              Pack.generate(gear: gear, equipments: List.of([equipment])),
            );
          }
        }

        _kits.add(Kit.generate(gear: gear, equipments: List.of(equipments)));
      } else {
        _kits.add(Kit.generate(gear: gear, equipments: null));
      }
    }

    _equipmentsStreamController.add(_equipments);
    _packsStreamController.add(_packs);
    _kitsStreamController.add(_kits);
  }
}

typedef WithAuthBuilder = Widget Function(CustomUser user);

class WithAuth extends StatelessWidget {
  final WithAuthBuilder builder;

  const WithAuth({super.key, required this.builder});

  @override
  Widget build(BuildContext context) => StreamBuilder(
    key: super.key,
    stream:
        App
            .instance
            .auth
            ._synchronizer
            ._syncedCustomUserStreamController
            .stream,
    initialData: App.instance.auth._synchronizer._syncedCustomUser,
    builder:
        (_, snapshot) => KpctSwitcher(
          builder: () {
            if (snapshot.hasData && (snapshot.data != null)) {
              return KeyedSubtree(
                key: const ValueKey<String>("withAuth"),
                child: builder(snapshot.data!),
              );
            } else {
              return const SizedBox(key: ValueKey<String>("withOutAuth"));
            }
          },
        ),
  );
}
