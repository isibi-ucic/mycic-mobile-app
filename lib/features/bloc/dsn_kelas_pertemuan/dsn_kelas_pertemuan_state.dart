part of 'dsn_kelas_pertemuan_bloc.dart';

@freezed
class DsnKelasPertemuanState with _$DsnKelasPertemuanState {
  const factory DsnKelasPertemuanState.initial() = _Initial;
  const factory DsnKelasPertemuanState.loading() = _Loading;
  const factory DsnKelasPertemuanState.success(
    PertemuanKelasResponseModel data,
  ) = _Success;
  const factory DsnKelasPertemuanState.error(String message) = _Error;
}
