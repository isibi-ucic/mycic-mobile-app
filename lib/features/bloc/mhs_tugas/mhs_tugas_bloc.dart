import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/kelas_remote_datasource.dart';
import 'package:mycic_app/data/models/mhs_tugas_response_model.dart';

part 'mhs_tugas_event.dart';
part 'mhs_tugas_state.dart';
part 'mhs_tugas_bloc.freezed.dart';

class MhsTugasBloc extends Bloc<MhsTugasEvent, MhsTugasState> {
  MhsTugasBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());
      try {
        final response = await KelasRemoteDatasource().getTugasMhs();
        response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
      } catch (e) {
        debugPrint('error tugas: $e');
        emit(_Error(e.toString()));
      }
    });
  }
}
