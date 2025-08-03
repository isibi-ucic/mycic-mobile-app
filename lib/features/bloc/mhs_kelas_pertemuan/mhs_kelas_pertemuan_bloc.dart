import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mhs_kelas_pertemuan_event.dart';
part 'mhs_kelas_pertemuan_state.dart';
part 'mhs_kelas_pertemuan_bloc.freezed.dart';

class MhsKelasPertemuanBloc extends Bloc<MhsKelasPertemuanEvent, MhsKelasPertemuanState> {
  MhsKelasPertemuanBloc() : super(_Initial()) {
    on<MhsKelasPertemuanEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
