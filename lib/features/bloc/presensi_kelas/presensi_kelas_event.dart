part of 'presensi_kelas_bloc.dart';

@freezed
class PresensiKelasEvent with _$PresensiKelasEvent {
  const factory PresensiKelasEvent.started() = _Started;
  const factory PresensiKelasEvent.fetch() = _Fetch;
}
