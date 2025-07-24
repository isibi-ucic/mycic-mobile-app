part of 'info_bloc.dart';

@freezed
class InfoEvent with _$InfoEvent {
  const factory InfoEvent.started() = _Started;
  const factory InfoEvent.fetch() = _Fetch;
}