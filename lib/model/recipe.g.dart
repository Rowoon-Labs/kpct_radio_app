// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImpl _$$RecipeImplFromJson(Map<String, dynamic> json) => _$RecipeImpl(
      id: json['id'] as String,
      gearId: json['gear_ID'] as String,
      costSsp: const StringToIntConverter().fromJson(json['cost_SSP']),
      costEp: const StringToIntConverter().fromJson(json['cost_EP']),
      probability: const StringToIntConverter().fromJson(json['probability']),
      stuff1: json['stuff1'] as String?,
      stuff2: json['stuff2'] as String?,
      stuff3: json['stuff3'] as String?,
      stuff4: json['stuff4'] as String?,
      stuff5: json['stuff5'] as String?,
    );

Map<String, dynamic> _$$RecipeImplToJson(_$RecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gear_ID': instance.gearId,
      'cost_SSP': const StringToIntConverter().toJson(instance.costSsp),
      'cost_EP': const StringToIntConverter().toJson(instance.costEp),
      'probability': const StringToIntConverter().toJson(instance.probability),
      'stuff1': instance.stuff1,
      'stuff2': instance.stuff2,
      'stuff3': instance.stuff3,
      'stuff4': instance.stuff4,
      'stuff5': instance.stuff5,
    };
