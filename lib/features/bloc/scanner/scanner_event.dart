part of 'scanner_bloc.dart';

@freezed
class ScannerEvent with _$ScannerEvent {
  const factory ScannerEvent.started() = _Started;

  const factory ScannerEvent.submit(String qrCode) = _Submit;
}
