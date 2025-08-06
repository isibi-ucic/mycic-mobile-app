part of 'presensi_rekap_bloc.dart';

@freezed
class PresensiRekapState with _$PresensiRekapState {
  const factory PresensiRekapState.initial() = _Initial;
  const factory PresensiRekapState.loading() = _Loading;
  const factory PresensiRekapState.success(
    PresensiRekapResponseModel response,
  ) = _Success;
  const factory PresensiRekapState.error(String message) = _Error;
}
