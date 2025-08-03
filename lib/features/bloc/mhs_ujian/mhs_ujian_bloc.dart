import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/mhs_remote_datasource.dart';
import 'package:mycic_app/data/models/ujian_response_model.dart';

part 'mhs_ujian_event.dart';
part 'mhs_ujian_state.dart';
part 'mhs_ujian_bloc.freezed.dart';

class MhsUjianBloc extends Bloc<MhsUjianEvent, MhsUjianState> {
  MhsUjianBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await MhsRemoteDatasource().getUjian();
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
