part of 'mhs_presensi_bloc.dart';

@freezed
class MhsPresensiEvent with _$MhsPresensiEvent {
  const factory MhsPresensiEvent.started() = _Started;
  const factory MhsPresensiEvent.fetch() = _Fetch;
}
