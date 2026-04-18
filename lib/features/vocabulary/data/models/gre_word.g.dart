// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gre_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GreWord _$GreWordFromJson(Map<String, dynamic> json) => _GreWord(
  originalInput: json['original_input'] as String,
  word: json['word'] as String,
  phonetic: json['phonetic'] as String,
  difficulty: json['difficulty'] as String,
  partOfSpeech: json['part_of_speech'] as String,
  definitionEn: json['definition_en'] as String,
  translations: WordTranslations.fromJson(
    json['translations'] as Map<String, dynamic>,
  ),
  synonyms:
      (json['synonyms'] as List<dynamic>).map((e) => e as String).toList(),
  antonyms:
      (json['antonyms'] as List<dynamic>).map((e) => e as String).toList(),
  greContextSentences:
      (json['gre_context_sentences'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  mnemonics: WordMnemonics.fromJson(json['mnemonics'] as Map<String, dynamic>),
  etymology: WordEtymology.fromJson(json['etymology'] as Map<String, dynamic>),
  audioFile: json['audio_file'] as String,
);

Map<String, dynamic> _$GreWordToJson(_GreWord instance) => <String, dynamic>{
  'original_input': instance.originalInput,
  'word': instance.word,
  'phonetic': instance.phonetic,
  'difficulty': instance.difficulty,
  'part_of_speech': instance.partOfSpeech,
  'definition_en': instance.definitionEn,
  'translations': instance.translations,
  'synonyms': instance.synonyms,
  'antonyms': instance.antonyms,
  'gre_context_sentences': instance.greContextSentences,
  'mnemonics': instance.mnemonics,
  'etymology': instance.etymology,
  'audio_file': instance.audioFile,
};

_WordTranslations _$WordTranslationsFromJson(Map<String, dynamic> json) =>
    _WordTranslations(fr: json['fr'] as String, es: json['es'] as String);

Map<String, dynamic> _$WordTranslationsToJson(_WordTranslations instance) =>
    <String, dynamic>{'fr': instance.fr, 'es': instance.es};

_WordMnemonics _$WordMnemonicsFromJson(Map<String, dynamic> json) =>
    _WordMnemonics(
      en: json['en'] as String,
      fr: json['fr'] as String,
      es: json['es'] as String,
    );

Map<String, dynamic> _$WordMnemonicsToJson(_WordMnemonics instance) =>
    <String, dynamic>{'en': instance.en, 'fr': instance.fr, 'es': instance.es};

_WordEtymology _$WordEtymologyFromJson(Map<String, dynamic> json) =>
    _WordEtymology(
      en: json['en'] as String,
      fr: json['fr'] as String,
      es: json['es'] as String,
    );

Map<String, dynamic> _$WordEtymologyToJson(_WordEtymology instance) =>
    <String, dynamic>{'en': instance.en, 'fr': instance.fr, 'es': instance.es};
