part of 'mhs_kelas_detail_bloc.dart';

@freezed
class MhsKelasDetailState with _$MhsKelasDetailState {
  const factory MhsKelasDetailState.initial() = _Initial;
  const factory MhsKelasDetailState.loading() = _Loading;
  const factory MhsKelasDetailState.success(PertemuanKelasResponseModel data) =
      _Success;
  const factory MhsKelasDetailState.error(String message) = _Error;
}
