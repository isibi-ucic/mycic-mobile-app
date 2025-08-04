part of 'dsn_kelas_bloc.dart';

@freezed
class DsnKelasState with _$DsnKelasState {
  const factory DsnKelasState.initial() = _Initial;
  const factory DsnKelasState.loading() = _Loading;
  const factory DsnKelasState.success(KelasResponseModel data) = _Success;
  const factory DsnKelasState.error(String message) = _Error;
}
