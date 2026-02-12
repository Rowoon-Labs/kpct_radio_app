import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/app/misc/extensions.dart';
import 'package:kpct_radio_app_common/models/remote/custom_user.dart';

part 'listening_reward_modal_event.dart';
part 'listening_reward_modal_state.dart';
part 'listening_reward_modal_bloc.freezed.dart';

class ListeningRewardModalBloc
    extends Bloc<ListeningRewardModalEvent, ListeningRewardModalState> {
  ListeningRewardModalBloc() : super(const ListeningRewardModalState()) {
    on<ListeningRewardModalEvent>((event, emit) async {
      await event.map(
        initialize: (event) async {
          final DocumentReference<CustomUser> userReference = FirebaseFirestore
              .instance
              .collection("users")
              .doc(App.instance.auth.customUser?.id)
              .withConverter(
                fromFirestore: CustomUser.fromFirstore,
                toFirestore: CustomUser.toFirestore,
              );

          final ({int rewardSsp, int rewardEp})?
          result = await FirebaseFirestore.instance.runTransaction<
            ({int rewardSsp, int rewardEp})?
          >((transaction) async {
            final DocumentSnapshot<CustomUser> snapshot = await transaction
                .get<CustomUser>(userReference);

            final CustomUser? user = snapshot.exists ? snapshot.data() : null;

            if (user != null) {
              if (user.listeningGauge >=
                  App.instance.reserved.global.listeningGauge) {
                final int rewardSsp = user.adjustedListeningSsp(
                  App.instance.reserved.global.listeningGetSsp,
                );
                final int rewardEp =
                    user.inAdjustedLuckRange(
                          App.instance.reserved.global.luck,
                          user.adjustedListeningEpProb(
                            App.instance.reserved.global.listeningGetEpProba,
                          ),
                        )
                        ? user.adjustedListeningEp(
                          App.instance.reserved.global.listeningGetEp,
                        )
                        : 0;

                transaction.update(userReference, {
                  "listeningGauge":
                      (user.listeningGauge -
                              App.instance.reserved.global.listeningGauge)
                          .clamp2(),
                  "accumulatedRadioSsp": FieldValue.increment(rewardSsp),
                  "accumulatedEp": FieldValue.increment(rewardEp),
                  "radioSsp": FieldValue.increment(rewardSsp),
                  "ep": FieldValue.increment(rewardEp),
                });

                return (rewardSsp: rewardSsp, rewardEp: rewardEp);
              } else {
                return null;
              }
            } else {
              return null;
            }
          });

          if (result != null) {
            emit(
              state.copyWith(
                status: ListeningRewardModalStatus.success,
                result: "",
                rewardSsp: result.rewardSsp,
                rewardEp: result.rewardEp,
                initialized: true,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: ListeningRewardModalStatus.fail,
                result: "ERROR",
                initialized: true,
              ),
            );
          }

          emit(state.copyWith(initialized: true));
        },
      );
    });
  }
}
