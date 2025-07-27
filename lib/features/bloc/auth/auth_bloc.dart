import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycic_app/data/datasources/auth_local_datasource.dart';
import 'package:mycic_app/data/datasources/auth_remote_datasource.dart';
import 'package:mycic_app/data/models/auth_response_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());

      final result = await AuthRemoteDataSource().login(
        event.nim,
        event.password,
      );
      result.fold((l) => emit(_Error(l)), (r) {
        // simpan data login ke local source
        AuthLocalDatasource().saveAuthData(r);
        emit(_Success(r));
      });
    });
  }
}
