part of 'submit_presensi_bloc.dart';

@freezed
class SubmitPresensiEvent with _$SubmitPresensiEvent {
  const factory SubmitPresensiEvent.started() = _Started;
  const factory SubmitPresensiEvent.submitPresensi(String qrCode) =
      _SubmitPresensi;
}
