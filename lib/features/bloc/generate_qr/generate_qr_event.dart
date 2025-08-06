part of 'generate_qr_bloc.dart';

@freezed
class GenerateQrEvent with _$GenerateQrEvent {
  const factory GenerateQrEvent.started() = _Started;
  const factory GenerateQrEvent.generateQr(
    int peretmeuanId,
    DateTime dateTime,
  ) = _GenerateQr;
}
