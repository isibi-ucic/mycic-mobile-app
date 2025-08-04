part of 'dsn_kelas_pertemuan_bloc.dart';

@freezed
class DsnKelasPertemuanEvent with _$DsnKelasPertemuanEvent {
  const factory DsnKelasPertemuanEvent.started() = _Started;
  const factory DsnKelasPertemuanEvent.fetch(int kelasId) = _Fetch;
}
