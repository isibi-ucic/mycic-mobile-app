import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/data/datasources/mhs_remote_datasource.dart';
import 'package:myapp/data/models/presensi_response_model.dart';

part 'mhs_presensi_event.dart';
part 'mhs_presensi_state.dart';
part 'mhs_presensi_bloc.freezed.dart';

class MhsPresensiBloc extends Bloc<MhsPresensiEvent, MhsPresensiState> {
  MhsPresensiBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await MhsRemoteDatasource().getPresensi();
      response.fold((l) => emit(_Error(l)), (r) {
        debugPrint(r.toString());
        emit(_Success(r));
      });
    });
  }
}
