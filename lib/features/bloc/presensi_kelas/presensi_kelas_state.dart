part of 'presensi_kelas_bloc.dart';

@freezed
class PresensiKelasState with _$PresensiKelasState {
  const factory PresensiKelasState.initial() = _Initial;
  const factory PresensiKelasState.loading() = _Loading;
  const factory PresensiKelasState.success(
    PresensiKelasResponseModel response,
  ) = _Success;
  const factory PresensiKelasState.error(String message) = _Error;
}
