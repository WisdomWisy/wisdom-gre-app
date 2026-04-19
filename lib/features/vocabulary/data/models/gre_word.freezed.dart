// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gre_word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GreWord {

@JsonKey(name: 'original_input') String get originalInput; String get word; String get phonetic; String get difficulty;@JsonKey(name: 'part_of_speech') String get partOfSpeech;@JsonKey(name: 'definition_en') String get definitionEn; WordTranslations get translations; List<String> get synonyms; List<String> get antonyms;@JsonKey(name: 'gre_context_sentences') List<String> get greContextSentences; WordMnemonics get mnemonics; WordEtymology get etymology;@JsonKey(name: 'audio_file') String get audioFile;@JsonKey(name: 'practice_questions') PracticeQuestions? get practiceQuestions;
/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GreWordCopyWith<GreWord> get copyWith => _$GreWordCopyWithImpl<GreWord>(this as GreWord, _$identity);

  /// Serializes this GreWord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GreWord&&(identical(other.originalInput, originalInput) || other.originalInput == originalInput)&&(identical(other.word, word) || other.word == word)&&(identical(other.phonetic, phonetic) || other.phonetic == phonetic)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.partOfSpeech, partOfSpeech) || other.partOfSpeech == partOfSpeech)&&(identical(other.definitionEn, definitionEn) || other.definitionEn == definitionEn)&&(identical(other.translations, translations) || other.translations == translations)&&const DeepCollectionEquality().equals(other.synonyms, synonyms)&&const DeepCollectionEquality().equals(other.antonyms, antonyms)&&const DeepCollectionEquality().equals(other.greContextSentences, greContextSentences)&&(identical(other.mnemonics, mnemonics) || other.mnemonics == mnemonics)&&(identical(other.etymology, etymology) || other.etymology == etymology)&&(identical(other.audioFile, audioFile) || other.audioFile == audioFile)&&(identical(other.practiceQuestions, practiceQuestions) || other.practiceQuestions == practiceQuestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originalInput,word,phonetic,difficulty,partOfSpeech,definitionEn,translations,const DeepCollectionEquality().hash(synonyms),const DeepCollectionEquality().hash(antonyms),const DeepCollectionEquality().hash(greContextSentences),mnemonics,etymology,audioFile,practiceQuestions);

@override
String toString() {
  return 'GreWord(originalInput: $originalInput, word: $word, phonetic: $phonetic, difficulty: $difficulty, partOfSpeech: $partOfSpeech, definitionEn: $definitionEn, translations: $translations, synonyms: $synonyms, antonyms: $antonyms, greContextSentences: $greContextSentences, mnemonics: $mnemonics, etymology: $etymology, audioFile: $audioFile, practiceQuestions: $practiceQuestions)';
}


}

/// @nodoc
abstract mixin class $GreWordCopyWith<$Res>  {
  factory $GreWordCopyWith(GreWord value, $Res Function(GreWord) _then) = _$GreWordCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'original_input') String originalInput, String word, String phonetic, String difficulty,@JsonKey(name: 'part_of_speech') String partOfSpeech,@JsonKey(name: 'definition_en') String definitionEn, WordTranslations translations, List<String> synonyms, List<String> antonyms,@JsonKey(name: 'gre_context_sentences') List<String> greContextSentences, WordMnemonics mnemonics, WordEtymology etymology,@JsonKey(name: 'audio_file') String audioFile,@JsonKey(name: 'practice_questions') PracticeQuestions? practiceQuestions
});


$WordTranslationsCopyWith<$Res> get translations;$WordMnemonicsCopyWith<$Res> get mnemonics;$WordEtymologyCopyWith<$Res> get etymology;$PracticeQuestionsCopyWith<$Res>? get practiceQuestions;

}
/// @nodoc
class _$GreWordCopyWithImpl<$Res>
    implements $GreWordCopyWith<$Res> {
  _$GreWordCopyWithImpl(this._self, this._then);

  final GreWord _self;
  final $Res Function(GreWord) _then;

/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalInput = null,Object? word = null,Object? phonetic = null,Object? difficulty = null,Object? partOfSpeech = null,Object? definitionEn = null,Object? translations = null,Object? synonyms = null,Object? antonyms = null,Object? greContextSentences = null,Object? mnemonics = null,Object? etymology = null,Object? audioFile = null,Object? practiceQuestions = freezed,}) {
  return _then(_self.copyWith(
originalInput: null == originalInput ? _self.originalInput : originalInput // ignore: cast_nullable_to_non_nullable
as String,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,phonetic: null == phonetic ? _self.phonetic : phonetic // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,partOfSpeech: null == partOfSpeech ? _self.partOfSpeech : partOfSpeech // ignore: cast_nullable_to_non_nullable
as String,definitionEn: null == definitionEn ? _self.definitionEn : definitionEn // ignore: cast_nullable_to_non_nullable
as String,translations: null == translations ? _self.translations : translations // ignore: cast_nullable_to_non_nullable
as WordTranslations,synonyms: null == synonyms ? _self.synonyms : synonyms // ignore: cast_nullable_to_non_nullable
as List<String>,antonyms: null == antonyms ? _self.antonyms : antonyms // ignore: cast_nullable_to_non_nullable
as List<String>,greContextSentences: null == greContextSentences ? _self.greContextSentences : greContextSentences // ignore: cast_nullable_to_non_nullable
as List<String>,mnemonics: null == mnemonics ? _self.mnemonics : mnemonics // ignore: cast_nullable_to_non_nullable
as WordMnemonics,etymology: null == etymology ? _self.etymology : etymology // ignore: cast_nullable_to_non_nullable
as WordEtymology,audioFile: null == audioFile ? _self.audioFile : audioFile // ignore: cast_nullable_to_non_nullable
as String,practiceQuestions: freezed == practiceQuestions ? _self.practiceQuestions : practiceQuestions // ignore: cast_nullable_to_non_nullable
as PracticeQuestions?,
  ));
}
/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordTranslationsCopyWith<$Res> get translations {
  
  return $WordTranslationsCopyWith<$Res>(_self.translations, (value) {
    return _then(_self.copyWith(translations: value));
  });
}/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordMnemonicsCopyWith<$Res> get mnemonics {
  
  return $WordMnemonicsCopyWith<$Res>(_self.mnemonics, (value) {
    return _then(_self.copyWith(mnemonics: value));
  });
}/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordEtymologyCopyWith<$Res> get etymology {
  
  return $WordEtymologyCopyWith<$Res>(_self.etymology, (value) {
    return _then(_self.copyWith(etymology: value));
  });
}/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeQuestionsCopyWith<$Res>? get practiceQuestions {
    if (_self.practiceQuestions == null) {
    return null;
  }

  return $PracticeQuestionsCopyWith<$Res>(_self.practiceQuestions!, (value) {
    return _then(_self.copyWith(practiceQuestions: value));
  });
}
}


/// Adds pattern-matching-related methods to [GreWord].
extension GreWordPatterns on GreWord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GreWord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GreWord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GreWord value)  $default,){
final _that = this;
switch (_that) {
case _GreWord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GreWord value)?  $default,){
final _that = this;
switch (_that) {
case _GreWord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'original_input')  String originalInput,  String word,  String phonetic,  String difficulty, @JsonKey(name: 'part_of_speech')  String partOfSpeech, @JsonKey(name: 'definition_en')  String definitionEn,  WordTranslations translations,  List<String> synonyms,  List<String> antonyms, @JsonKey(name: 'gre_context_sentences')  List<String> greContextSentences,  WordMnemonics mnemonics,  WordEtymology etymology, @JsonKey(name: 'audio_file')  String audioFile, @JsonKey(name: 'practice_questions')  PracticeQuestions? practiceQuestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GreWord() when $default != null:
return $default(_that.originalInput,_that.word,_that.phonetic,_that.difficulty,_that.partOfSpeech,_that.definitionEn,_that.translations,_that.synonyms,_that.antonyms,_that.greContextSentences,_that.mnemonics,_that.etymology,_that.audioFile,_that.practiceQuestions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'original_input')  String originalInput,  String word,  String phonetic,  String difficulty, @JsonKey(name: 'part_of_speech')  String partOfSpeech, @JsonKey(name: 'definition_en')  String definitionEn,  WordTranslations translations,  List<String> synonyms,  List<String> antonyms, @JsonKey(name: 'gre_context_sentences')  List<String> greContextSentences,  WordMnemonics mnemonics,  WordEtymology etymology, @JsonKey(name: 'audio_file')  String audioFile, @JsonKey(name: 'practice_questions')  PracticeQuestions? practiceQuestions)  $default,) {final _that = this;
switch (_that) {
case _GreWord():
return $default(_that.originalInput,_that.word,_that.phonetic,_that.difficulty,_that.partOfSpeech,_that.definitionEn,_that.translations,_that.synonyms,_that.antonyms,_that.greContextSentences,_that.mnemonics,_that.etymology,_that.audioFile,_that.practiceQuestions);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'original_input')  String originalInput,  String word,  String phonetic,  String difficulty, @JsonKey(name: 'part_of_speech')  String partOfSpeech, @JsonKey(name: 'definition_en')  String definitionEn,  WordTranslations translations,  List<String> synonyms,  List<String> antonyms, @JsonKey(name: 'gre_context_sentences')  List<String> greContextSentences,  WordMnemonics mnemonics,  WordEtymology etymology, @JsonKey(name: 'audio_file')  String audioFile, @JsonKey(name: 'practice_questions')  PracticeQuestions? practiceQuestions)?  $default,) {final _that = this;
switch (_that) {
case _GreWord() when $default != null:
return $default(_that.originalInput,_that.word,_that.phonetic,_that.difficulty,_that.partOfSpeech,_that.definitionEn,_that.translations,_that.synonyms,_that.antonyms,_that.greContextSentences,_that.mnemonics,_that.etymology,_that.audioFile,_that.practiceQuestions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GreWord implements GreWord {
  const _GreWord({@JsonKey(name: 'original_input') required this.originalInput, required this.word, required this.phonetic, required this.difficulty, @JsonKey(name: 'part_of_speech') required this.partOfSpeech, @JsonKey(name: 'definition_en') required this.definitionEn, required this.translations, required final  List<String> synonyms, required final  List<String> antonyms, @JsonKey(name: 'gre_context_sentences') required final  List<String> greContextSentences, required this.mnemonics, required this.etymology, @JsonKey(name: 'audio_file') required this.audioFile, @JsonKey(name: 'practice_questions') this.practiceQuestions}): _synonyms = synonyms,_antonyms = antonyms,_greContextSentences = greContextSentences;
  factory _GreWord.fromJson(Map<String, dynamic> json) => _$GreWordFromJson(json);

@override@JsonKey(name: 'original_input') final  String originalInput;
@override final  String word;
@override final  String phonetic;
@override final  String difficulty;
@override@JsonKey(name: 'part_of_speech') final  String partOfSpeech;
@override@JsonKey(name: 'definition_en') final  String definitionEn;
@override final  WordTranslations translations;
 final  List<String> _synonyms;
@override List<String> get synonyms {
  if (_synonyms is EqualUnmodifiableListView) return _synonyms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_synonyms);
}

 final  List<String> _antonyms;
@override List<String> get antonyms {
  if (_antonyms is EqualUnmodifiableListView) return _antonyms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_antonyms);
}

 final  List<String> _greContextSentences;
@override@JsonKey(name: 'gre_context_sentences') List<String> get greContextSentences {
  if (_greContextSentences is EqualUnmodifiableListView) return _greContextSentences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_greContextSentences);
}

@override final  WordMnemonics mnemonics;
@override final  WordEtymology etymology;
@override@JsonKey(name: 'audio_file') final  String audioFile;
@override@JsonKey(name: 'practice_questions') final  PracticeQuestions? practiceQuestions;

/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GreWordCopyWith<_GreWord> get copyWith => __$GreWordCopyWithImpl<_GreWord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GreWordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GreWord&&(identical(other.originalInput, originalInput) || other.originalInput == originalInput)&&(identical(other.word, word) || other.word == word)&&(identical(other.phonetic, phonetic) || other.phonetic == phonetic)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.partOfSpeech, partOfSpeech) || other.partOfSpeech == partOfSpeech)&&(identical(other.definitionEn, definitionEn) || other.definitionEn == definitionEn)&&(identical(other.translations, translations) || other.translations == translations)&&const DeepCollectionEquality().equals(other._synonyms, _synonyms)&&const DeepCollectionEquality().equals(other._antonyms, _antonyms)&&const DeepCollectionEquality().equals(other._greContextSentences, _greContextSentences)&&(identical(other.mnemonics, mnemonics) || other.mnemonics == mnemonics)&&(identical(other.etymology, etymology) || other.etymology == etymology)&&(identical(other.audioFile, audioFile) || other.audioFile == audioFile)&&(identical(other.practiceQuestions, practiceQuestions) || other.practiceQuestions == practiceQuestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,originalInput,word,phonetic,difficulty,partOfSpeech,definitionEn,translations,const DeepCollectionEquality().hash(_synonyms),const DeepCollectionEquality().hash(_antonyms),const DeepCollectionEquality().hash(_greContextSentences),mnemonics,etymology,audioFile,practiceQuestions);

@override
String toString() {
  return 'GreWord(originalInput: $originalInput, word: $word, phonetic: $phonetic, difficulty: $difficulty, partOfSpeech: $partOfSpeech, definitionEn: $definitionEn, translations: $translations, synonyms: $synonyms, antonyms: $antonyms, greContextSentences: $greContextSentences, mnemonics: $mnemonics, etymology: $etymology, audioFile: $audioFile, practiceQuestions: $practiceQuestions)';
}


}

/// @nodoc
abstract mixin class _$GreWordCopyWith<$Res> implements $GreWordCopyWith<$Res> {
  factory _$GreWordCopyWith(_GreWord value, $Res Function(_GreWord) _then) = __$GreWordCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'original_input') String originalInput, String word, String phonetic, String difficulty,@JsonKey(name: 'part_of_speech') String partOfSpeech,@JsonKey(name: 'definition_en') String definitionEn, WordTranslations translations, List<String> synonyms, List<String> antonyms,@JsonKey(name: 'gre_context_sentences') List<String> greContextSentences, WordMnemonics mnemonics, WordEtymology etymology,@JsonKey(name: 'audio_file') String audioFile,@JsonKey(name: 'practice_questions') PracticeQuestions? practiceQuestions
});


@override $WordTranslationsCopyWith<$Res> get translations;@override $WordMnemonicsCopyWith<$Res> get mnemonics;@override $WordEtymologyCopyWith<$Res> get etymology;@override $PracticeQuestionsCopyWith<$Res>? get practiceQuestions;

}
/// @nodoc
class __$GreWordCopyWithImpl<$Res>
    implements _$GreWordCopyWith<$Res> {
  __$GreWordCopyWithImpl(this._self, this._then);

  final _GreWord _self;
  final $Res Function(_GreWord) _then;

/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalInput = null,Object? word = null,Object? phonetic = null,Object? difficulty = null,Object? partOfSpeech = null,Object? definitionEn = null,Object? translations = null,Object? synonyms = null,Object? antonyms = null,Object? greContextSentences = null,Object? mnemonics = null,Object? etymology = null,Object? audioFile = null,Object? practiceQuestions = freezed,}) {
  return _then(_GreWord(
originalInput: null == originalInput ? _self.originalInput : originalInput // ignore: cast_nullable_to_non_nullable
as String,word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,phonetic: null == phonetic ? _self.phonetic : phonetic // ignore: cast_nullable_to_non_nullable
as String,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,partOfSpeech: null == partOfSpeech ? _self.partOfSpeech : partOfSpeech // ignore: cast_nullable_to_non_nullable
as String,definitionEn: null == definitionEn ? _self.definitionEn : definitionEn // ignore: cast_nullable_to_non_nullable
as String,translations: null == translations ? _self.translations : translations // ignore: cast_nullable_to_non_nullable
as WordTranslations,synonyms: null == synonyms ? _self._synonyms : synonyms // ignore: cast_nullable_to_non_nullable
as List<String>,antonyms: null == antonyms ? _self._antonyms : antonyms // ignore: cast_nullable_to_non_nullable
as List<String>,greContextSentences: null == greContextSentences ? _self._greContextSentences : greContextSentences // ignore: cast_nullable_to_non_nullable
as List<String>,mnemonics: null == mnemonics ? _self.mnemonics : mnemonics // ignore: cast_nullable_to_non_nullable
as WordMnemonics,etymology: null == etymology ? _self.etymology : etymology // ignore: cast_nullable_to_non_nullable
as WordEtymology,audioFile: null == audioFile ? _self.audioFile : audioFile // ignore: cast_nullable_to_non_nullable
as String,practiceQuestions: freezed == practiceQuestions ? _self.practiceQuestions : practiceQuestions // ignore: cast_nullable_to_non_nullable
as PracticeQuestions?,
  ));
}

/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordTranslationsCopyWith<$Res> get translations {
  
  return $WordTranslationsCopyWith<$Res>(_self.translations, (value) {
    return _then(_self.copyWith(translations: value));
  });
}/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordMnemonicsCopyWith<$Res> get mnemonics {
  
  return $WordMnemonicsCopyWith<$Res>(_self.mnemonics, (value) {
    return _then(_self.copyWith(mnemonics: value));
  });
}/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WordEtymologyCopyWith<$Res> get etymology {
  
  return $WordEtymologyCopyWith<$Res>(_self.etymology, (value) {
    return _then(_self.copyWith(etymology: value));
  });
}/// Create a copy of GreWord
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeQuestionsCopyWith<$Res>? get practiceQuestions {
    if (_self.practiceQuestions == null) {
    return null;
  }

  return $PracticeQuestionsCopyWith<$Res>(_self.practiceQuestions!, (value) {
    return _then(_self.copyWith(practiceQuestions: value));
  });
}
}


/// @nodoc
mixin _$WordTranslations {

 String get fr; String get es;
/// Create a copy of WordTranslations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordTranslationsCopyWith<WordTranslations> get copyWith => _$WordTranslationsCopyWithImpl<WordTranslations>(this as WordTranslations, _$identity);

  /// Serializes this WordTranslations to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordTranslations&&(identical(other.fr, fr) || other.fr == fr)&&(identical(other.es, es) || other.es == es));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fr,es);

@override
String toString() {
  return 'WordTranslations(fr: $fr, es: $es)';
}


}

/// @nodoc
abstract mixin class $WordTranslationsCopyWith<$Res>  {
  factory $WordTranslationsCopyWith(WordTranslations value, $Res Function(WordTranslations) _then) = _$WordTranslationsCopyWithImpl;
@useResult
$Res call({
 String fr, String es
});




}
/// @nodoc
class _$WordTranslationsCopyWithImpl<$Res>
    implements $WordTranslationsCopyWith<$Res> {
  _$WordTranslationsCopyWithImpl(this._self, this._then);

  final WordTranslations _self;
  final $Res Function(WordTranslations) _then;

/// Create a copy of WordTranslations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fr = null,Object? es = null,}) {
  return _then(_self.copyWith(
fr: null == fr ? _self.fr : fr // ignore: cast_nullable_to_non_nullable
as String,es: null == es ? _self.es : es // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WordTranslations].
extension WordTranslationsPatterns on WordTranslations {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordTranslations value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordTranslations() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordTranslations value)  $default,){
final _that = this;
switch (_that) {
case _WordTranslations():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordTranslations value)?  $default,){
final _that = this;
switch (_that) {
case _WordTranslations() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fr,  String es)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordTranslations() when $default != null:
return $default(_that.fr,_that.es);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fr,  String es)  $default,) {final _that = this;
switch (_that) {
case _WordTranslations():
return $default(_that.fr,_that.es);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fr,  String es)?  $default,) {final _that = this;
switch (_that) {
case _WordTranslations() when $default != null:
return $default(_that.fr,_that.es);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordTranslations implements WordTranslations {
  const _WordTranslations({required this.fr, required this.es});
  factory _WordTranslations.fromJson(Map<String, dynamic> json) => _$WordTranslationsFromJson(json);

@override final  String fr;
@override final  String es;

/// Create a copy of WordTranslations
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordTranslationsCopyWith<_WordTranslations> get copyWith => __$WordTranslationsCopyWithImpl<_WordTranslations>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordTranslationsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordTranslations&&(identical(other.fr, fr) || other.fr == fr)&&(identical(other.es, es) || other.es == es));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fr,es);

@override
String toString() {
  return 'WordTranslations(fr: $fr, es: $es)';
}


}

/// @nodoc
abstract mixin class _$WordTranslationsCopyWith<$Res> implements $WordTranslationsCopyWith<$Res> {
  factory _$WordTranslationsCopyWith(_WordTranslations value, $Res Function(_WordTranslations) _then) = __$WordTranslationsCopyWithImpl;
@override @useResult
$Res call({
 String fr, String es
});




}
/// @nodoc
class __$WordTranslationsCopyWithImpl<$Res>
    implements _$WordTranslationsCopyWith<$Res> {
  __$WordTranslationsCopyWithImpl(this._self, this._then);

  final _WordTranslations _self;
  final $Res Function(_WordTranslations) _then;

/// Create a copy of WordTranslations
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fr = null,Object? es = null,}) {
  return _then(_WordTranslations(
fr: null == fr ? _self.fr : fr // ignore: cast_nullable_to_non_nullable
as String,es: null == es ? _self.es : es // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WordMnemonics {

 String get en; String get fr; String get es;
/// Create a copy of WordMnemonics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordMnemonicsCopyWith<WordMnemonics> get copyWith => _$WordMnemonicsCopyWithImpl<WordMnemonics>(this as WordMnemonics, _$identity);

  /// Serializes this WordMnemonics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordMnemonics&&(identical(other.en, en) || other.en == en)&&(identical(other.fr, fr) || other.fr == fr)&&(identical(other.es, es) || other.es == es));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,en,fr,es);

@override
String toString() {
  return 'WordMnemonics(en: $en, fr: $fr, es: $es)';
}


}

/// @nodoc
abstract mixin class $WordMnemonicsCopyWith<$Res>  {
  factory $WordMnemonicsCopyWith(WordMnemonics value, $Res Function(WordMnemonics) _then) = _$WordMnemonicsCopyWithImpl;
@useResult
$Res call({
 String en, String fr, String es
});




}
/// @nodoc
class _$WordMnemonicsCopyWithImpl<$Res>
    implements $WordMnemonicsCopyWith<$Res> {
  _$WordMnemonicsCopyWithImpl(this._self, this._then);

  final WordMnemonics _self;
  final $Res Function(WordMnemonics) _then;

/// Create a copy of WordMnemonics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? en = null,Object? fr = null,Object? es = null,}) {
  return _then(_self.copyWith(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,fr: null == fr ? _self.fr : fr // ignore: cast_nullable_to_non_nullable
as String,es: null == es ? _self.es : es // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WordMnemonics].
extension WordMnemonicsPatterns on WordMnemonics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordMnemonics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordMnemonics() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordMnemonics value)  $default,){
final _that = this;
switch (_that) {
case _WordMnemonics():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordMnemonics value)?  $default,){
final _that = this;
switch (_that) {
case _WordMnemonics() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String en,  String fr,  String es)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordMnemonics() when $default != null:
return $default(_that.en,_that.fr,_that.es);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String en,  String fr,  String es)  $default,) {final _that = this;
switch (_that) {
case _WordMnemonics():
return $default(_that.en,_that.fr,_that.es);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String en,  String fr,  String es)?  $default,) {final _that = this;
switch (_that) {
case _WordMnemonics() when $default != null:
return $default(_that.en,_that.fr,_that.es);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordMnemonics implements WordMnemonics {
  const _WordMnemonics({required this.en, required this.fr, required this.es});
  factory _WordMnemonics.fromJson(Map<String, dynamic> json) => _$WordMnemonicsFromJson(json);

@override final  String en;
@override final  String fr;
@override final  String es;

/// Create a copy of WordMnemonics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordMnemonicsCopyWith<_WordMnemonics> get copyWith => __$WordMnemonicsCopyWithImpl<_WordMnemonics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordMnemonicsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordMnemonics&&(identical(other.en, en) || other.en == en)&&(identical(other.fr, fr) || other.fr == fr)&&(identical(other.es, es) || other.es == es));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,en,fr,es);

@override
String toString() {
  return 'WordMnemonics(en: $en, fr: $fr, es: $es)';
}


}

/// @nodoc
abstract mixin class _$WordMnemonicsCopyWith<$Res> implements $WordMnemonicsCopyWith<$Res> {
  factory _$WordMnemonicsCopyWith(_WordMnemonics value, $Res Function(_WordMnemonics) _then) = __$WordMnemonicsCopyWithImpl;
@override @useResult
$Res call({
 String en, String fr, String es
});




}
/// @nodoc
class __$WordMnemonicsCopyWithImpl<$Res>
    implements _$WordMnemonicsCopyWith<$Res> {
  __$WordMnemonicsCopyWithImpl(this._self, this._then);

  final _WordMnemonics _self;
  final $Res Function(_WordMnemonics) _then;

/// Create a copy of WordMnemonics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? en = null,Object? fr = null,Object? es = null,}) {
  return _then(_WordMnemonics(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,fr: null == fr ? _self.fr : fr // ignore: cast_nullable_to_non_nullable
as String,es: null == es ? _self.es : es // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WordEtymology {

 String get en; String get fr; String get es;
/// Create a copy of WordEtymology
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordEtymologyCopyWith<WordEtymology> get copyWith => _$WordEtymologyCopyWithImpl<WordEtymology>(this as WordEtymology, _$identity);

  /// Serializes this WordEtymology to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordEtymology&&(identical(other.en, en) || other.en == en)&&(identical(other.fr, fr) || other.fr == fr)&&(identical(other.es, es) || other.es == es));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,en,fr,es);

@override
String toString() {
  return 'WordEtymology(en: $en, fr: $fr, es: $es)';
}


}

/// @nodoc
abstract mixin class $WordEtymologyCopyWith<$Res>  {
  factory $WordEtymologyCopyWith(WordEtymology value, $Res Function(WordEtymology) _then) = _$WordEtymologyCopyWithImpl;
@useResult
$Res call({
 String en, String fr, String es
});




}
/// @nodoc
class _$WordEtymologyCopyWithImpl<$Res>
    implements $WordEtymologyCopyWith<$Res> {
  _$WordEtymologyCopyWithImpl(this._self, this._then);

  final WordEtymology _self;
  final $Res Function(WordEtymology) _then;

/// Create a copy of WordEtymology
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? en = null,Object? fr = null,Object? es = null,}) {
  return _then(_self.copyWith(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,fr: null == fr ? _self.fr : fr // ignore: cast_nullable_to_non_nullable
as String,es: null == es ? _self.es : es // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WordEtymology].
extension WordEtymologyPatterns on WordEtymology {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordEtymology value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordEtymology() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordEtymology value)  $default,){
final _that = this;
switch (_that) {
case _WordEtymology():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordEtymology value)?  $default,){
final _that = this;
switch (_that) {
case _WordEtymology() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String en,  String fr,  String es)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordEtymology() when $default != null:
return $default(_that.en,_that.fr,_that.es);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String en,  String fr,  String es)  $default,) {final _that = this;
switch (_that) {
case _WordEtymology():
return $default(_that.en,_that.fr,_that.es);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String en,  String fr,  String es)?  $default,) {final _that = this;
switch (_that) {
case _WordEtymology() when $default != null:
return $default(_that.en,_that.fr,_that.es);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordEtymology implements WordEtymology {
  const _WordEtymology({required this.en, required this.fr, required this.es});
  factory _WordEtymology.fromJson(Map<String, dynamic> json) => _$WordEtymologyFromJson(json);

@override final  String en;
@override final  String fr;
@override final  String es;

/// Create a copy of WordEtymology
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordEtymologyCopyWith<_WordEtymology> get copyWith => __$WordEtymologyCopyWithImpl<_WordEtymology>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordEtymologyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordEtymology&&(identical(other.en, en) || other.en == en)&&(identical(other.fr, fr) || other.fr == fr)&&(identical(other.es, es) || other.es == es));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,en,fr,es);

@override
String toString() {
  return 'WordEtymology(en: $en, fr: $fr, es: $es)';
}


}

/// @nodoc
abstract mixin class _$WordEtymologyCopyWith<$Res> implements $WordEtymologyCopyWith<$Res> {
  factory _$WordEtymologyCopyWith(_WordEtymology value, $Res Function(_WordEtymology) _then) = __$WordEtymologyCopyWithImpl;
@override @useResult
$Res call({
 String en, String fr, String es
});




}
/// @nodoc
class __$WordEtymologyCopyWithImpl<$Res>
    implements _$WordEtymologyCopyWith<$Res> {
  __$WordEtymologyCopyWithImpl(this._self, this._then);

  final _WordEtymology _self;
  final $Res Function(_WordEtymology) _then;

/// Create a copy of WordEtymology
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? en = null,Object? fr = null,Object? es = null,}) {
  return _then(_WordEtymology(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,fr: null == fr ? _self.fr : fr // ignore: cast_nullable_to_non_nullable
as String,es: null == es ? _self.es : es // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
