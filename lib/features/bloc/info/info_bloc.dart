import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/app_remote_datasource.dart';
import 'package:mycic_app/data/models/info_response_model.dart';

part 'info_event.dart';
part 'info_state.dart';
part 'info_bloc.freezed.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc() : super(_Initial()) {
    on<InfoEvent>((event, emit) async {
      emit(const _Loading());

      final response = await AppRemoteDatasource().getInfo();
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
