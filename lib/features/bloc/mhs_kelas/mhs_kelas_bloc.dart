import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/kelas_remote_datasource.dart';
import 'package:mycic_app/data/models/kelas_response_model.dart';
import 'package:mycic_app/data/models/mhs_kelas_today_response_model.dart';
import 'package:mycic_app/data/models/pertemuan_kelas_response_model.dart';

part 'mhs_kelas_event.dart';
part 'mhs_kelas_state.dart';
part 'mhs_kelas_bloc.freezed.dart';

class MhsKelasBloc extends Bloc<MhsKelasEvent, MhsKelasState> {
  MhsKelasBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await KelasRemoteDatasource().getKelasMhs();
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
