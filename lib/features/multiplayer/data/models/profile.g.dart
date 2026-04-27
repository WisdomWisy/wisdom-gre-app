// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: json['id'] as String,
  username: json['username'] as String,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  arenaWins: (json['arena_wins'] as num?)?.toInt(),
  arenaLosses: (json['arena_losses'] as num?)?.toInt(),
  currentStreak: (json['current_streak'] as num?)?.toInt(),
  dailyDuelsCount: (json['daily_duels_count'] as num?)?.toInt() ?? 0,
  lastDuelDate:
      json['last_duel_date'] == null
          ? null
          : DateTime.parse(json['last_duel_date'] as String),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'avatar_url': instance.avatarUrl,
  'arena_wins': instance.arenaWins,
  'arena_losses': instance.arenaLosses,
  'current_streak': instance.currentStreak,
  'daily_duels_count': instance.dailyDuelsCount,
  'last_duel_date': instance.lastDuelDate?.toIso8601String(),
};
