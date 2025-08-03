part of 'mhs_tugas_bloc.dart';

@freezed
class MhsTugasEvent with _$MhsTugasEvent {
  const factory MhsTugasEvent.started() = _Started;
  const factory MhsTugasEvent.fetch() = _Fetch;
}
