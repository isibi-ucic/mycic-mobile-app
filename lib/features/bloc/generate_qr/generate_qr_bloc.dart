import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/app_remote_datasource.dart';

part 'generate_qr_event.dart';
part 'generate_qr_state.dart';
part 'generate_qr_bloc.freezed.dart';

class GenerateQrBloc extends Bloc<GenerateQrEvent, GenerateQrState> {
  GenerateQrBloc() : super(_Initial()) {
    on<_GenerateQr>((event, emit) async {
      emit(const _Loading());

      // karena yang dipilih adalah waktu mulai kelas, dan db menerima waktu selesai presensi maka ditambahkan 4 jam
      // tambahkan 4 jam setelah date time
      final dateTime = event.dateTime.add(const Duration(hours: 4));

      final response = await AppRemoteDatasource().generateQr(
        event.peretmeuanId,
        dateTime,
      );
      response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
