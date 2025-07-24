import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/data/datasources/kelas_remote_datasource.dart';
import 'package:myapp/data/models/kelas_response_model.dart';
import 'package:myapp/data/models/kelas_today_response_model.dart';
import 'package:myapp/data/models/pertemuan_kelas_response_model.dart';

part 'mhs_kelas_event.dart';
part 'mhs_kelas_state.dart';
part 'mhs_kelas_bloc.freezed.dart';

class MhsKelasBloc extends Bloc<MhsKelasEvent, MhsKelasState> {
  MhsKelasBloc() : super(MhsKelasState()) {
    // 2. Sesuaikan handler _GetKelas
    on<_GetKelas>((event, emit) async {
      // Emit loading, tapi state lama tetap ada sebagai basis
      emit(
        state.copyWith(
          status: MhsKelasStatus.loading,
          kelas: null,
          pertemuan: null,
          kelasToday: null,
        ),
      );

      final result = await KelasRemoteDatasource().getKelasMhs();

      result.fold(
        (l) {
          emit(
            state.copyWith(
              status: MhsKelasStatus.error,
              errorMessage: l, // Asumsi l adalah String
            ),
          );
        },
        (r) {
          // Update state dengan status success dan data kelas
          emit(state.copyWith(status: MhsKelasStatus.success, kelas: r));
        },
      );
    });

    on<_GetKelasPertemuan>((event, emit) async {
      // Set semua ke null untuk membersihkan data lama
      emit(
        state.copyWith(
          status: MhsKelasStatus.loading,
          kelas: null,
          pertemuan: null,
          kelasToday: null,
        ),
      );

      final result = await KelasRemoteDatasource().getKelasPertemuanMhs(
        event.mkId,
      );

      result.fold(
        (l) {
          emit(
            state.copyWith(
              status: MhsKelasStatus.error,
              errorMessage: l, // Asumsi l adalah String
            ),
          );
        },
        (r) {
          debugPrint(r.toString());
          // Update state dengan status success dan data kelas
          emit(state.copyWith(status: MhsKelasStatus.success, pertemuan: r));
        },
      );
    });

    on<_GetKelasToday>((event, emit) async {
      // Set semua ke null untuk membersihkan data lama
      emit(
        state.copyWith(
          status: MhsKelasStatus.loading,
          kelas: null,
          pertemuan: null,
          kelasToday: null,
        ),
      );

      final result = await KelasRemoteDatasource().getKelasTodayMhs(event.mkId);

      result.fold(
        (l) {
          emit(
            state.copyWith(
              status: MhsKelasStatus.error,
              errorMessage: l, // Asumsi l adalah String
            ),
          );
        },
        (r) {
          debugPrint(r.toString());
          // Update state dengan status success dan data
          emit(state.copyWith(status: MhsKelasStatus.success, kelasToday: r));
        },
      );
    });
  }
}
