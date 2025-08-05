part of 'skripsi_bloc.dart';

@freezed
class SkripsiEvent with _$SkripsiEvent {
  const factory SkripsiEvent.started() = _Started;
  const factory SkripsiEvent.fetch() = _Fetch;
}
