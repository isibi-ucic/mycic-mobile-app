part of 'mhs_ujian_bloc.dart';

@freezed
class MhsUjianEvent with _$MhsUjianEvent {
  const factory MhsUjianEvent.started() = _Started;
  const factory MhsUjianEvent.fetch() = _Fetch;
}