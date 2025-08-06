part of 'presensi_rekap_bloc.dart';

@freezed
class PresensiRekapEvent with _$PresensiRekapEvent {
  const factory PresensiRekapEvent.started() = _Started;
  const factory PresensiRekapEvent.fetch(int kelasId) = _Fetch;
}
