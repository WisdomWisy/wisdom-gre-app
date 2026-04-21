import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wisdom_gre_app/features/multiplayer/data/models/duel_participant.dart';

part 'duel.freezed.dart';
part 'duel.g.dart';

@freezed
abstract class Duel with _$Duel {
  const factory Duel({
    required String id,
    @JsonKey(name: 'room_code') required String roomCode,
    @JsonKey(name: 'host_id') required String hostId,
    @JsonKey(name: 'max_players') @Default(10) int maxPlayers,
    @Default('waiting') String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,

    // Relational join data
    @JsonKey(name: 'duel_participants') @Default([]) List<DuelParticipant> participants,
  }) = _Duel;

  factory Duel.fromJson(Map<String, dynamic> json) => _$DuelFromJson(json);
}
