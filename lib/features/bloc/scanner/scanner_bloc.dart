import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';
part 'scanner_bloc.freezed.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(_Initial()) {
    on<ScannerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
