part of 'dsn_kelas_today_bloc.dart';

@freezed
class DsnKelasTodayEvent with _$DsnKelasTodayEvent {
  const factory DsnKelasTodayEvent.started() = _Started;
  const factory DsnKelasTodayEvent.fetch() = _Fetch;
}