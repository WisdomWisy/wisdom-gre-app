import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String username,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? email,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'arena_wins') int? arenaWins,
    @JsonKey(name: 'arena_losses') int? arenaLosses,
    @JsonKey(name: 'current_streak') int? currentStreak,
    @JsonKey(name: 'daily_duels_count') @Default(0) int dailyDuelsCount,
    @JsonKey(name: 'last_duel_date') DateTime? lastDuelDate,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}
