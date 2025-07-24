part of 'mhs_kelas_bloc.dart';

@freezed
class MhsKelasEvent with _$MhsKelasEvent {
  const factory MhsKelasEvent.started() = _Started;
  const factory MhsKelasEvent.getKelas() = _GetKelas;
  const factory MhsKelasEvent.getKelasPertemuan(int mkId) = _GetKelasPertemuan;
  const factory MhsKelasEvent.getKelasToday(int mkId) = _GetKelasToday;
}
