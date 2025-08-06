import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/dsn_remote_datasource.dart';
import 'package:mycic_app/data/models/presensi_kelas_response_model.dart';

part 'presensi_kelas_event.dart';
part 'presensi_kelas_state.dart';
part 'presensi_kelas_bloc.freezed.dart';

class PresensiKelasBloc extends Bloc<PresensiKelasEvent, PresensiKelasState> {
  PresensiKelasBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await DsnRemoteDatasource().getInfoKelas();
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
