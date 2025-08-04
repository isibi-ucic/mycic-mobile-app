part of 'mhs_kelas_pertemuan_detail_bloc.dart';

@freezed
class MhsKelasPertemuanDetailState with _$MhsKelasPertemuanDetailState {
  const factory MhsKelasPertemuanDetailState.initial() = _Initial;
  const factory MhsKelasPertemuanDetailState.loading() = _Loading;
  const factory MhsKelasPertemuanDetailState.success(
    DetailPertemuanKelasResponseModel data,
  ) = _Success;
  const factory MhsKelasPertemuanDetailState.error(String message) = _Error;
}
