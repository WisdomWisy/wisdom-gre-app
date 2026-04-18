import 'package:freezed_annotation/freezed_annotation.dart';

part 'gre_word.freezed.dart';
part 'gre_word.g.dart';

@freezed
abstract class GreWord with _$GreWord {
  const factory GreWord({
    @JsonKey(name: 'original_input') required String originalInput,
    required String word,
    required String phonetic,
    required String difficulty,
    @JsonKey(name: 'part_of_speech') required String partOfSpeech,
    @JsonKey(name: 'definition_en') required String definitionEn,
    required WordTranslations translations,
    required List<String> synonyms,
    required List<String> antonyms,
    @JsonKey(name: 'gre_context_sentences') required List<String> greContextSentences,
    required WordMnemonics mnemonics,
    required WordEtymology etymology,
    @JsonKey(name: 'audio_file') required String audioFile,
  }) = _GreWord;

  factory GreWord.fromJson(Map<String, dynamic> json) => _$GreWordFromJson(json);
}

@freezed
abstract class WordTranslations with _$WordTranslations {
  const factory WordTranslations({
    required String fr,
    required String es,
  }) = _WordTranslations;

  factory WordTranslations.fromJson(Map<String, dynamic> json) => _$WordTranslationsFromJson(json);
}

@freezed
abstract class WordMnemonics with _$WordMnemonics {
  const factory WordMnemonics({
    required String en,
    required String fr,
    required String es,
  }) = _WordMnemonics;

  factory WordMnemonics.fromJson(Map<String, dynamic> json) => _$WordMnemonicsFromJson(json);
}

@freezed
abstract class WordEtymology with _$WordEtymology {
  const factory WordEtymology({
    required String en,
    required String fr,
    required String es,
  }) = _WordEtymology;

  factory WordEtymology.fromJson(Map<String, dynamic> json) => _$WordEtymologyFromJson(json);
}
