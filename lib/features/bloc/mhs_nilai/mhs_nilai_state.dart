part of 'mhs_nilai_bloc.dart';

// Opsional tapi sangat direkomendasikan: Gunakan enum untuk status
enum MhsNilaiStatus { initial, loading, success, error }

@freezed
class MhsNilaiState with _$MhsNilaiState {
  const factory MhsNilaiState({
    @Default(MhsNilaiStatus.initial) MhsNilaiStatus status,
    final NilaiResponseModel? nilai,
    final TranskripResponseModel? transkrip,
    final String? errorMessage,
  }) = _MhsNilaiState;
}
