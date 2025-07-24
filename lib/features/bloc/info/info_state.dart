part of 'info_bloc.dart';

@freezed
class InfoState with _$InfoState {
  const factory InfoState.initial() = _Initial;
  const factory InfoState.loading() = _Loading;
  const factory InfoState.success(InfoResponseModel data) = _Success;
  const factory InfoState.error(String message) = _Error;
}
