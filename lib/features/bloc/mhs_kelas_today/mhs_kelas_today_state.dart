part of 'mhs_kelas_today_bloc.dart';

@freezed
class MhsKelasTodayState with _$MhsKelasTodayState {
  const factory MhsKelasTodayState.initial() = _Initial;
  const factory MhsKelasTodayState.loading() = _Loading;
  const factory MhsKelasTodayState.success(MhsKelasTodayResponseModel data) =
      _Success;
  const factory MhsKelasTodayState.error(String message) = _Error;
}
