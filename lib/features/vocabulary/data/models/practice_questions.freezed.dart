// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_questions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PracticeQuestions {

@JsonKey(name: 'text_completions') TextCompletions? get textCompletions;@JsonKey(name: 'sentence_equivalence') SentenceEquivalence? get sentenceEquivalence;
/// Create a copy of PracticeQuestions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeQuestionsCopyWith<PracticeQuestions> get copyWith => _$PracticeQuestionsCopyWithImpl<PracticeQuestions>(this as PracticeQuestions, _$identity);

  /// Serializes this PracticeQuestions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeQuestions&&(identical(other.textCompletions, textCompletions) || other.textCompletions == textCompletions)&&(identical(other.sentenceEquivalence, sentenceEquivalence) || other.sentenceEquivalence == sentenceEquivalence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textCompletions,sentenceEquivalence);

@override
String toString() {
  return 'PracticeQuestions(textCompletions: $textCompletions, sentenceEquivalence: $sentenceEquivalence)';
}


}

/// @nodoc
abstract mixin class $PracticeQuestionsCopyWith<$Res>  {
  factory $PracticeQuestionsCopyWith(PracticeQuestions value, $Res Function(PracticeQuestions) _then) = _$PracticeQuestionsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'text_completions') TextCompletions? textCompletions,@JsonKey(name: 'sentence_equivalence') SentenceEquivalence? sentenceEquivalence
});


$TextCompletionsCopyWith<$Res>? get textCompletions;$SentenceEquivalenceCopyWith<$Res>? get sentenceEquivalence;

}
/// @nodoc
class _$PracticeQuestionsCopyWithImpl<$Res>
    implements $PracticeQuestionsCopyWith<$Res> {
  _$PracticeQuestionsCopyWithImpl(this._self, this._then);

  final PracticeQuestions _self;
  final $Res Function(PracticeQuestions) _then;

/// Create a copy of PracticeQuestions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textCompletions = freezed,Object? sentenceEquivalence = freezed,}) {
  return _then(_self.copyWith(
textCompletions: freezed == textCompletions ? _self.textCompletions : textCompletions // ignore: cast_nullable_to_non_nullable
as TextCompletions?,sentenceEquivalence: freezed == sentenceEquivalence ? _self.sentenceEquivalence : sentenceEquivalence // ignore: cast_nullable_to_non_nullable
as SentenceEquivalence?,
  ));
}
/// Create a copy of PracticeQuestions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCompletionsCopyWith<$Res>? get textCompletions {
    if (_self.textCompletions == null) {
    return null;
  }

  return $TextCompletionsCopyWith<$Res>(_self.textCompletions!, (value) {
    return _then(_self.copyWith(textCompletions: value));
  });
}/// Create a copy of PracticeQuestions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentenceEquivalenceCopyWith<$Res>? get sentenceEquivalence {
    if (_self.sentenceEquivalence == null) {
    return null;
  }

  return $SentenceEquivalenceCopyWith<$Res>(_self.sentenceEquivalence!, (value) {
    return _then(_self.copyWith(sentenceEquivalence: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeQuestions].
extension PracticeQuestionsPatterns on PracticeQuestions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeQuestions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeQuestions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeQuestions value)  $default,){
final _that = this;
switch (_that) {
case _PracticeQuestions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeQuestions value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeQuestions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'text_completions')  TextCompletions? textCompletions, @JsonKey(name: 'sentence_equivalence')  SentenceEquivalence? sentenceEquivalence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeQuestions() when $default != null:
return $default(_that.textCompletions,_that.sentenceEquivalence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'text_completions')  TextCompletions? textCompletions, @JsonKey(name: 'sentence_equivalence')  SentenceEquivalence? sentenceEquivalence)  $default,) {final _that = this;
switch (_that) {
case _PracticeQuestions():
return $default(_that.textCompletions,_that.sentenceEquivalence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'text_completions')  TextCompletions? textCompletions, @JsonKey(name: 'sentence_equivalence')  SentenceEquivalence? sentenceEquivalence)?  $default,) {final _that = this;
switch (_that) {
case _PracticeQuestions() when $default != null:
return $default(_that.textCompletions,_that.sentenceEquivalence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PracticeQuestions implements PracticeQuestions {
  const _PracticeQuestions({@JsonKey(name: 'text_completions') this.textCompletions, @JsonKey(name: 'sentence_equivalence') this.sentenceEquivalence});
  factory _PracticeQuestions.fromJson(Map<String, dynamic> json) => _$PracticeQuestionsFromJson(json);

@override@JsonKey(name: 'text_completions') final  TextCompletions? textCompletions;
@override@JsonKey(name: 'sentence_equivalence') final  SentenceEquivalence? sentenceEquivalence;

/// Create a copy of PracticeQuestions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeQuestionsCopyWith<_PracticeQuestions> get copyWith => __$PracticeQuestionsCopyWithImpl<_PracticeQuestions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PracticeQuestionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeQuestions&&(identical(other.textCompletions, textCompletions) || other.textCompletions == textCompletions)&&(identical(other.sentenceEquivalence, sentenceEquivalence) || other.sentenceEquivalence == sentenceEquivalence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textCompletions,sentenceEquivalence);

@override
String toString() {
  return 'PracticeQuestions(textCompletions: $textCompletions, sentenceEquivalence: $sentenceEquivalence)';
}


}

/// @nodoc
abstract mixin class _$PracticeQuestionsCopyWith<$Res> implements $PracticeQuestionsCopyWith<$Res> {
  factory _$PracticeQuestionsCopyWith(_PracticeQuestions value, $Res Function(_PracticeQuestions) _then) = __$PracticeQuestionsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'text_completions') TextCompletions? textCompletions,@JsonKey(name: 'sentence_equivalence') SentenceEquivalence? sentenceEquivalence
});


@override $TextCompletionsCopyWith<$Res>? get textCompletions;@override $SentenceEquivalenceCopyWith<$Res>? get sentenceEquivalence;

}
/// @nodoc
class __$PracticeQuestionsCopyWithImpl<$Res>
    implements _$PracticeQuestionsCopyWith<$Res> {
  __$PracticeQuestionsCopyWithImpl(this._self, this._then);

  final _PracticeQuestions _self;
  final $Res Function(_PracticeQuestions) _then;

/// Create a copy of PracticeQuestions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textCompletions = freezed,Object? sentenceEquivalence = freezed,}) {
  return _then(_PracticeQuestions(
textCompletions: freezed == textCompletions ? _self.textCompletions : textCompletions // ignore: cast_nullable_to_non_nullable
as TextCompletions?,sentenceEquivalence: freezed == sentenceEquivalence ? _self.sentenceEquivalence : sentenceEquivalence // ignore: cast_nullable_to_non_nullable
as SentenceEquivalence?,
  ));
}

/// Create a copy of PracticeQuestions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCompletionsCopyWith<$Res>? get textCompletions {
    if (_self.textCompletions == null) {
    return null;
  }

  return $TextCompletionsCopyWith<$Res>(_self.textCompletions!, (value) {
    return _then(_self.copyWith(textCompletions: value));
  });
}/// Create a copy of PracticeQuestions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentenceEquivalenceCopyWith<$Res>? get sentenceEquivalence {
    if (_self.sentenceEquivalence == null) {
    return null;
  }

  return $SentenceEquivalenceCopyWith<$Res>(_self.sentenceEquivalence!, (value) {
    return _then(_self.copyWith(sentenceEquivalence: value));
  });
}
}


/// @nodoc
mixin _$TextCompletions {

@JsonKey(name: 'one_blank') TextCompletionQuestion? get oneBlank;@JsonKey(name: 'two_blanks') TextCompletionQuestion? get twoBlanks;@JsonKey(name: 'three_blanks') TextCompletionQuestion? get threeBlanks;
/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextCompletionsCopyWith<TextCompletions> get copyWith => _$TextCompletionsCopyWithImpl<TextCompletions>(this as TextCompletions, _$identity);

  /// Serializes this TextCompletions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextCompletions&&(identical(other.oneBlank, oneBlank) || other.oneBlank == oneBlank)&&(identical(other.twoBlanks, twoBlanks) || other.twoBlanks == twoBlanks)&&(identical(other.threeBlanks, threeBlanks) || other.threeBlanks == threeBlanks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oneBlank,twoBlanks,threeBlanks);

@override
String toString() {
  return 'TextCompletions(oneBlank: $oneBlank, twoBlanks: $twoBlanks, threeBlanks: $threeBlanks)';
}


}

/// @nodoc
abstract mixin class $TextCompletionsCopyWith<$Res>  {
  factory $TextCompletionsCopyWith(TextCompletions value, $Res Function(TextCompletions) _then) = _$TextCompletionsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'one_blank') TextCompletionQuestion? oneBlank,@JsonKey(name: 'two_blanks') TextCompletionQuestion? twoBlanks,@JsonKey(name: 'three_blanks') TextCompletionQuestion? threeBlanks
});


$TextCompletionQuestionCopyWith<$Res>? get oneBlank;$TextCompletionQuestionCopyWith<$Res>? get twoBlanks;$TextCompletionQuestionCopyWith<$Res>? get threeBlanks;

}
/// @nodoc
class _$TextCompletionsCopyWithImpl<$Res>
    implements $TextCompletionsCopyWith<$Res> {
  _$TextCompletionsCopyWithImpl(this._self, this._then);

  final TextCompletions _self;
  final $Res Function(TextCompletions) _then;

/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? oneBlank = freezed,Object? twoBlanks = freezed,Object? threeBlanks = freezed,}) {
  return _then(_self.copyWith(
oneBlank: freezed == oneBlank ? _self.oneBlank : oneBlank // ignore: cast_nullable_to_non_nullable
as TextCompletionQuestion?,twoBlanks: freezed == twoBlanks ? _self.twoBlanks : twoBlanks // ignore: cast_nullable_to_non_nullable
as TextCompletionQuestion?,threeBlanks: freezed == threeBlanks ? _self.threeBlanks : threeBlanks // ignore: cast_nullable_to_non_nullable
as TextCompletionQuestion?,
  ));
}
/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCompletionQuestionCopyWith<$Res>? get oneBlank {
    if (_self.oneBlank == null) {
    return null;
  }

  return $TextCompletionQuestionCopyWith<$Res>(_self.oneBlank!, (value) {
    return _then(_self.copyWith(oneBlank: value));
  });
}/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCompletionQuestionCopyWith<$Res>? get twoBlanks {
    if (_self.twoBlanks == null) {
    return null;
  }

  return $TextCompletionQuestionCopyWith<$Res>(_self.twoBlanks!, (value) {
    return _then(_self.copyWith(twoBlanks: value));
  });
}/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCompletionQuestionCopyWith<$Res>? get threeBlanks {
    if (_self.threeBlanks == null) {
    return null;
  }

  return $TextCompletionQuestionCopyWith<$Res>(_self.threeBlanks!, (value) {
    return _then(_self.copyWith(threeBlanks: value));
  });
}
}


/// Adds pattern-matching-related methods to [TextCompletions].
extension TextCompletionsPatterns on TextCompletions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TextCompletions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TextCompletions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TextCompletions value)  $default,){
final _that = this;
switch (_that) {
case _TextCompletions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TextCompletions value)?  $default,){
final _that = this;
switch (_that) {
case _TextCompletions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'one_blank')  TextCompletionQuestion? oneBlank, @JsonKey(name: 'two_blanks')  TextCompletionQuestion? twoBlanks, @JsonKey(name: 'three_blanks')  TextCompletionQuestion? threeBlanks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TextCompletions() when $default != null:
return $default(_that.oneBlank,_that.twoBlanks,_that.threeBlanks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'one_blank')  TextCompletionQuestion? oneBlank, @JsonKey(name: 'two_blanks')  TextCompletionQuestion? twoBlanks, @JsonKey(name: 'three_blanks')  TextCompletionQuestion? threeBlanks)  $default,) {final _that = this;
switch (_that) {
case _TextCompletions():
return $default(_that.oneBlank,_that.twoBlanks,_that.threeBlanks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'one_blank')  TextCompletionQuestion? oneBlank, @JsonKey(name: 'two_blanks')  TextCompletionQuestion? twoBlanks, @JsonKey(name: 'three_blanks')  TextCompletionQuestion? threeBlanks)?  $default,) {final _that = this;
switch (_that) {
case _TextCompletions() when $default != null:
return $default(_that.oneBlank,_that.twoBlanks,_that.threeBlanks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TextCompletions implements TextCompletions {
  const _TextCompletions({@JsonKey(name: 'one_blank') this.oneBlank, @JsonKey(name: 'two_blanks') this.twoBlanks, @JsonKey(name: 'three_blanks') this.threeBlanks});
  factory _TextCompletions.fromJson(Map<String, dynamic> json) => _$TextCompletionsFromJson(json);

@override@JsonKey(name: 'one_blank') final  TextCompletionQuestion? oneBlank;
@override@JsonKey(name: 'two_blanks') final  TextCompletionQuestion? twoBlanks;
@override@JsonKey(name: 'three_blanks') final  TextCompletionQuestion? threeBlanks;

/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextCompletionsCopyWith<_TextCompletions> get copyWith => __$TextCompletionsCopyWithImpl<_TextCompletions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextCompletionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextCompletions&&(identical(other.oneBlank, oneBlank) || other.oneBlank == oneBlank)&&(identical(other.twoBlanks, twoBlanks) || other.twoBlanks == twoBlanks)&&(identical(other.threeBlanks, threeBlanks) || other.threeBlanks == threeBlanks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,oneBlank,twoBlanks,threeBlanks);

@override
String toString() {
  return 'TextCompletions(oneBlank: $oneBlank, twoBlanks: $twoBlanks, threeBlanks: $threeBlanks)';
}


}

/// @nodoc
abstract mixin class _$TextCompletionsCopyWith<$Res> implements $TextCompletionsCopyWith<$Res> {
  factory _$TextCompletionsCopyWith(_TextCompletions value, $Res Function(_TextCompletions) _then) = __$TextCompletionsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'one_blank') TextCompletionQuestion? oneBlank,@JsonKey(name: 'two_blanks') TextCompletionQuestion? twoBlanks,@JsonKey(name: 'three_blanks') TextCompletionQuestion? threeBlanks
});


@override $TextCompletionQuestionCopyWith<$Res>? get oneBlank;@override $TextCompletionQuestionCopyWith<$Res>? get twoBlanks;@override $TextCompletionQuestionCopyWith<$Res>? get threeBlanks;

}
/// @nodoc
class __$TextCompletionsCopyWithImpl<$Res>
    implements _$TextCompletionsCopyWith<$Res> {
  __$TextCompletionsCopyWithImpl(this._self, this._then);

  final _TextCompletions _self;
  final $Res Function(_TextCompletions) _then;

/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? oneBlank = freezed,Object? twoBlanks = freezed,Object? threeBlanks = freezed,}) {
  return _then(_TextCompletions(
oneBlank: freezed == oneBlank ? _self.oneBlank : oneBlank // ignore: cast_nullable_to_non_nullable
as TextCompletionQuestion?,twoBlanks: freezed == twoBlanks ? _self.twoBlanks : twoBlanks // ignore: cast_nullable_to_non_nullable
as TextCompletionQuestion?,threeBlanks: freezed == threeBlanks ? _self.threeBlanks : threeBlanks // ignore: cast_nullable_to_non_nullable
as TextCompletionQuestion?,
  ));
}

/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCompletionQuestionCopyWith<$Res>? get oneBlank {
    if (_self.oneBlank == null) {
    return null;
  }

  return $TextCompletionQuestionCopyWith<$Res>(_self.oneBlank!, (value) {
    return _then(_self.copyWith(oneBlank: value));
  });
}/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCompletionQuestionCopyWith<$Res>? get twoBlanks {
    if (_self.twoBlanks == null) {
    return null;
  }

  return $TextCompletionQuestionCopyWith<$Res>(_self.twoBlanks!, (value) {
    return _then(_self.copyWith(twoBlanks: value));
  });
}/// Create a copy of TextCompletions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextCompletionQuestionCopyWith<$Res>? get threeBlanks {
    if (_self.threeBlanks == null) {
    return null;
  }

  return $TextCompletionQuestionCopyWith<$Res>(_self.threeBlanks!, (value) {
    return _then(_self.copyWith(threeBlanks: value));
  });
}
}


/// @nodoc
mixin _$TextCompletionQuestion {

@JsonKey(name: 'question_text') String get questionText; List<QuestionBlank> get blanks;
/// Create a copy of TextCompletionQuestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextCompletionQuestionCopyWith<TextCompletionQuestion> get copyWith => _$TextCompletionQuestionCopyWithImpl<TextCompletionQuestion>(this as TextCompletionQuestion, _$identity);

  /// Serializes this TextCompletionQuestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextCompletionQuestion&&(identical(other.questionText, questionText) || other.questionText == questionText)&&const DeepCollectionEquality().equals(other.blanks, blanks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionText,const DeepCollectionEquality().hash(blanks));

@override
String toString() {
  return 'TextCompletionQuestion(questionText: $questionText, blanks: $blanks)';
}


}

/// @nodoc
abstract mixin class $TextCompletionQuestionCopyWith<$Res>  {
  factory $TextCompletionQuestionCopyWith(TextCompletionQuestion value, $Res Function(TextCompletionQuestion) _then) = _$TextCompletionQuestionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'question_text') String questionText, List<QuestionBlank> blanks
});




}
/// @nodoc
class _$TextCompletionQuestionCopyWithImpl<$Res>
    implements $TextCompletionQuestionCopyWith<$Res> {
  _$TextCompletionQuestionCopyWithImpl(this._self, this._then);

  final TextCompletionQuestion _self;
  final $Res Function(TextCompletionQuestion) _then;

/// Create a copy of TextCompletionQuestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionText = null,Object? blanks = null,}) {
  return _then(_self.copyWith(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,blanks: null == blanks ? _self.blanks : blanks // ignore: cast_nullable_to_non_nullable
as List<QuestionBlank>,
  ));
}

}


/// Adds pattern-matching-related methods to [TextCompletionQuestion].
extension TextCompletionQuestionPatterns on TextCompletionQuestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TextCompletionQuestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TextCompletionQuestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TextCompletionQuestion value)  $default,){
final _that = this;
switch (_that) {
case _TextCompletionQuestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TextCompletionQuestion value)?  $default,){
final _that = this;
switch (_that) {
case _TextCompletionQuestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'question_text')  String questionText,  List<QuestionBlank> blanks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TextCompletionQuestion() when $default != null:
return $default(_that.questionText,_that.blanks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'question_text')  String questionText,  List<QuestionBlank> blanks)  $default,) {final _that = this;
switch (_that) {
case _TextCompletionQuestion():
return $default(_that.questionText,_that.blanks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'question_text')  String questionText,  List<QuestionBlank> blanks)?  $default,) {final _that = this;
switch (_that) {
case _TextCompletionQuestion() when $default != null:
return $default(_that.questionText,_that.blanks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TextCompletionQuestion implements TextCompletionQuestion {
  const _TextCompletionQuestion({@JsonKey(name: 'question_text') required this.questionText, required final  List<QuestionBlank> blanks}): _blanks = blanks;
  factory _TextCompletionQuestion.fromJson(Map<String, dynamic> json) => _$TextCompletionQuestionFromJson(json);

@override@JsonKey(name: 'question_text') final  String questionText;
 final  List<QuestionBlank> _blanks;
@override List<QuestionBlank> get blanks {
  if (_blanks is EqualUnmodifiableListView) return _blanks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blanks);
}


/// Create a copy of TextCompletionQuestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextCompletionQuestionCopyWith<_TextCompletionQuestion> get copyWith => __$TextCompletionQuestionCopyWithImpl<_TextCompletionQuestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextCompletionQuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextCompletionQuestion&&(identical(other.questionText, questionText) || other.questionText == questionText)&&const DeepCollectionEquality().equals(other._blanks, _blanks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionText,const DeepCollectionEquality().hash(_blanks));

@override
String toString() {
  return 'TextCompletionQuestion(questionText: $questionText, blanks: $blanks)';
}


}

/// @nodoc
abstract mixin class _$TextCompletionQuestionCopyWith<$Res> implements $TextCompletionQuestionCopyWith<$Res> {
  factory _$TextCompletionQuestionCopyWith(_TextCompletionQuestion value, $Res Function(_TextCompletionQuestion) _then) = __$TextCompletionQuestionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'question_text') String questionText, List<QuestionBlank> blanks
});




}
/// @nodoc
class __$TextCompletionQuestionCopyWithImpl<$Res>
    implements _$TextCompletionQuestionCopyWith<$Res> {
  __$TextCompletionQuestionCopyWithImpl(this._self, this._then);

  final _TextCompletionQuestion _self;
  final $Res Function(_TextCompletionQuestion) _then;

/// Create a copy of TextCompletionQuestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionText = null,Object? blanks = null,}) {
  return _then(_TextCompletionQuestion(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,blanks: null == blanks ? _self._blanks : blanks // ignore: cast_nullable_to_non_nullable
as List<QuestionBlank>,
  ));
}


}


/// @nodoc
mixin _$QuestionBlank {

@JsonKey(name: 'correct_answer') String get correctAnswer; List<String> get distractors;
/// Create a copy of QuestionBlank
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionBlankCopyWith<QuestionBlank> get copyWith => _$QuestionBlankCopyWithImpl<QuestionBlank>(this as QuestionBlank, _$identity);

  /// Serializes this QuestionBlank to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionBlank&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&const DeepCollectionEquality().equals(other.distractors, distractors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,correctAnswer,const DeepCollectionEquality().hash(distractors));

@override
String toString() {
  return 'QuestionBlank(correctAnswer: $correctAnswer, distractors: $distractors)';
}


}

/// @nodoc
abstract mixin class $QuestionBlankCopyWith<$Res>  {
  factory $QuestionBlankCopyWith(QuestionBlank value, $Res Function(QuestionBlank) _then) = _$QuestionBlankCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'correct_answer') String correctAnswer, List<String> distractors
});




}
/// @nodoc
class _$QuestionBlankCopyWithImpl<$Res>
    implements $QuestionBlankCopyWith<$Res> {
  _$QuestionBlankCopyWithImpl(this._self, this._then);

  final QuestionBlank _self;
  final $Res Function(QuestionBlank) _then;

/// Create a copy of QuestionBlank
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? correctAnswer = null,Object? distractors = null,}) {
  return _then(_self.copyWith(
correctAnswer: null == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String,distractors: null == distractors ? _self.distractors : distractors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionBlank].
extension QuestionBlankPatterns on QuestionBlank {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionBlank value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionBlank() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionBlank value)  $default,){
final _that = this;
switch (_that) {
case _QuestionBlank():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionBlank value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionBlank() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'correct_answer')  String correctAnswer,  List<String> distractors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionBlank() when $default != null:
return $default(_that.correctAnswer,_that.distractors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'correct_answer')  String correctAnswer,  List<String> distractors)  $default,) {final _that = this;
switch (_that) {
case _QuestionBlank():
return $default(_that.correctAnswer,_that.distractors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'correct_answer')  String correctAnswer,  List<String> distractors)?  $default,) {final _that = this;
switch (_that) {
case _QuestionBlank() when $default != null:
return $default(_that.correctAnswer,_that.distractors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionBlank implements QuestionBlank {
  const _QuestionBlank({@JsonKey(name: 'correct_answer') required this.correctAnswer, required final  List<String> distractors}): _distractors = distractors;
  factory _QuestionBlank.fromJson(Map<String, dynamic> json) => _$QuestionBlankFromJson(json);

@override@JsonKey(name: 'correct_answer') final  String correctAnswer;
 final  List<String> _distractors;
@override List<String> get distractors {
  if (_distractors is EqualUnmodifiableListView) return _distractors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_distractors);
}


/// Create a copy of QuestionBlank
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionBlankCopyWith<_QuestionBlank> get copyWith => __$QuestionBlankCopyWithImpl<_QuestionBlank>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionBlankToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionBlank&&(identical(other.correctAnswer, correctAnswer) || other.correctAnswer == correctAnswer)&&const DeepCollectionEquality().equals(other._distractors, _distractors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,correctAnswer,const DeepCollectionEquality().hash(_distractors));

@override
String toString() {
  return 'QuestionBlank(correctAnswer: $correctAnswer, distractors: $distractors)';
}


}

/// @nodoc
abstract mixin class _$QuestionBlankCopyWith<$Res> implements $QuestionBlankCopyWith<$Res> {
  factory _$QuestionBlankCopyWith(_QuestionBlank value, $Res Function(_QuestionBlank) _then) = __$QuestionBlankCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'correct_answer') String correctAnswer, List<String> distractors
});




}
/// @nodoc
class __$QuestionBlankCopyWithImpl<$Res>
    implements _$QuestionBlankCopyWith<$Res> {
  __$QuestionBlankCopyWithImpl(this._self, this._then);

  final _QuestionBlank _self;
  final $Res Function(_QuestionBlank) _then;

/// Create a copy of QuestionBlank
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? correctAnswer = null,Object? distractors = null,}) {
  return _then(_QuestionBlank(
correctAnswer: null == correctAnswer ? _self.correctAnswer : correctAnswer // ignore: cast_nullable_to_non_nullable
as String,distractors: null == distractors ? _self._distractors : distractors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SentenceEquivalence {

@JsonKey(name: 'question_text') String get questionText;@JsonKey(name: 'correct_answers') List<String> get correctAnswers; List<String> get distractors;
/// Create a copy of SentenceEquivalence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentenceEquivalenceCopyWith<SentenceEquivalence> get copyWith => _$SentenceEquivalenceCopyWithImpl<SentenceEquivalence>(this as SentenceEquivalence, _$identity);

  /// Serializes this SentenceEquivalence to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentenceEquivalence&&(identical(other.questionText, questionText) || other.questionText == questionText)&&const DeepCollectionEquality().equals(other.correctAnswers, correctAnswers)&&const DeepCollectionEquality().equals(other.distractors, distractors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionText,const DeepCollectionEquality().hash(correctAnswers),const DeepCollectionEquality().hash(distractors));

@override
String toString() {
  return 'SentenceEquivalence(questionText: $questionText, correctAnswers: $correctAnswers, distractors: $distractors)';
}


}

/// @nodoc
abstract mixin class $SentenceEquivalenceCopyWith<$Res>  {
  factory $SentenceEquivalenceCopyWith(SentenceEquivalence value, $Res Function(SentenceEquivalence) _then) = _$SentenceEquivalenceCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'question_text') String questionText,@JsonKey(name: 'correct_answers') List<String> correctAnswers, List<String> distractors
});




}
/// @nodoc
class _$SentenceEquivalenceCopyWithImpl<$Res>
    implements $SentenceEquivalenceCopyWith<$Res> {
  _$SentenceEquivalenceCopyWithImpl(this._self, this._then);

  final SentenceEquivalence _self;
  final $Res Function(SentenceEquivalence) _then;

/// Create a copy of SentenceEquivalence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionText = null,Object? correctAnswers = null,Object? distractors = null,}) {
  return _then(_self.copyWith(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as List<String>,distractors: null == distractors ? _self.distractors : distractors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SentenceEquivalence].
extension SentenceEquivalencePatterns on SentenceEquivalence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SentenceEquivalence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SentenceEquivalence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SentenceEquivalence value)  $default,){
final _that = this;
switch (_that) {
case _SentenceEquivalence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SentenceEquivalence value)?  $default,){
final _that = this;
switch (_that) {
case _SentenceEquivalence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'question_text')  String questionText, @JsonKey(name: 'correct_answers')  List<String> correctAnswers,  List<String> distractors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SentenceEquivalence() when $default != null:
return $default(_that.questionText,_that.correctAnswers,_that.distractors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'question_text')  String questionText, @JsonKey(name: 'correct_answers')  List<String> correctAnswers,  List<String> distractors)  $default,) {final _that = this;
switch (_that) {
case _SentenceEquivalence():
return $default(_that.questionText,_that.correctAnswers,_that.distractors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'question_text')  String questionText, @JsonKey(name: 'correct_answers')  List<String> correctAnswers,  List<String> distractors)?  $default,) {final _that = this;
switch (_that) {
case _SentenceEquivalence() when $default != null:
return $default(_that.questionText,_that.correctAnswers,_that.distractors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SentenceEquivalence implements SentenceEquivalence {
  const _SentenceEquivalence({@JsonKey(name: 'question_text') required this.questionText, @JsonKey(name: 'correct_answers') required final  List<String> correctAnswers, required final  List<String> distractors}): _correctAnswers = correctAnswers,_distractors = distractors;
  factory _SentenceEquivalence.fromJson(Map<String, dynamic> json) => _$SentenceEquivalenceFromJson(json);

@override@JsonKey(name: 'question_text') final  String questionText;
 final  List<String> _correctAnswers;
@override@JsonKey(name: 'correct_answers') List<String> get correctAnswers {
  if (_correctAnswers is EqualUnmodifiableListView) return _correctAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_correctAnswers);
}

 final  List<String> _distractors;
@override List<String> get distractors {
  if (_distractors is EqualUnmodifiableListView) return _distractors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_distractors);
}


/// Create a copy of SentenceEquivalence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentenceEquivalenceCopyWith<_SentenceEquivalence> get copyWith => __$SentenceEquivalenceCopyWithImpl<_SentenceEquivalence>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SentenceEquivalenceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentenceEquivalence&&(identical(other.questionText, questionText) || other.questionText == questionText)&&const DeepCollectionEquality().equals(other._correctAnswers, _correctAnswers)&&const DeepCollectionEquality().equals(other._distractors, _distractors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,questionText,const DeepCollectionEquality().hash(_correctAnswers),const DeepCollectionEquality().hash(_distractors));

@override
String toString() {
  return 'SentenceEquivalence(questionText: $questionText, correctAnswers: $correctAnswers, distractors: $distractors)';
}


}

/// @nodoc
abstract mixin class _$SentenceEquivalenceCopyWith<$Res> implements $SentenceEquivalenceCopyWith<$Res> {
  factory _$SentenceEquivalenceCopyWith(_SentenceEquivalence value, $Res Function(_SentenceEquivalence) _then) = __$SentenceEquivalenceCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'question_text') String questionText,@JsonKey(name: 'correct_answers') List<String> correctAnswers, List<String> distractors
});




}
/// @nodoc
class __$SentenceEquivalenceCopyWithImpl<$Res>
    implements _$SentenceEquivalenceCopyWith<$Res> {
  __$SentenceEquivalenceCopyWithImpl(this._self, this._then);

  final _SentenceEquivalence _self;
  final $Res Function(_SentenceEquivalence) _then;

/// Create a copy of SentenceEquivalence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionText = null,Object? correctAnswers = null,Object? distractors = null,}) {
  return _then(_SentenceEquivalence(
questionText: null == questionText ? _self.questionText : questionText // ignore: cast_nullable_to_non_nullable
as String,correctAnswers: null == correctAnswers ? _self._correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as List<String>,distractors: null == distractors ? _self._distractors : distractors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
