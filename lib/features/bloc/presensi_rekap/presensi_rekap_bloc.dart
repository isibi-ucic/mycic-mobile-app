import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/dsn_remote_datasource.dart';
import 'package:mycic_app/data/models/presensi_rekap_response_model.dart';

part 'presensi_rekap_event.dart';
part 'presensi_rekap_state.dart';
part 'presensi_rekap_bloc.freezed.dart';

class PresensiRekapBloc extends Bloc<PresensiRekapEvent, PresensiRekapState> {
  PresensiRekapBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await DsnRemoteDatasource().getRekapPresensi(
        event.kelasId,
      );
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
