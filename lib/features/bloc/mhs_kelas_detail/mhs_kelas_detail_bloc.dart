import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/kelas_remote_datasource.dart';
import 'package:mycic_app/data/models/pertemuan_kelas_response_model.dart';

part 'mhs_kelas_detail_event.dart';
part 'mhs_kelas_detail_state.dart';
part 'mhs_kelas_detail_bloc.freezed.dart';

class MhsKelasDetailBloc
    extends Bloc<MhsKelasDetailEvent, MhsKelasDetailState> {
  MhsKelasDetailBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await KelasRemoteDatasource().getKelasPertemuanMhs(
        event.idMk,
      );
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
