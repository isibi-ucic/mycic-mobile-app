import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/app_remote_datasource.dart';
import 'package:mycic_app/data/models/mhs_skripsi_response_model.dart';

part 'skripsi_event.dart';
part 'skripsi_state.dart';
part 'skripsi_bloc.freezed.dart';

class SkripsiBloc extends Bloc<SkripsiEvent, SkripsiState> {
  SkripsiBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await AppRemoteDatasource().getSkripsi();
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
