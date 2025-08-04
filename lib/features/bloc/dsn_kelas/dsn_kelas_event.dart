part of 'dsn_kelas_bloc.dart';

@freezed
class DsnKelasEvent with _$DsnKelasEvent {
  const factory DsnKelasEvent.started() = _Started;
  const factory DsnKelasEvent.fetch() = _Fetch;
}