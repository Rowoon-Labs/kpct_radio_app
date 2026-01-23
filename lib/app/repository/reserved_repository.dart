import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/model/decomposition.dart';
import 'package:kpct_radio_app/model/draw.dart';
import 'package:kpct_radio_app/model/global.dart';
import 'package:kpct_radio_app/model/level.dart';
import 'package:kpct_radio_app/model/recipe.dart';
import 'package:kpct_radio_app/model/unlock.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';
import 'package:kpct_radio_app_common/models/remote/play_list.dart';
import 'package:kpct_radio_app_common/models/remote/shop_item.dart';

class ReservedRepository {
  late Global _global;
  Global get global => _global;

  final List<Gear> gears;
  final Map<String, Gear> _gearMap;

  final List<Level> levels;
  final Map<int, Level> _levelMap;

  final List<Recipe> recipes;
  final Map<String, Recipe> _recipeMap;

  final List<Unlock> unlocks;
  final Map<GearTier, Unlock> _unlockMap;

  final List<Draw> draws;
  final List<PlayList> playLists;
  final List<ShopItem> shopItems;

  final List<Decomposition> decompositions;
  final Map<String, Decomposition> _decompositionMap;

  // String _collectionPath({
  //   required String type,
  // }) =>
  //     "reserved/$type/elements";

  String _collectionPath({required String type}) {
    // TODO: global, playList 테이블 처리도 완료하고 나면,
    // 기존 reserved Path는 사용하지 않도록 수정할 것.
    if (type == "global" || type == "playList") {
      return "reserved/$type/elements";
    }
    return "new_reserved/$type/elements";
  }

  ReservedRepository()
    : _gearMap = {},
      _levelMap = {},
      _recipeMap = {},
      _unlockMap = {},
      _decompositionMap = {},
      draws = List.empty(growable: true),
      gears = List.empty(growable: true),
      levels = List.empty(growable: true),
      recipes = List.empty(growable: true),
      unlocks = List.empty(growable: true),
      playLists = List.empty(growable: true),
      shopItems = List.empty(growable: true),
      decompositions = List.empty(growable: true),
      _global = Global.generateDefault();

  Gear? gear({required String? id}) => (id != null) ? _gearMap[id] : null;
  Level? level({required int? level}) =>
      (level != null) ? _levelMap[level] : null;
  Level? nextLevel({required int? level}) =>
      (level != null) ? _levelMap[level + 1] : null;
  Recipe? recipe({required String? id}) => (id != null) ? _recipeMap[id] : null;
  Unlock? unlock({required GearTier? tier}) =>
      (tier != null) ? _unlockMap[tier] : null;
  Decomposition? decomposition({required String? id}) =>
      (id != null) ? _decompositionMap[id] : null;

  Future<bool> get load async => await Future.wait([
    _loadGlobal,
    _loadDraws,
    _loadGears,
    _loadLevels,
    _loadRecipes,
    _loadUnlocks,
    _loadPlayLists,
    _loadShopItems,
    _loadDecompositions,
  ]).then((value) => !value.contains(false)).catchError((error) => false);

  Future<bool> get _loadGlobal async => await FirebaseFirestore.instance
      .doc("reserved/global")
      .withConverter(
        fromFirestore: Global.fromFirstore,
        toFirestore: Global.toFirestore,
      )
      .get(const GetOptions(source: Source.server))
      .then((value) {
        _global = value.data() ?? Global.generateDefault();
        return true;
      })
      .catchError((error, stacktrace) {
        if (kDebugMode) {
          print("❌ Global 로딩 에러: $error");
        }
        return false;
      });

  Future<bool> get _loadDraws async => await FirebaseFirestore.instance
      .collection(_collectionPath(type: "draw"))
      .withConverter(
        fromFirestore: Draw.fromFirstore,
        toFirestore: Draw.toFirestore,
      )
      .get(const GetOptions(source: Source.server))
      .then((value) {
        draws
          ..clear()
          ..addAll(List.of(value.docs.map((element) => element.data())));

        if (kDebugMode) {
          print("📊 Draw 로딩 완료: 총 ${draws.length}개");
          // for (Draw draw in draws) {
          //   print("id : ${draw.id}");
          //   print("rate : ${draw.rate}");
          //   print("drawId : ${draw.drawId}");
          //   print("max : ${draw.max}");
          //   print("mn : ${draw.mn}");
          //   print("result : ${draw.result}");
          //   print("--------------------------------");
          // }
        }

        return true;
      })
      .catchError((error) {
        if (kDebugMode) {
          print("❌ Draw 로딩 에러: $error");
        }
        return false;
      });

  Future<bool> get _loadGears async {
    try {
      final value = await FirebaseFirestore.instance
          .collection(_collectionPath(type: "gear"))
          .withConverter(
            fromFirestore: Gear.fromFirstore,
            toFirestore: Gear.toFirestore,
          )
          .get(const GetOptions(source: Source.server));

      gears
        ..clear()
        ..addAll(List.of(value.docs.map((element) => element.data())));

      _gearMap.clear();
      for (Gear gear in gears) {
        _gearMap[gear.id] = gear;
      }

      if (kDebugMode) {
        print("📊 Gear 로딩 완료: 총 ${gears.length}개");
        // for (Gear gear in gears) {
        //   print("id : ${gear.id}");
        //   print("name : ${gear.name}");
        //   print("tier : ${gear.tier}");
        //   print("socketMin : ${gear.socketMin}");
        //   print("socketMax : ${gear.socketMax}");
        //   print("staminaMax : ${gear.staminaMax}");
        //   print("staminaUse : ${gear.staminaUse}");
        //   print("luckAddrate : ${gear.luckAddrate}");
        //   print("listeningEp : ${gear.listeningEp}");
        //   print("listeningSsp : ${gear.listeningSsp}");
        //   print("category : ${gear.category}");
        //   print("gearId : ${gear.gearId}");
        //   print("icon : ${gear.icon}");
        //   print("getEXP : ${gear.getExp}");
        //   print("getEP_24hRate : ${gear.getEp24HRate}");
        //   print("getSSP_24hRate : ${gear.getSsp24HRate}");
        //   print("getSSP_Play : ${gear.getSspPlay}");
        //   print("getEP_24hAmount : ${gear.getEp24HAmount}");
        //   print("getSSP_24hAmount : ${gear.getSsp24HAmount}");
        //   print("getSSP_PlayDelay : ${gear.getSspPlayDelay}");
        //   print("getSSP_PlayAmount : ${gear.getSspPlayAmount}");
        //   print("--------------------------------");
        // }
      }

      return true;
    } catch (error) {
      if (kDebugMode) {
        print("❌ Gear 로딩 에러: $error");
      }
      return false;
    }
  }

  Future<bool> get _loadLevels async => await FirebaseFirestore.instance
      .collection(_collectionPath(type: "level"))
      .withConverter(
        fromFirestore: Level.fromFirstore,
        toFirestore: Level.toFirestore,
      )
      .get(const GetOptions(source: Source.server))
      .then((value) {
        levels
          ..clear()
          ..addAll(List.of(value.docs.map((element) => element.data())));

        _levelMap.clear();
        for (Level level in levels) {
          // _levelMap[level.id] = level;
          _levelMap[level.level] = level;
        }

        if (kDebugMode) {
          print("📊 Level 로딩 완료: 총 ${levels.length}개");
          // print("📋 레벨 목록: ${levels.map((e) => e.level).toList()}");

          // 누락된 레벨 확인 (1부터 100까지)
          final expectedLevels = List.generate(100, (index) => index + 1);
          final loadedLevels = levels.map((e) => e.level).toSet();
          final missingLevels =
              expectedLevels
                  .where((level) => !loadedLevels.contains(level))
                  .toList();

          if (missingLevels.isNotEmpty) {
            print("⚠️ 누락된 레벨: $missingLevels");
          } else {
            print("✅ 모든 레벨이 정상적으로 로딩되었습니다.");

            //   // level 순서대로 정렬
            //   final sortedLevels = levels.toList()
            //     ..sort((a, b) => a.level.compareTo(b.level));

            //   for (var element in sortedLevels) {
            //     print("id : ${element.id}");
            //     print("level : ${element.level}");
            //     print("condition1 : ${element.condition1}");
            //     print("condition2 : ${element.condition2}");
            //     print("limitSsp : ${element.limitSsp}");
            //     print("rewardSsp : ${element.rewardSsp}");
            //     print("stamina : ${element.stamina}");
            //     print("limitEp : ${element.limitEp}");
            //     print("costEp : ${element.costEp}");
            //     print("costSsp : ${element.costSsp}");
            //     print("rewardCount : ${element.rewardCount}");
            //     print("rewardEp : ${element.rewardEp}");
            //     print("exp : ${element.exp}");
            //     print("limitProbability : ${element.limitProbability}");
            //     print("--------------------------------");
            //   }
          }
        }

        return true;
      })
      .catchError((error) {
        if (kDebugMode) {
          print("❌ Level 로딩 에러: $error");
        }
        return false;
      });

  Future<bool> get _loadRecipes async => await FirebaseFirestore.instance
      .collection(_collectionPath(type: "crafting"))
      .withConverter(
        fromFirestore: Recipe.fromFirstore,
        toFirestore: Recipe.toFirestore,
      )
      .get(const GetOptions(source: Source.server))
      .then((value) {
        recipes
          ..clear()
          ..addAll(List.of(value.docs.map((element) => element.data())));

        _recipeMap.clear();
        for (Recipe recipe in recipes) {
          _recipeMap[recipe.id] = recipe;
        }

        if (kDebugMode) {
          print("📊 Crafting 로딩 완료: 총 ${recipes.length}개");
          // for (Recipe recipe in recipes) {
          //   print("id : ${recipe.id}");
          //   print("gearId : ${recipe.gearId}");
          //   print("costSsp : ${recipe.costSsp}");
          //   print("costEp : ${recipe.costEp}");
          //   print("probability : ${recipe.probability}");
          //   print("stuff1 : ${recipe.stuff1}");
          //   print("stuff2 : ${recipe.stuff2}");
          //   print("stuff3 : ${recipe.stuff3}");
          //   print("stuff4 : ${recipe.stuff4}");
          //   print("stuff5 : ${recipe.stuff5}");
          //   print("--------------------------------");
          // }
        }

        return true;
      })
      .catchError((error) {
        if (kDebugMode) {
          print("❌ Recipe 로딩 에러: $error");
        }
        return false;
      });

  Future<bool> get _loadUnlocks async => await FirebaseFirestore.instance
      .collection(_collectionPath(type: "unlock"))
      .withConverter(
        fromFirestore: Unlock.fromFirstore,
        toFirestore: Unlock.toFirestore,
      )
      .get(const GetOptions(source: Source.server))
      .then((value) {
        unlocks
          ..clear()
          ..addAll(List.of(value.docs.map((element) => element.data())))
          ..sort((lhs, rhs) => lhs.tier.index.compareTo(rhs.tier.index));

        _unlockMap.clear();
        for (Unlock unlock in unlocks) {
          _unlockMap[unlock.tier] = unlock;
        }

        if (kDebugMode) {
          print("📊 Unlock 로딩 완료: 총 ${unlocks.length}개");
          // for (Unlock unlock in unlocks) {
          //   print("tier : ${unlock.tier}");
          //   print("s1costEp : ${unlock.s1costEp}");
          //   print("s2costEp : ${unlock.s2costEp}");
          //   print("s3costEp : ${unlock.s3costEp}");
          //   print("s4costEp : ${unlock.s4costEp}");
          //   print("s5costEp : ${unlock.s5costEp}");
          //   print("s1costSsp : ${unlock.s1costSsp}");
          //   print("s2costSsp : ${unlock.s2costSsp}");
          //   print("s3costSsp : ${unlock.s3costSsp}");
          //   print("s4costSsp : ${unlock.s4costSsp}");
          //   print("s5costSsp : ${unlock.s5costSsp}");
          //   print("s1Probability : ${unlock.s1Probability}");
          //   print("s2Probability : ${unlock.s2Probability}");
          //   print("s3Probability : ${unlock.s3Probability}");
          //   print("s4Probability : ${unlock.s4Probability}");
          //   print("s5Probability : ${unlock.s5Probability}");
          //   print("--------------------------------");
          // }
        }

        return true;
      })
      .catchError((error) {
        if (kDebugMode) {
          print("❌ Unlock 로딩 에러: $error");
        }
        return false;
      });

  Future<bool> get _loadDecompositions async => await FirebaseFirestore.instance
      .collection(_collectionPath(type: "decomposition"))
      .withConverter(
        fromFirestore: Decomposition.fromFirstore,
        toFirestore: Decomposition.toFirestore,
      )
      .get(const GetOptions(source: Source.server))
      .then((value) {
        decompositions
          ..clear()
          ..addAll(List.of(value.docs.map((element) => element.data())));

        _decompositionMap.clear();
        for (Decomposition decomposition in decompositions) {
          _decompositionMap[decomposition.id] = decomposition;
        }

        if (kDebugMode) {
          print("📊 Decomposition 로딩 완료: 총 ${decompositions.length}개");
          // for (Decomposition decomposition in decompositions) {
          //   print("id : ${decomposition.id}");
          //   print("gearId : ${decomposition.gearId}");
          //   print("costEp : ${decomposition.costEp}");
          //   print("costSsp : ${decomposition.costSsp}");
          //   print("resultMax : ${decomposition.resultMax}");
          //   print("resultMin : ${decomposition.resultMin}");
          //   print("result1 : ${decomposition.result1}");
          //   print("result2 : ${decomposition.result2}");
          //   print("result3 : ${decomposition.result3}");
          //   print("result4 : ${decomposition.result4}");
          //   print("result5 : ${decomposition.result5}");
          //   print("result6 : ${decomposition.result6}");
          //   print("result7 : ${decomposition.result7}");
          //   print("result8 : ${decomposition.result8}");
          //   print("--------------------------------");
          // }
        }

        return true;
      })
      .catchError((error) {
        if (kDebugMode) {
          print("❌ Decomposition 로딩 에러: $error");
        }
        return false;
      });

  Future<bool> get _loadPlayLists async => await FirebaseFirestore.instance
      .collection(_collectionPath(type: "playList"))
      .withConverter(
        fromFirestore: PlayList.fromFirstore,
        toFirestore: PlayList.toFirestore,
      )
      .get(const GetOptions(source: Source.server))
      .then((value) {
        playLists
          ..clear()
          ..addAll(List.of(value.docs.map((element) => element.data())));

        return true;
      })
      .catchError((error) {
        if (kDebugMode) {
          print("❌ PlayList 로딩 에러: $error");
        }
        return false;
      });

  Future<bool> get _loadShopItems async => await FirebaseFirestore.instance
      .collection(_collectionPath(type: "shop"))
      .get(const GetOptions(source: Source.server))
      .then((value) {
        // 변환된 데이터 로딩
        final convertedDocs =
            value.docs.map((doc) => ShopItem.fromFirstore(doc, null)).toList();

        shopItems
          ..clear()
          ..addAll(convertedDocs);

        if (kDebugMode) {
          print("📊 ShopItem 로딩 완료: 총 ${shopItems.length}개");
          // for (ShopItem shopItem in shopItems) {
          //   print("id : ${shopItem.id}");
          //   print("costEp : ${shopItem.costEp}");
          //   print("name : ${shopItem.name}");
          //   print("icon : ${shopItem.icon}");
          //   print("buyLimit : ${shopItem.buyLimit}");
          //   print("costSsp : ${shopItem.costSsp}");
          //   print("desc : ${shopItem.desc}");
          //   print("effectDuration : ${shopItem.effectDuration}");
          //   print("--------------------------------");
          // }
        }

        return true;
      })
      .catchError((error) {
        if (kDebugMode) {
          print("❌ ShopItem 로딩 에러: $error");
        }
        App.instance.log.d(error);
        return false;
      });
}
