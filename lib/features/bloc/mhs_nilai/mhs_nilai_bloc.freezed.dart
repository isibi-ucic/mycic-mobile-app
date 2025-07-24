// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mhs_nilai_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MhsNilaiEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String nim) getKHS,
    required TResult Function(String nim) getTranskrip,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String nim)? getKHS,
    TResult? Function(String nim)? getTranskrip,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String nim)? getKHS,
    TResult Function(String nim)? getTranskrip,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetKHS value) getKHS,
    required TResult Function(_GetTranskrip value) getTranskrip,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetKHS value)? getKHS,
    TResult? Function(_GetTranskrip value)? getTranskrip,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetKHS value)? getKHS,
    TResult Function(_GetTranskrip value)? getTranskrip,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MhsNilaiEventCopyWith<$Res> {
  factory $MhsNilaiEventCopyWith(
          MhsNilaiEvent value, $Res Function(MhsNilaiEvent) then) =
      _$MhsNilaiEventCopyWithImpl<$Res, MhsNilaiEvent>;
}

/// @nodoc
class _$MhsNilaiEventCopyWithImpl<$Res, $Val extends MhsNilaiEvent>
    implements $MhsNilaiEventCopyWith<$Res> {
  _$MhsNilaiEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$MhsNilaiEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'MhsNilaiEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String nim) getKHS,
    required TResult Function(String nim) getTranskrip,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String nim)? getKHS,
    TResult? Function(String nim)? getTranskrip,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String nim)? getKHS,
    TResult Function(String nim)? getTranskrip,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetKHS value) getKHS,
    required TResult Function(_GetTranskrip value) getTranskrip,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetKHS value)? getKHS,
    TResult? Function(_GetTranskrip value)? getTranskrip,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetKHS value)? getKHS,
    TResult Function(_GetTranskrip value)? getTranskrip,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements MhsNilaiEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$GetKHSImplCopyWith<$Res> {
  factory _$$GetKHSImplCopyWith(
          _$GetKHSImpl value, $Res Function(_$GetKHSImpl) then) =
      __$$GetKHSImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String nim});
}

/// @nodoc
class __$$GetKHSImplCopyWithImpl<$Res>
    extends _$MhsNilaiEventCopyWithImpl<$Res, _$GetKHSImpl>
    implements _$$GetKHSImplCopyWith<$Res> {
  __$$GetKHSImplCopyWithImpl(
      _$GetKHSImpl _value, $Res Function(_$GetKHSImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nim = null,
  }) {
    return _then(_$GetKHSImpl(
      null == nim
          ? _value.nim
          : nim // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetKHSImpl implements _GetKHS {
  const _$GetKHSImpl(this.nim);

  @override
  final String nim;

  @override
  String toString() {
    return 'MhsNilaiEvent.getKHS(nim: $nim)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetKHSImpl &&
            (identical(other.nim, nim) || other.nim == nim));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nim);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetKHSImplCopyWith<_$GetKHSImpl> get copyWith =>
      __$$GetKHSImplCopyWithImpl<_$GetKHSImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String nim) getKHS,
    required TResult Function(String nim) getTranskrip,
  }) {
    return getKHS(nim);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String nim)? getKHS,
    TResult? Function(String nim)? getTranskrip,
  }) {
    return getKHS?.call(nim);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String nim)? getKHS,
    TResult Function(String nim)? getTranskrip,
    required TResult orElse(),
  }) {
    if (getKHS != null) {
      return getKHS(nim);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetKHS value) getKHS,
    required TResult Function(_GetTranskrip value) getTranskrip,
  }) {
    return getKHS(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetKHS value)? getKHS,
    TResult? Function(_GetTranskrip value)? getTranskrip,
  }) {
    return getKHS?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetKHS value)? getKHS,
    TResult Function(_GetTranskrip value)? getTranskrip,
    required TResult orElse(),
  }) {
    if (getKHS != null) {
      return getKHS(this);
    }
    return orElse();
  }
}

abstract class _GetKHS implements MhsNilaiEvent {
  const factory _GetKHS(final String nim) = _$GetKHSImpl;

  String get nim;
  @JsonKey(ignore: true)
  _$$GetKHSImplCopyWith<_$GetKHSImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetTranskripImplCopyWith<$Res> {
  factory _$$GetTranskripImplCopyWith(
          _$GetTranskripImpl value, $Res Function(_$GetTranskripImpl) then) =
      __$$GetTranskripImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String nim});
}

/// @nodoc
class __$$GetTranskripImplCopyWithImpl<$Res>
    extends _$MhsNilaiEventCopyWithImpl<$Res, _$GetTranskripImpl>
    implements _$$GetTranskripImplCopyWith<$Res> {
  __$$GetTranskripImplCopyWithImpl(
      _$GetTranskripImpl _value, $Res Function(_$GetTranskripImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nim = null,
  }) {
    return _then(_$GetTranskripImpl(
      null == nim
          ? _value.nim
          : nim // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetTranskripImpl implements _GetTranskrip {
  const _$GetTranskripImpl(this.nim);

  @override
  final String nim;

  @override
  String toString() {
    return 'MhsNilaiEvent.getTranskrip(nim: $nim)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetTranskripImpl &&
            (identical(other.nim, nim) || other.nim == nim));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nim);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetTranskripImplCopyWith<_$GetTranskripImpl> get copyWith =>
      __$$GetTranskripImplCopyWithImpl<_$GetTranskripImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String nim) getKHS,
    required TResult Function(String nim) getTranskrip,
  }) {
    return getTranskrip(nim);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String nim)? getKHS,
    TResult? Function(String nim)? getTranskrip,
  }) {
    return getTranskrip?.call(nim);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String nim)? getKHS,
    TResult Function(String nim)? getTranskrip,
    required TResult orElse(),
  }) {
    if (getTranskrip != null) {
      return getTranskrip(nim);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetKHS value) getKHS,
    required TResult Function(_GetTranskrip value) getTranskrip,
  }) {
    return getTranskrip(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetKHS value)? getKHS,
    TResult? Function(_GetTranskrip value)? getTranskrip,
  }) {
    return getTranskrip?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetKHS value)? getKHS,
    TResult Function(_GetTranskrip value)? getTranskrip,
    required TResult orElse(),
  }) {
    if (getTranskrip != null) {
      return getTranskrip(this);
    }
    return orElse();
  }
}

abstract class _GetTranskrip implements MhsNilaiEvent {
  const factory _GetTranskrip(final String nim) = _$GetTranskripImpl;

  String get nim;
  @JsonKey(ignore: true)
  _$$GetTranskripImplCopyWith<_$GetTranskripImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MhsNilaiState {
  MhsNilaiStatus get status => throw _privateConstructorUsedError;
  NilaiResponseModel? get nilai => throw _privateConstructorUsedError;
  TranskripResponseModel? get transkrip => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MhsNilaiStateCopyWith<MhsNilaiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MhsNilaiStateCopyWith<$Res> {
  factory $MhsNilaiStateCopyWith(
          MhsNilaiState value, $Res Function(MhsNilaiState) then) =
      _$MhsNilaiStateCopyWithImpl<$Res, MhsNilaiState>;
  @useResult
  $Res call(
      {MhsNilaiStatus status,
      NilaiResponseModel? nilai,
      TranskripResponseModel? transkrip,
      String? errorMessage});
}

/// @nodoc
class _$MhsNilaiStateCopyWithImpl<$Res, $Val extends MhsNilaiState>
    implements $MhsNilaiStateCopyWith<$Res> {
  _$MhsNilaiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? nilai = freezed,
    Object? transkrip = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MhsNilaiStatus,
      nilai: freezed == nilai
          ? _value.nilai
          : nilai // ignore: cast_nullable_to_non_nullable
              as NilaiResponseModel?,
      transkrip: freezed == transkrip
          ? _value.transkrip
          : transkrip // ignore: cast_nullable_to_non_nullable
              as TranskripResponseModel?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MhsNilaiStateImplCopyWith<$Res>
    implements $MhsNilaiStateCopyWith<$Res> {
  factory _$$MhsNilaiStateImplCopyWith(
          _$MhsNilaiStateImpl value, $Res Function(_$MhsNilaiStateImpl) then) =
      __$$MhsNilaiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MhsNilaiStatus status,
      NilaiResponseModel? nilai,
      TranskripResponseModel? transkrip,
      String? errorMessage});
}

/// @nodoc
class __$$MhsNilaiStateImplCopyWithImpl<$Res>
    extends _$MhsNilaiStateCopyWithImpl<$Res, _$MhsNilaiStateImpl>
    implements _$$MhsNilaiStateImplCopyWith<$Res> {
  __$$MhsNilaiStateImplCopyWithImpl(
      _$MhsNilaiStateImpl _value, $Res Function(_$MhsNilaiStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? nilai = freezed,
    Object? transkrip = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$MhsNilaiStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MhsNilaiStatus,
      nilai: freezed == nilai
          ? _value.nilai
          : nilai // ignore: cast_nullable_to_non_nullable
              as NilaiResponseModel?,
      transkrip: freezed == transkrip
          ? _value.transkrip
          : transkrip // ignore: cast_nullable_to_non_nullable
              as TranskripResponseModel?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MhsNilaiStateImpl implements _MhsNilaiState {
  const _$MhsNilaiStateImpl(
      {this.status = MhsNilaiStatus.initial,
      this.nilai,
      this.transkrip,
      this.errorMessage});

  @override
  @JsonKey()
  final MhsNilaiStatus status;
  @override
  final NilaiResponseModel? nilai;
  @override
  final TranskripResponseModel? transkrip;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'MhsNilaiState(status: $status, nilai: $nilai, transkrip: $transkrip, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MhsNilaiStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.nilai, nilai) || other.nilai == nilai) &&
            (identical(other.transkrip, transkrip) ||
                other.transkrip == transkrip) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, nilai, transkrip, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MhsNilaiStateImplCopyWith<_$MhsNilaiStateImpl> get copyWith =>
      __$$MhsNilaiStateImplCopyWithImpl<_$MhsNilaiStateImpl>(this, _$identity);
}

abstract class _MhsNilaiState implements MhsNilaiState {
  const factory _MhsNilaiState(
      {final MhsNilaiStatus status,
      final NilaiResponseModel? nilai,
      final TranskripResponseModel? transkrip,
      final String? errorMessage}) = _$MhsNilaiStateImpl;

  @override
  MhsNilaiStatus get status;
  @override
  NilaiResponseModel? get nilai;
  @override
  TranskripResponseModel? get transkrip;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$MhsNilaiStateImplCopyWith<_$MhsNilaiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
