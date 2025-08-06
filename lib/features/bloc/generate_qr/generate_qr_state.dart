part of 'generate_qr_bloc.dart';

@freezed
class GenerateQrState with _$GenerateQrState {
  const factory GenerateQrState.initial() = _Initial;
  const factory GenerateQrState.loading() = _Loading;
  const factory GenerateQrState.success(String qrData) = _Success;
  const factory GenerateQrState.error(String message) = _Error;
}
