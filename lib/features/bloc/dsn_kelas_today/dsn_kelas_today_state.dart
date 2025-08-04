part of 'dsn_kelas_today_bloc.dart';

@freezed
class DsnKelasTodayState with _$DsnKelasTodayState {
  const factory DsnKelasTodayState.initial() = _Initial;
  const factory DsnKelasTodayState.loading() = _Loading;
  const factory DsnKelasTodayState.success(KelasTodayResponseModel data) =
      _Success;
  const factory DsnKelasTodayState.error(String message) = _Error;
}
