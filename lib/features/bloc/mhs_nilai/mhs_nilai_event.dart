part of 'mhs_nilai_bloc.dart';

@freezed
class MhsNilaiEvent with _$MhsNilaiEvent {
  const factory MhsNilaiEvent.started() = _Started;
  const factory MhsNilaiEvent.getKHS(String nim) = _GetKHS;
  const factory MhsNilaiEvent.getTranskrip(String nim) = _GetTranskrip;
}
