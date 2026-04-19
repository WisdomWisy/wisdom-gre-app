// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WordProgress _$WordProgressFromJson(Map<String, dynamic> json) =>
    _WordProgress(
      wordId: json['wordId'] as String,
      easinessFactor: (json['easinessFactor'] as num?)?.toDouble() ?? 2.5,
      interval: (json['interval'] as num?)?.toInt() ?? 0,
      repetitions: (json['repetitions'] as num?)?.toInt() ?? 0,
      nextReviewDate: DateTime.parse(json['nextReviewDate'] as String),
      lastReviewDate:
          json['lastReviewDate'] == null
              ? null
              : DateTime.parse(json['lastReviewDate'] as String),
    );

Map<String, dynamic> _$WordProgressToJson(_WordProgress instance) =>
    <String, dynamic>{
      'wordId': instance.wordId,
      'easinessFactor': instance.easinessFactor,
      'interval': instance.interval,
      'repetitions': instance.repetitions,
      'nextReviewDate': instance.nextReviewDate.toIso8601String(),
      'lastReviewDate': instance.lastReviewDate?.toIso8601String(),
    };
