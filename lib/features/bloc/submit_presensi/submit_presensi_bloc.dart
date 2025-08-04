import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/kelas_remote_datasource.dart';

part 'submit_presensi_event.dart';
part 'submit_presensi_state.dart';
part 'submit_presensi_bloc.freezed.dart';

class SubmitPresensiBloc
    extends Bloc<SubmitPresensiEvent, SubmitPresensiState> {
  SubmitPresensiBloc() : super(_Initial()) {
    on<_SubmitPresensi>((event, emit) async {
      emit(_Loading());

      debugPrint('qrCode: ${event.qrCode}');
      final response = await KelasRemoteDatasource().submitPresensi(
        event.qrCode,
      );
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
