part of 'submit_presensi_bloc.dart';

@freezed
class SubmitPresensiState with _$SubmitPresensiState {
  const factory SubmitPresensiState.initial() = _Initial;
  const factory SubmitPresensiState.loading() = _Loading;
  const factory SubmitPresensiState.success(String message) = _Success;
  const factory SubmitPresensiState.error(String message) = _Error;
}
