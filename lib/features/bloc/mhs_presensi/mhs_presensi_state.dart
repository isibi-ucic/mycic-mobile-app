part of 'mhs_presensi_bloc.dart';

@freezed
class MhsPresensiState with _$MhsPresensiState {
  const factory MhsPresensiState.initial() = _Initial;
  const factory MhsPresensiState.loading() = _Loading;
  const factory MhsPresensiState.success(PresensiResponseModel data) = _Success;
  const factory MhsPresensiState.error(String message) = _Error;
}
