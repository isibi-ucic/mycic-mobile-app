part of 'dsn_kelas_pertemuan_detail_bloc.dart';

@freezed
class DsnKelasPertemuanDetailEvent with _$DsnKelasPertemuanDetailEvent {
  const factory DsnKelasPertemuanDetailEvent.started() = _Started;
  const factory DsnKelasPertemuanDetailEvent.fetch(int pertemuanId) = _Fetch;
}
