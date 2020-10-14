// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'initial_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$InitialSettingModelTearOff {
  const _$InitialSettingModelTearOff();

// ignore: unused_element
  _InitialSettingModel call(
      {int fromMenstruation,
      int durationMenstruation,
      int reminderHour,
      int reminderMinute,
      bool isOnReminder = false,
      int todayPillNumber,
      PillSheetType pillSheetType}) {
    return _InitialSettingModel(
      fromMenstruation: fromMenstruation,
      durationMenstruation: durationMenstruation,
      reminderHour: reminderHour,
      reminderMinute: reminderMinute,
      isOnReminder: isOnReminder,
      todayPillNumber: todayPillNumber,
      pillSheetType: pillSheetType,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $InitialSettingModel = _$InitialSettingModelTearOff();

/// @nodoc
mixin _$InitialSettingModel {
  int get fromMenstruation;
  int get durationMenstruation;
  int get reminderHour;
  int get reminderMinute;
  bool get isOnReminder;
  int get todayPillNumber;
  PillSheetType get pillSheetType;

  $InitialSettingModelCopyWith<InitialSettingModel> get copyWith;
}

/// @nodoc
abstract class $InitialSettingModelCopyWith<$Res> {
  factory $InitialSettingModelCopyWith(
          InitialSettingModel value, $Res Function(InitialSettingModel) then) =
      _$InitialSettingModelCopyWithImpl<$Res>;
  $Res call(
      {int fromMenstruation,
      int durationMenstruation,
      int reminderHour,
      int reminderMinute,
      bool isOnReminder,
      int todayPillNumber,
      PillSheetType pillSheetType});
}

/// @nodoc
class _$InitialSettingModelCopyWithImpl<$Res>
    implements $InitialSettingModelCopyWith<$Res> {
  _$InitialSettingModelCopyWithImpl(this._value, this._then);

  final InitialSettingModel _value;
  // ignore: unused_field
  final $Res Function(InitialSettingModel) _then;

  @override
  $Res call({
    Object fromMenstruation = freezed,
    Object durationMenstruation = freezed,
    Object reminderHour = freezed,
    Object reminderMinute = freezed,
    Object isOnReminder = freezed,
    Object todayPillNumber = freezed,
    Object pillSheetType = freezed,
  }) {
    return _then(_value.copyWith(
      fromMenstruation: fromMenstruation == freezed
          ? _value.fromMenstruation
          : fromMenstruation as int,
      durationMenstruation: durationMenstruation == freezed
          ? _value.durationMenstruation
          : durationMenstruation as int,
      reminderHour:
          reminderHour == freezed ? _value.reminderHour : reminderHour as int,
      reminderMinute: reminderMinute == freezed
          ? _value.reminderMinute
          : reminderMinute as int,
      isOnReminder:
          isOnReminder == freezed ? _value.isOnReminder : isOnReminder as bool,
      todayPillNumber: todayPillNumber == freezed
          ? _value.todayPillNumber
          : todayPillNumber as int,
      pillSheetType: pillSheetType == freezed
          ? _value.pillSheetType
          : pillSheetType as PillSheetType,
    ));
  }
}

/// @nodoc
abstract class _$InitialSettingModelCopyWith<$Res>
    implements $InitialSettingModelCopyWith<$Res> {
  factory _$InitialSettingModelCopyWith(_InitialSettingModel value,
          $Res Function(_InitialSettingModel) then) =
      __$InitialSettingModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {int fromMenstruation,
      int durationMenstruation,
      int reminderHour,
      int reminderMinute,
      bool isOnReminder,
      int todayPillNumber,
      PillSheetType pillSheetType});
}

/// @nodoc
class __$InitialSettingModelCopyWithImpl<$Res>
    extends _$InitialSettingModelCopyWithImpl<$Res>
    implements _$InitialSettingModelCopyWith<$Res> {
  __$InitialSettingModelCopyWithImpl(
      _InitialSettingModel _value, $Res Function(_InitialSettingModel) _then)
      : super(_value, (v) => _then(v as _InitialSettingModel));

  @override
  _InitialSettingModel get _value => super._value as _InitialSettingModel;

  @override
  $Res call({
    Object fromMenstruation = freezed,
    Object durationMenstruation = freezed,
    Object reminderHour = freezed,
    Object reminderMinute = freezed,
    Object isOnReminder = freezed,
    Object todayPillNumber = freezed,
    Object pillSheetType = freezed,
  }) {
    return _then(_InitialSettingModel(
      fromMenstruation: fromMenstruation == freezed
          ? _value.fromMenstruation
          : fromMenstruation as int,
      durationMenstruation: durationMenstruation == freezed
          ? _value.durationMenstruation
          : durationMenstruation as int,
      reminderHour:
          reminderHour == freezed ? _value.reminderHour : reminderHour as int,
      reminderMinute: reminderMinute == freezed
          ? _value.reminderMinute
          : reminderMinute as int,
      isOnReminder:
          isOnReminder == freezed ? _value.isOnReminder : isOnReminder as bool,
      todayPillNumber: todayPillNumber == freezed
          ? _value.todayPillNumber
          : todayPillNumber as int,
      pillSheetType: pillSheetType == freezed
          ? _value.pillSheetType
          : pillSheetType as PillSheetType,
    ));
  }
}

/// @nodoc
class _$_InitialSettingModel extends _InitialSettingModel {
  _$_InitialSettingModel(
      {this.fromMenstruation,
      this.durationMenstruation,
      this.reminderHour,
      this.reminderMinute,
      this.isOnReminder = false,
      this.todayPillNumber,
      this.pillSheetType})
      : assert(isOnReminder != null),
        super._();

  @override
  final int fromMenstruation;
  @override
  final int durationMenstruation;
  @override
  final int reminderHour;
  @override
  final int reminderMinute;
  @JsonKey(defaultValue: false)
  @override
  final bool isOnReminder;
  @override
  final int todayPillNumber;
  @override
  final PillSheetType pillSheetType;

  @override
  String toString() {
    return 'InitialSettingModel(fromMenstruation: $fromMenstruation, durationMenstruation: $durationMenstruation, reminderHour: $reminderHour, reminderMinute: $reminderMinute, isOnReminder: $isOnReminder, todayPillNumber: $todayPillNumber, pillSheetType: $pillSheetType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InitialSettingModel &&
            (identical(other.fromMenstruation, fromMenstruation) ||
                const DeepCollectionEquality()
                    .equals(other.fromMenstruation, fromMenstruation)) &&
            (identical(other.durationMenstruation, durationMenstruation) ||
                const DeepCollectionEquality().equals(
                    other.durationMenstruation, durationMenstruation)) &&
            (identical(other.reminderHour, reminderHour) ||
                const DeepCollectionEquality()
                    .equals(other.reminderHour, reminderHour)) &&
            (identical(other.reminderMinute, reminderMinute) ||
                const DeepCollectionEquality()
                    .equals(other.reminderMinute, reminderMinute)) &&
            (identical(other.isOnReminder, isOnReminder) ||
                const DeepCollectionEquality()
                    .equals(other.isOnReminder, isOnReminder)) &&
            (identical(other.todayPillNumber, todayPillNumber) ||
                const DeepCollectionEquality()
                    .equals(other.todayPillNumber, todayPillNumber)) &&
            (identical(other.pillSheetType, pillSheetType) ||
                const DeepCollectionEquality()
                    .equals(other.pillSheetType, pillSheetType)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(fromMenstruation) ^
      const DeepCollectionEquality().hash(durationMenstruation) ^
      const DeepCollectionEquality().hash(reminderHour) ^
      const DeepCollectionEquality().hash(reminderMinute) ^
      const DeepCollectionEquality().hash(isOnReminder) ^
      const DeepCollectionEquality().hash(todayPillNumber) ^
      const DeepCollectionEquality().hash(pillSheetType);

  @override
  _$InitialSettingModelCopyWith<_InitialSettingModel> get copyWith =>
      __$InitialSettingModelCopyWithImpl<_InitialSettingModel>(
          this, _$identity);
}

abstract class _InitialSettingModel extends InitialSettingModel {
  _InitialSettingModel._() : super._();
  factory _InitialSettingModel(
      {int fromMenstruation,
      int durationMenstruation,
      int reminderHour,
      int reminderMinute,
      bool isOnReminder,
      int todayPillNumber,
      PillSheetType pillSheetType}) = _$_InitialSettingModel;

  @override
  int get fromMenstruation;
  @override
  int get durationMenstruation;
  @override
  int get reminderHour;
  @override
  int get reminderMinute;
  @override
  bool get isOnReminder;
  @override
  int get todayPillNumber;
  @override
  PillSheetType get pillSheetType;
  @override
  _$InitialSettingModelCopyWith<_InitialSettingModel> get copyWith;
}
