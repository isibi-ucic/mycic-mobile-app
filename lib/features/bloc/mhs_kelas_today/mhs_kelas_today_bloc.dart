import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/kelas_remote_datasource.dart';
import 'package:mycic_app/data/datasources/mhs_remote_datasource.dart';
import 'package:mycic_app/data/models/mhs_kelas_today_response_model.dart';

part 'mhs_kelas_today_event.dart';
part 'mhs_kelas_today_state.dart';
part 'mhs_kelas_today_bloc.freezed.dart';

class MhsKelasTodayBloc extends Bloc<MhsKelasTodayEvent, MhsKelasTodayState> {
  MhsKelasTodayBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await KelasRemoteDatasource().getKelasTodayMhs();
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
