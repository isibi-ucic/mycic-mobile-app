part of 'dsn_skripsi_bloc.dart';

@freezed
class DsnSkripsiEvent with _$DsnSkripsiEvent {
  const factory DsnSkripsiEvent.started() = _Started;
  const factory DsnSkripsiEvent.fetch() = _Fetch;
}