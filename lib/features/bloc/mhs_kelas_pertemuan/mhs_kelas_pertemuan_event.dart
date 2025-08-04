part of 'mhs_kelas_pertemuan_bloc.dart';

@freezed
class MhsKelasPertemuanEvent with _$MhsKelasPertemuanEvent {
  const factory MhsKelasPertemuanEvent.started() = _Started;
  const factory MhsKelasPertemuanEvent.fetch(int kelasId) = _Fetch;
}
