part of 'mhs_kelas_bloc.dart';

// Opsional tapi sangat direkomendasikan: Gunakan enum untuk status
enum MhsKelasStatus { initial, loading, success, error }

@freezed
class MhsKelasState with _$MhsKelasState {
  const factory MhsKelasState({
    @Default(MhsKelasStatus.initial) MhsKelasStatus status,
    final KelasResponseModel? kelas,
    final PertemuanKelasResponseModel? pertemuan,
    final KelasTodayResponseModel? kelasToday,
    final String? errorMessage,
  }) = _MhsKelasState;
}
