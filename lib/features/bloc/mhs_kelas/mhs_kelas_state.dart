part of 'mhs_kelas_bloc.dart';

@freezed
class MhsKelasState with _$MhsKelasState {
  const factory MhsKelasState.initial() = _Initial;
  const factory MhsKelasState.loading() = _Loading;
  const factory MhsKelasState.success(KelasResponseModel data) = _Success;
  const factory MhsKelasState.error(String message) = _Error;
}
