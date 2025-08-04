part of 'dsn_tugas_bloc.dart';

@freezed
class DsnTugasEvent with _$DsnTugasEvent {
  const factory DsnTugasEvent.started() = _Started;
  const factory DsnTugasEvent.fetch() = _Fetch;
}