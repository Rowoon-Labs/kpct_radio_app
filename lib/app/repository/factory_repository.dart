import 'dart:math';

import 'package:kpct_radio_app/app/app.dart';
import 'package:kpct_radio_app/model/decomposition.dart';
import 'package:kpct_radio_app/model/draw.dart';
import 'package:kpct_radio_app_common/app/misc/utils.dart';
import 'package:kpct_radio_app_common/models/remote/gear.dart';

class FactoryException implements Exception {
  final String message;

  FactoryException({required this.message});
}

class FactoryRepository {
  final Random random;

  FactoryRepository() : random = Random(koreaNow().millisecondsSinceEpoch);

  List<Equipment> _generateBoxRewardEquipments({required List<Draw> draws}) {
    if (draws.isNotEmpty) {
      final int pickedDrawIndex = randomIndexFromRateList(
        rates: draws.map((element) => element.rate).toList(),
      );

      final Draw draw = draws[pickedDrawIndex];

      final int count = _randomValueFromInclusiveMinMax(
        min: draw.mn,
        max: draw.max,
      );

      return List.generate(
        count,
        (index) => App.instance.factory.generateEquipment(gearId: draw.result),
      );
    } else {
      return [];
    }
  }

  List<Equipment> generateBoxRewardEquipments({required DrawId drawId}) => [
    ..._generateBoxRewardEquipments(
      draws: List.of(
        App.instance.reserved.draws.where(
          (element) => (element.drawId == drawId),
        ),
      ),
    ),

    // About Luck
    if (true) ...[
      ..._generateBoxRewardEquipments(
        draws: List.of(switch (drawId) {
          DrawId.sspRadio || DrawId.sspLg => App.instance.reserved.draws.where(
            (element) => (element.drawId == DrawId.sspBoxEx),
          ),
          DrawId.epBox => App.instance.reserved.draws.where(
            (element) => (element.drawId == DrawId.epBoxEx),
          ),
          _ => [],
        }),
      ),
    ],
  ];

  Equipment generateEquipment({required String gearId}) {
    final Gear? gear = App.instance.reserved.gear(id: gearId);

    if (gear != null) {
      final int numberOfSocket = _randomValueFromInclusiveMinMax(
        min: gear.socketMin,
        max: gear.socketMax,
      );

      return Equipment(
        id: "",
        gearId: gearId,
        category: gear.category,
        mounted: false,
        sockets: List.generate(
          numberOfSocket,
          (index) => const Socket(
            gearId: null,
            getExp: 0,
            staminaUse: 0,
            listeningEp: 0,
            listeningSsp: 0,
          ),
        ),
      );
    } else {
      throw FactoryException(message: "일치하는 Gear가 없습니다");
    }
  }

  int _randomValueFromInclusiveMinMax({required int? min, required int? max}) =>
      (min ?? 0) + random.nextInt((max ?? 0) - (min ?? 0) + 1);

  int randomIndexFromRateList({required List<int> rates}) {
    final int totalRate = rates.fold(
      0,
      (previousValue, element) => (previousValue + element),
    );

    final int randomRate = random.nextInt(totalRate);

    int beginOfRateRange = 0;

    for (int index = 0; index < rates.length; index++) {
      final int endOfRateRange = beginOfRateRange + rates[index];

      if ((beginOfRateRange <= randomRate) && (randomRate < endOfRateRange)) {
        return index;
      } else {
        beginOfRateRange = endOfRateRange;
      }
    }

    return rates.length - 1;
  }

  List<Equipment> generateDecomposedEquipments({
    required Decomposition decomposition,
  }) {
    final List<String> resultGearIds = [
      if (decomposition.result1 != null) ...[decomposition.result1!],
      if (decomposition.result2 != null) ...[decomposition.result2!],
      if (decomposition.result3 != null) ...[decomposition.result3!],
      if (decomposition.result4 != null) ...[decomposition.result4!],
      if (decomposition.result5 != null) ...[decomposition.result5!],
      if (decomposition.result6 != null) ...[decomposition.result6!],
      if (decomposition.result7 != null) ...[decomposition.result7!],
      if (decomposition.result8 != null) ...[decomposition.result8!],
    ]..shuffle(random);

    final int resultCount = _randomValueFromInclusiveMinMax(
      min: decomposition.resultMin,
      max: decomposition.resultMax,
    );

    if (resultCount <= resultGearIds.length) {
      return List.of(
        resultGearIds.map((element) => generateEquipment(gearId: element)),
      );
    } else {
      throw FactoryException(message: "후보 Gear가 충분치 않습니다");
    }
  }
}
