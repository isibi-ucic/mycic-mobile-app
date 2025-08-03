part of 'mhs_tugas_bloc.dart';

@freezed
class MhsTugasState with _$MhsTugasState {
  const factory MhsTugasState.initial() = _Initial;
  const factory MhsTugasState.loading() = _Loading;
  const factory MhsTugasState.success(MhsTugasResponseModel data) = _Success;
  const factory MhsTugasState.error(String message) = _Error;
}
