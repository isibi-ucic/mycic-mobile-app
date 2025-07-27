part of 'mhs_ujian_bloc.dart';

@freezed
class MhsUjianState with _$MhsUjianState {
  const factory MhsUjianState.initial() = _Initial;
  const factory MhsUjianState.loading() = _Loading;
  const factory MhsUjianState.success(UjianResponseModel data) = _Success;
  const factory MhsUjianState.error(String message) = _Error;
}
