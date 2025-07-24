part of 'transkrip_bloc.dart';

@freezed
class TranskripEvent with _$TranskripEvent {
  const factory TranskripEvent.started() = _Started;
  const factory TranskripEvent.fetch() = _Fetch;
}
