import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/mhs_remote_datasource.dart';
import 'package:mycic_app/data/models/khs_response_model.dart';

part 'khs_event.dart';
part 'khs_state.dart';
part 'khs_bloc.freezed.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  KhsBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await MhsRemoteDatasource().getKhs();

      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
