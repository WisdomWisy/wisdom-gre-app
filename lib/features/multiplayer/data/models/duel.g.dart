// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Duel _$DuelFromJson(Map<String, dynamic> json) => _Duel(
  id: json['id'] as String,
  roomCode: json['room_code'] as String,
  hostId: json['host_id'] as String,
  maxPlayers: (json['max_players'] as num?)?.toInt() ?? 10,
  status: json['status'] as String? ?? 'waiting',
  createdAt: DateTime.parse(json['created_at'] as String),
  participants:
      (json['duel_participants'] as List<dynamic>?)
          ?.map((e) => DuelParticipant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$DuelToJson(_Duel instance) => <String, dynamic>{
  'id': instance.id,
  'room_code': instance.roomCode,
  'host_id': instance.hostId,
  'max_players': instance.maxPlayers,
  'status': instance.status,
  'created_at': instance.createdAt.toIso8601String(),
  'duel_participants': instance.participants,
};
