// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duel_participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DuelParticipant _$DuelParticipantFromJson(Map<String, dynamic> json) =>
    _DuelParticipant(
      id: json['id'] as String,
      duelId: json['duel_id'] as String,
      userId: json['user_id'] as String,
      joinedAt: DateTime.parse(json['joined_at'] as String),
      profiles:
          json['profiles'] == null
              ? null
              : Profile.fromJson(json['profiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DuelParticipantToJson(_DuelParticipant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'duel_id': instance.duelId,
      'user_id': instance.userId,
      'joined_at': instance.joinedAt.toIso8601String(),
      'profiles': instance.profiles,
    };
