import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wisdom_gre_app/features/multiplayer/data/models/profile.dart';

part 'duel_participant.freezed.dart';
part 'duel_participant.g.dart';

@freezed
abstract class DuelParticipant with _$DuelParticipant {
  const factory DuelParticipant({
    required String id,
    @JsonKey(name: 'duel_id') required String duelId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'joined_at') required DateTime joinedAt,
    
    // Joined profile data (via Supabase relational query)
    Profile? profiles, 
  }) = _DuelParticipant;

  factory DuelParticipant.fromJson(Map<String, dynamic> json) => _$DuelParticipantFromJson(json);
}
