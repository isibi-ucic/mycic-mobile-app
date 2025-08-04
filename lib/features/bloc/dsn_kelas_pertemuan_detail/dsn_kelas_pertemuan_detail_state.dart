part of 'dsn_kelas_pertemuan_detail_bloc.dart';

@freezed
class DsnKelasPertemuanDetailState with _$DsnKelasPertemuanDetailState {
  const factory DsnKelasPertemuanDetailState.initial() = _Initial;
  const factory DsnKelasPertemuanDetailState.loading() = _Loading;
  const factory DsnKelasPertemuanDetailState.success(
    DetailPertemuanKelasResponseModel data,
  ) = _Success;
  const factory DsnKelasPertemuanDetailState.error(String message) = _Error;
}
