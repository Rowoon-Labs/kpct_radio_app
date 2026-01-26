// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
  id: json['id'] as String,
  uid: json['uid'] as String,
  nickName: json['nickName'] as String,
  content: json['content'] as String,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$$ChatImplToJson(_$ChatImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'nickName': instance.nickName,
      'content': instance.content,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
