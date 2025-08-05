part of 'skripsi_bloc.dart';

@freezed
class SkripsiState with _$SkripsiState {
  const factory SkripsiState.initial() = _Initial;
  const factory SkripsiState.loading() = _Loading;
  const factory SkripsiState.success(MhsSkripsiResponseModel data) = _Success;
  const factory SkripsiState.error(String message) = _Error;
}
