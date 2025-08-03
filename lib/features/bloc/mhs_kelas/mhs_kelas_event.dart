part of 'mhs_kelas_bloc.dart';

@freezed
class MhsKelasEvent with _$MhsKelasEvent {
  const factory MhsKelasEvent.started() = _Started;
  const factory MhsKelasEvent.fetch() = _Fetch;
}
