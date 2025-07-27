import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/models/nilai_response_model.dart';
import 'package:mycic_app/data/models/transkrip_response_model.dart';

part 'mhs_nilai_event.dart';
part 'mhs_nilai_state.dart';
part 'mhs_nilai_bloc.freezed.dart';

class MhsNilaiBloc extends Bloc<MhsNilaiEvent, MhsNilaiState> {
  MhsNilaiBloc() : super(MhsNilaiState()) {
    on<MhsNilaiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
