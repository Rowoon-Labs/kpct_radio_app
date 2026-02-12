// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DrawImpl _$$DrawImplFromJson(Map<String, dynamic> json) => _$DrawImpl(
  id: json['id'] as String,
  rate: const StringToIntConverter().fromJson(json['Rate']),
  drawId: $enumDecode(_$DrawIdEnumMap, json['draw_ID']),
  max: const StringToIntConverter().fromJson(json['max']),
  mn: const StringToIntConverter().fromJson(json['mn']),
  result: json['result'] as String,
);

Map<String, dynamic> _$$DrawImplToJson(_$DrawImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'Rate': const StringToIntConverter().toJson(instance.rate),
      'draw_ID': _$DrawIdEnumMap[instance.drawId]!,
      'max': const StringToIntConverter().toJson(instance.max),
      'mn': const StringToIntConverter().toJson(instance.mn),
      'result': instance.result,
    };

const _$DrawIdEnumMap = {
  DrawId.freeRadio: 'free_radio',
  DrawId.staminaRadio: 'stamina_radio',
  DrawId.sspRadio: 'ssp_radio',
  DrawId.freeLg: 'free_lg',
  DrawId.staminaLg: 'stamina_lg',
  DrawId.sspLg: 'ssp_lg',
  DrawId.epBox: 'ep_box',
  DrawId.sspBoxEx: 'ssp_box_ex',
  DrawId.epBoxEx: 'ep_box_ex',
};
