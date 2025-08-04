part of 'mhs_kelas_pertemuan_bloc.dart';

@freezed
class MhsKelasPertemuanState with _$MhsKelasPertemuanState {
  const factory MhsKelasPertemuanState.initial() = _Initial;
  const factory MhsKelasPertemuanState.loading() = _Loading;
  const factory MhsKelasPertemuanState.success(
    PertemuanKelasResponseModel data,
  ) = _Success;
  const factory MhsKelasPertemuanState.error(String message) = _Error;
}
