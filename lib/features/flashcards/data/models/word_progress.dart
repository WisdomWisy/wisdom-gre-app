import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_progress.freezed.dart';
part 'word_progress.g.dart';

@freezed
abstract class WordProgress with _$WordProgress {
  const factory WordProgress({
    required String wordId,
    @Default(2.5) double easinessFactor,
    @Default(0) int interval,
    @Default(0) int repetitions,
    required DateTime nextReviewDate,
  }) = _WordProgress;

  factory WordProgress.fromJson(Map<String, dynamic> json) => _$WordProgressFromJson(json);
}
