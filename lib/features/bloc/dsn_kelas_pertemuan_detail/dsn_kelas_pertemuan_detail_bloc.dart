import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/kelas_remote_datasource.dart';
import 'package:mycic_app/data/models/detail_pertemuan_kelas_response_model.dart';

part 'dsn_kelas_pertemuan_detail_event.dart';
part 'dsn_kelas_pertemuan_detail_state.dart';
part 'dsn_kelas_pertemuan_detail_bloc.freezed.dart';

class DsnKelasPertemuanDetailBloc
    extends Bloc<DsnKelasPertemuanDetailEvent, DsnKelasPertemuanDetailState> {
  DsnKelasPertemuanDetailBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      debugPrint('event pertemuanId: ${event.pertemuanId}');
      final response = await KelasRemoteDatasource().getKelasPertemuanDetailDsn(
        event.pertemuanId,
      );
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
