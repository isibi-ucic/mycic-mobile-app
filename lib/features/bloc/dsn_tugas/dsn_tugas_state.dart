part of 'dsn_tugas_bloc.dart';

@freezed
class DsnTugasState with _$DsnTugasState {
  const factory DsnTugasState.initial() = _Initial;
  const factory DsnTugasState.loading() = _Loading;
  const factory DsnTugasState.success(DsnTugasResponseModel data) = _Success;
  const factory DsnTugasState.error(String message) = _Error;
}
