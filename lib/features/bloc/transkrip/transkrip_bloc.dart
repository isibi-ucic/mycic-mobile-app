import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/mhs_remote_datasource.dart';
import 'package:mycic_app/data/models/transkrip_response_model.dart';

part 'transkrip_event.dart';
part 'transkrip_state.dart';
part 'transkrip_bloc.freezed.dart';

class TranskripBloc extends Bloc<TranskripEvent, TranskripState> {
  TranskripBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await MhsRemoteDatasource().getTranskrip();
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
