// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arena_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArenaQuestion {

 GreWord get word; QuestionType get type; String get questionText; List<List<String>> get options;// List of options for each blank, or 1 list for SE
 List<String> get correctAnswers;
/// Create a copy of ArenaQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArenaQuestionCopyWith<ArenaQuestion> get copyWith => _$ArenaQuestionCopyWithImpl<ArenaQuestion>(this as ArenaQuestion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArenaQuestion&&(identical(other.word, word) || other.word == word)&&(identical(other.type, type) || other.type == type)&&(identical(other.questionText, questionText) || other.questionText == questionText)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.correctAnswers, correctAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,word,type,questionText,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(correctAnswers));

@override
String toString() {
  return 'ArenaQuestion(word: $word, type: $type, questionText: $questionText, options: $options, correctAnswers: $correctAnswers)';
}


}

/// @nodoc
abstract mixin class $ArenaQuestionCopyWith<$Res>  {
  factory $ArenaQuestionCopyWith(ArenaQuestion value, $Res Function(ArenaQuestion) _then) = _$ArenaQuestionCopyWithImpl;
@useResult
$Res call({
 GreWord word, QuestionType type, String questionText, List<List<String>> options, List<String> correctAnswers
});


$GreWordCopyWith<$Res> get word;

}
/// @nodoc
class _$ArenaQuestionCopyWithImpl<$Res>
    implements $ArenaQuestionCopyWith<$Res> {
  _$ArenaQuestionCopyWithImpl(this._self, this._then);

  final ArenaQuestion _self;
  final $Res Function(ArenaQuestion) _then;

/// Create a copy of ArenaQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? word = null,Object? type = null,Object? questionText = null,Object? options = null,Object? correctAnswers = null,}) {
  return _then(_self.copyWith(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as GreWord,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<List<String>>,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ArenaQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GreWordCopyWith<$Res> get word {
  
  return $GreWordCopyWith<$Res>(_self.word, (value) {
    return _then(_self.copyWith(word: value));
  });
}
}


/// Adds pattern-matching-related methods to [ArenaQuestion].
extension ArenaQuestionPatterns on ArenaQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArenaQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArenaQuestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArenaQuestion value)  $default,){
final _that = this;
switch (_that) {
case _ArenaQuestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArenaQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _ArenaQuestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GreWord word,  QuestionType type,  String questionText,  List<List<String>> options,  List<String> correctAnswers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArenaQuestion() when $default != null:
return $default(_that.word,_that.type,_that.questionText,_that.options,_that.correctAnswers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GreWord word,  QuestionType type,  String questionText,  List<List<String>> options,  List<String> correctAnswers)  $default,) {final _that = this;
switch (_that) {
case _ArenaQuestion():
return $default(_that.word,_that.type,_that.questionText,_that.options,_that.correctAnswers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GreWord word,  QuestionType type,  String questionText,  List<List<String>> options,  List<String> correctAnswers)?  $default,) {final _that = this;
switch (_that) {
case _ArenaQuestion() when $default != null:
return $default(_that.word,_that.type,_that.questionText,_that.options,_that.correctAnswers);case _:
  return null;

}
}

}

/// @nodoc


class _ArenaQuestion implements ArenaQuestion {
  const _ArenaQuestion({required this.word, required this.type, required this.questionText, required final  List<List<String>> options, required final  List<String> correctAnswers}): _options = options,_correctAnswers = correctAnswers;
  

@override final  GreWord word;
@override final  QuestionType type;
@override final  String questionText;
 final  List<List<String>> _options;
@override List<List<String>> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

// List of options for each blank, or 1 list for SE
 final  List<String> _correctAnswers;
// List of options for each blank, or 1 list for SE
@override List<String> get correctAnswers {
  if (_correctAnswers is EqualUnmodifiableListView) return _correctAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctAnswers);
}


/// Create a copy of ArenaQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArenaQuestionCopyWith<_ArenaQuestion> get copyWith => __$ArenaQuestionCopyWithImpl<_ArenaQuestion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArenaQuestion&&(identical(other.word, word) || other.word == word)&&(identical(other.type, type) || other.type == type)&&(identical(other.questionText, questionText) || other.questionText == questionText)&&const DeepCollectionEquality().equals(other._options, _options)&&const DeepCollectionEquality().equals(other._correctAnswers, _correctAnswers));
}


@override
int get hashCode => Object.hash(runtimeType,word,type,questionText,const DeepCollectionEquality().hash(_options),const DeepCollectionEquality().hash(_correctAnswers));

@override
String toString() {
  return 'ArenaQuestion(word: $word, type: $type, questionText: $questionText, options: $options, correctAnswers: $correctAnswers)';
}


}

/// @nodoc
abstract mixin class _$ArenaQuestionCopyWith<$Res> implements $ArenaQuestionCopyWith<$Res> {
  factory _$ArenaQuestionCopyWith(_ArenaQuestion value, $Res Function(_ArenaQuestion) _then) = __$ArenaQuestionCopyWithImpl;
@override @useResult
$Res call({
 GreWord word, QuestionType type, String questionText, List<List<String>> options, List<String> correctAnswers
});


@override $GreWordCopyWith<$Res> get word;

}
/// @nodoc
class __$ArenaQuestionCopyWithImpl<$Res>
    implements _$ArenaQuestionCopyWith<$Res> {
  __$ArenaQuestionCopyWithImpl(this._self, this._then);

  final _ArenaQuestion _self;
  final $Res Function(_ArenaQuestion) _then;

/// Create a copy of ArenaQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? word = null,Object? type = null,Object? questionText = null,Object? options = null,Object? correctAnswers = null,}) {
  return _then(_ArenaQuestion(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as GreWord,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuestionType,questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<List<String>>,correctAnswers: null == correctAnswers ? _self._correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ArenaQuestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GreWordCopyWith<$Res> get word {
  
  return $GreWordCopyWith<$Res>(_self.word, (value) {
    return _then(_self.copyWith(word: value));
  });
}
}

/// @nodoc
mixin _$ArenaState {

 ArenaMode get mode; ArenaStyle get style; int get customQuestionCount; List<ArenaQuestion> get questions; int get currentIndex; int get score; int get streakMultiplier; bool get isFinished; bool get isLoading; Map<int, Map<int, String>> get userAnswers;// questionIndex -> blankIndex -> answer
 int get remainingTimeSeconds; bool get isAnswerRevealed;// specifically for learning mode
 bool get includeTextCompletion; bool get includeSentenceEquivalence;
/// Create a copy of ArenaState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArenaStateCopyWith<ArenaState> get copyWith => _$ArenaStateCopyWithImpl<ArenaState>(this as ArenaState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArenaState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.style, style) || other.style == style)&&(identical(other.customQuestionCount, customQuestionCount) || other.customQuestionCount == customQuestionCount)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.score, score) || other.score == score)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.isFinished, isFinished) || other.isFinished == isFinished)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.userAnswers, userAnswers)&&(identical(other.remainingTimeSeconds, remainingTimeSeconds) || other.remainingTimeSeconds == remainingTimeSeconds)&&(identical(other.isAnswerRevealed, isAnswerRevealed) || other.isAnswerRevealed == isAnswerRevealed)&&(identical(other.includeTextCompletion, includeTextCompletion) || other.includeTextCompletion == includeTextCompletion)&&(identical(other.includeSentenceEquivalence, includeSentenceEquivalence) || other.includeSentenceEquivalence == includeSentenceEquivalence));
}


@override
int get hashCode => Object.hash(runtimeType,mode,style,customQuestionCount,const DeepCollectionEquality().hash(questions),currentIndex,score,streakMultiplier,isFinished,isLoading,const DeepCollectionEquality().hash(userAnswers),remainingTimeSeconds,isAnswerRevealed,includeTextCompletion,includeSentenceEquivalence);

@override
String toString() {
  return 'ArenaState(mode: $mode, style: $style, customQuestionCount: $customQuestionCount, questions: $questions, currentIndex: $currentIndex, score: $score, streakMultiplier: $streakMultiplier, isFinished: $isFinished, isLoading: $isLoading, userAnswers: $userAnswers, remainingTimeSeconds: $remainingTimeSeconds, isAnswerRevealed: $isAnswerRevealed, includeTextCompletion: $includeTextCompletion, includeSentenceEquivalence: $includeSentenceEquivalence)';
}


}

/// @nodoc
abstract mixin class $ArenaStateCopyWith<$Res>  {
  factory $ArenaStateCopyWith(ArenaState value, $Res Function(ArenaState) _then) = _$ArenaStateCopyWithImpl;
@useResult
$Res call({
 ArenaMode mode, ArenaStyle style, int customQuestionCount, List<ArenaQuestion> questions, int currentIndex, int score, int streakMultiplier, bool isFinished, bool isLoading, Map<int, Map<int, String>> userAnswers, int remainingTimeSeconds, bool isAnswerRevealed, bool includeTextCompletion, bool includeSentenceEquivalence
});




}
/// @nodoc
class _$ArenaStateCopyWithImpl<$Res>
    implements $ArenaStateCopyWith<$Res> {
  _$ArenaStateCopyWithImpl(this._self, this._then);

  final ArenaState _self;
  final $Res Function(ArenaState) _then;

/// Create a copy of ArenaState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? style = null,Object? customQuestionCount = null,Object? questions = null,Object? currentIndex = null,Object? score = null,Object? streakMultiplier = null,Object? isFinished = null,Object? isLoading = null,Object? userAnswers = null,Object? remainingTimeSeconds = null,Object? isAnswerRevealed = null,Object? includeTextCompletion = null,Object? includeSentenceEquivalence = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ArenaMode,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as ArenaStyle,customQuestionCount: null == customQuestionCount ? _self.customQuestionCount : customQuestionCount // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<ArenaQuestion>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,streakMultiplier: null == streakMultiplier ? _self.streakMultiplier : streakMultiplier // ignore: cast_nullable_to_non_nullable
as int,isFinished: null == isFinished ? _self.isFinished : isFinished // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,userAnswers: null == userAnswers ? _self.userAnswers : userAnswers // ignore: cast_nullable_to_non_nullable
as Map<int, Map<int, String>>,remainingTimeSeconds: null == remainingTimeSeconds ? _self.remainingTimeSeconds : remainingTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,isAnswerRevealed: null == isAnswerRevealed ? _self.isAnswerRevealed : isAnswerRevealed // ignore: cast_nullable_to_non_nullable
as bool,includeTextCompletion: null == includeTextCompletion ? _self.includeTextCompletion : includeTextCompletion // ignore: cast_nullable_to_non_nullable
as bool,includeSentenceEquivalence: null == includeSentenceEquivalence ? _self.includeSentenceEquivalence : includeSentenceEquivalence // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ArenaState].
extension ArenaStatePatterns on ArenaState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArenaState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArenaState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArenaState value)  $default,){
final _that = this;
switch (_that) {
case _ArenaState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArenaState value)?  $default,){
final _that = this;
switch (_that) {
case _ArenaState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ArenaMode mode,  ArenaStyle style,  int customQuestionCount,  List<ArenaQuestion> questions,  int currentIndex,  int score,  int streakMultiplier,  bool isFinished,  bool isLoading,  Map<int, Map<int, String>> userAnswers,  int remainingTimeSeconds,  bool isAnswerRevealed,  bool includeTextCompletion,  bool includeSentenceEquivalence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArenaState() when $default != null:
return $default(_that.mode,_that.style,_that.customQuestionCount,_that.questions,_that.currentIndex,_that.score,_that.streakMultiplier,_that.isFinished,_that.isLoading,_that.userAnswers,_that.remainingTimeSeconds,_that.isAnswerRevealed,_that.includeTextCompletion,_that.includeSentenceEquivalence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ArenaMode mode,  ArenaStyle style,  int customQuestionCount,  List<ArenaQuestion> questions,  int currentIndex,  int score,  int streakMultiplier,  bool isFinished,  bool isLoading,  Map<int, Map<int, String>> userAnswers,  int remainingTimeSeconds,  bool isAnswerRevealed,  bool includeTextCompletion,  bool includeSentenceEquivalence)  $default,) {final _that = this;
switch (_that) {
case _ArenaState():
return $default(_that.mode,_that.style,_that.customQuestionCount,_that.questions,_that.currentIndex,_that.score,_that.streakMultiplier,_that.isFinished,_that.isLoading,_that.userAnswers,_that.remainingTimeSeconds,_that.isAnswerRevealed,_that.includeTextCompletion,_that.includeSentenceEquivalence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ArenaMode mode,  ArenaStyle style,  int customQuestionCount,  List<ArenaQuestion> questions,  int currentIndex,  int score,  int streakMultiplier,  bool isFinished,  bool isLoading,  Map<int, Map<int, String>> userAnswers,  int remainingTimeSeconds,  bool isAnswerRevealed,  bool includeTextCompletion,  bool includeSentenceEquivalence)?  $default,) {final _that = this;
switch (_that) {
case _ArenaState() when $default != null:
return $default(_that.mode,_that.style,_that.customQuestionCount,_that.questions,_that.currentIndex,_that.score,_that.streakMultiplier,_that.isFinished,_that.isLoading,_that.userAnswers,_that.remainingTimeSeconds,_that.isAnswerRevealed,_that.includeTextCompletion,_that.includeSentenceEquivalence);case _:
  return null;

}
}

}

/// @nodoc


class _ArenaState implements ArenaState {
  const _ArenaState({this.mode = ArenaMode.dailyFocus, this.style = ArenaStyle.learning, this.customQuestionCount = 10, final  List<ArenaQuestion> questions = const [], this.currentIndex = 0, this.score = 0, this.streakMultiplier = 1, this.isFinished = false, this.isLoading = false, final  Map<int, Map<int, String>> userAnswers = const {}, this.remainingTimeSeconds = 0, this.isAnswerRevealed = false, this.includeTextCompletion = true, this.includeSentenceEquivalence = true}): _questions = questions,_userAnswers = userAnswers;
  

@override@JsonKey() final  ArenaMode mode;
@override@JsonKey() final  ArenaStyle style;
@override@JsonKey() final  int customQuestionCount;
 final  List<ArenaQuestion> _questions;
@override@JsonKey() List<ArenaQuestion> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override@JsonKey() final  int currentIndex;
@override@JsonKey() final  int score;
@override@JsonKey() final  int streakMultiplier;
@override@JsonKey() final  bool isFinished;
@override@JsonKey() final  bool isLoading;
 final  Map<int, Map<int, String>> _userAnswers;
@override@JsonKey() Map<int, Map<int, String>> get userAnswers {
  if (_userAnswers is EqualUnmodifiableMapView) return _userAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_userAnswers);
}

// questionIndex -> blankIndex -> answer
@override@JsonKey() final  int remainingTimeSeconds;
@override@JsonKey() final  bool isAnswerRevealed;
// specifically for learning mode
@override@JsonKey() final  bool includeTextCompletion;
@override@JsonKey() final  bool includeSentenceEquivalence;

/// Create a copy of ArenaState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArenaStateCopyWith<_ArenaState> get copyWith => __$ArenaStateCopyWithImpl<_ArenaState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArenaState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.style, style) || other.style == style)&&(identical(other.customQuestionCount, customQuestionCount) || other.customQuestionCount == customQuestionCount)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.score, score) || other.score == score)&&(identical(other.streakMultiplier, streakMultiplier) || other.streakMultiplier == streakMultiplier)&&(identical(other.isFinished, isFinished) || other.isFinished == isFinished)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._userAnswers, _userAnswers)&&(identical(other.remainingTimeSeconds, remainingTimeSeconds) || other.remainingTimeSeconds == remainingTimeSeconds)&&(identical(other.isAnswerRevealed, isAnswerRevealed) || other.isAnswerRevealed == isAnswerRevealed)&&(identical(other.includeTextCompletion, includeTextCompletion) || other.includeTextCompletion == includeTextCompletion)&&(identical(other.includeSentenceEquivalence, includeSentenceEquivalence) || other.includeSentenceEquivalence == includeSentenceEquivalence));
}


@override
int get hashCode => Object.hash(runtimeType,mode,style,customQuestionCount,const DeepCollectionEquality().hash(_questions),currentIndex,score,streakMultiplier,isFinished,isLoading,const DeepCollectionEquality().hash(_userAnswers),remainingTimeSeconds,isAnswerRevealed,includeTextCompletion,includeSentenceEquivalence);

@override
String toString() {
  return 'ArenaState(mode: $mode, style: $style, customQuestionCount: $customQuestionCount, questions: $questions, currentIndex: $currentIndex, score: $score, streakMultiplier: $streakMultiplier, isFinished: $isFinished, isLoading: $isLoading, userAnswers: $userAnswers, remainingTimeSeconds: $remainingTimeSeconds, isAnswerRevealed: $isAnswerRevealed, includeTextCompletion: $includeTextCompletion, includeSentenceEquivalence: $includeSentenceEquivalence)';
}


}

/// @nodoc
abstract mixin class _$ArenaStateCopyWith<$Res> implements $ArenaStateCopyWith<$Res> {
  factory _$ArenaStateCopyWith(_ArenaState value, $Res Function(_ArenaState) _then) = __$ArenaStateCopyWithImpl;
@override @useResult
$Res call({
 ArenaMode mode, ArenaStyle style, int customQuestionCount, List<ArenaQuestion> questions, int currentIndex, int score, int streakMultiplier, bool isFinished, bool isLoading, Map<int, Map<int, String>> userAnswers, int remainingTimeSeconds, bool isAnswerRevealed, bool includeTextCompletion, bool includeSentenceEquivalence
});




}
/// @nodoc
class __$ArenaStateCopyWithImpl<$Res>
    implements _$ArenaStateCopyWith<$Res> {
  __$ArenaStateCopyWithImpl(this._self, this._then);

  final _ArenaState _self;
  final $Res Function(_ArenaState) _then;

/// Create a copy of ArenaState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? style = null,Object? customQuestionCount = null,Object? questions = null,Object? currentIndex = null,Object? score = null,Object? streakMultiplier = null,Object? isFinished = null,Object? isLoading = null,Object? userAnswers = null,Object? remainingTimeSeconds = null,Object? isAnswerRevealed = null,Object? includeTextCompletion = null,Object? includeSentenceEquivalence = null,}) {
  return _then(_ArenaState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ArenaMode,style: null == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as ArenaStyle,customQuestionCount: null == customQuestionCount ? _self.customQuestionCount : customQuestionCount // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<ArenaQuestion>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,streakMultiplier: null == streakMultiplier ? _self.streakMultiplier : streakMultiplier // ignore: cast_nullable_to_non_nullable
as int,isFinished: null == isFinished ? _self.isFinished : isFinished // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,userAnswers: null == userAnswers ? _self._userAnswers : userAnswers // ignore: cast_nullable_to_non_nullable
as Map<int, Map<int, String>>,remainingTimeSeconds: null == remainingTimeSeconds ? _self.remainingTimeSeconds : remainingTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,isAnswerRevealed: null == isAnswerRevealed ? _self.isAnswerRevealed : isAnswerRevealed // ignore: cast_nullable_to_non_nullable
as bool,includeTextCompletion: null == includeTextCompletion ? _self.includeTextCompletion : includeTextCompletion // ignore: cast_nullable_to_non_nullable
as bool,includeSentenceEquivalence: null == includeSentenceEquivalence ? _self.includeSentenceEquivalence : includeSentenceEquivalence // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
