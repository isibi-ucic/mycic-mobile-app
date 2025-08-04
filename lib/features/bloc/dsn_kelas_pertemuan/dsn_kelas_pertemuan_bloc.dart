import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/kelas_remote_datasource.dart';
import 'package:mycic_app/data/models/pertemuan_kelas_response_model.dart';

part 'dsn_kelas_pertemuan_event.dart';
part 'dsn_kelas_pertemuan_state.dart';
part 'dsn_kelas_pertemuan_bloc.freezed.dart';

class DsnKelasPertemuanBloc
    extends Bloc<DsnKelasPertemuanEvent, DsnKelasPertemuanState> {
  DsnKelasPertemuanBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await KelasRemoteDatasource().getKelasPertemuanDsn(
        event.kelasId,
      );
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
