part of 'mhs_kelas_detail_bloc.dart';

@freezed
class MhsKelasDetailEvent with _$MhsKelasDetailEvent {
  const factory MhsKelasDetailEvent.started() = _Started;
  const factory MhsKelasDetailEvent.fetch(int idMk) = _Fetch;
}
