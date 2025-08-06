import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/dsn_remote_datasource.dart';
import 'package:mycic_app/data/models/dsn_skripsi_response_model.dart';

part 'dsn_skripsi_event.dart';
part 'dsn_skripsi_state.dart';
part 'dsn_skripsi_bloc.freezed.dart';

class DsnSkripsiBloc extends Bloc<DsnSkripsiEvent, DsnSkripsiState> {
  DsnSkripsiBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await DsnRemoteDatasource().getSkripsi();

      debugPrint('response bloc: $response');
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
