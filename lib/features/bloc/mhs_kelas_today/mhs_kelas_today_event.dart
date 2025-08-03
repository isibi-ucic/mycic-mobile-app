part of 'mhs_kelas_today_bloc.dart';

@freezed
class MhsKelasTodayEvent with _$MhsKelasTodayEvent {
  const factory MhsKelasTodayEvent.started() = _Started;
  const factory MhsKelasTodayEvent.fetch() = _Fetch;
}
