part of 'dsn_skripsi_bloc.dart';

@freezed
class DsnSkripsiState with _$DsnSkripsiState {
  const factory DsnSkripsiState.initial() = _Initial;
  const factory DsnSkripsiState.loading() = _Loading;
  const factory DsnSkripsiState.success(DsnSkripsiResponseModel response) =
      _Success;
  const factory DsnSkripsiState.error(String message) = _Error;
}
