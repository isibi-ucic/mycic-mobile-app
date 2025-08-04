part of 'mhs_kelas_pertemuan_detail_bloc.dart';

@freezed
class MhsKelasPertemuanDetailEvent with _$MhsKelasPertemuanDetailEvent {
  const factory MhsKelasPertemuanDetailEvent.started() = _Started;
  const factory MhsKelasPertemuanDetailEvent.fetch(int pertemuanId) = _Fetch;
}
