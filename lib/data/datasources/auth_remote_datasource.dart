import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:myapp/core/constants/variables.dart";
import "package:myapp/data/datasources/auth_local_datasource.dart";
import "package:myapp/data/models/auth_response_model.dart";

class AuthRemoteDataSource {
  final Dio _dio = Dio();

  Future<Either<String, AuthResponseModel>> login(
    String nim,
    String password,
  ) async {
    final url = '${Variables.baseUrl}/auth';

    try {
      final response = await _dio.post(
        url,
        data: {'identifier': nim, 'password': password},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return Right(AuthResponseModel.fromMap(response.data));
      } else {
        return const Left('Credential not valid!');
      }
    } catch (e) {
      if (e is DioException) {
        // Log or print exception details for debugging
        print('DioException: ${e.message}');
        print('DioException type: ${e.type}');
        if (e.response != null) {
          print('Response status code: ${e.response!.statusCode}');
          print('Response data: ${e.response!.data}');
        }
        print('Underlying error: ${e.error}');

        if (e.response != null) {
          final errorResponse = e.response!.data;
          if (errorResponse != null && errorResponse['message'] != null) {
            return Left(errorResponse['message']);
          }
        }
      }
      return Left('Network error'); // or a more specific error message
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = '${Variables.baseUrl}/logout';

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            // Uncomment jika API perlu token
            // 'Authorization': 'Bearer ${authData?.token}',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right('Berhasil keluar!');
      } else {
        final message = response.data['message'] ?? 'Unknown error';
        return Left('Gagal keluar: $message');
      }
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? 'Network error';
      print('Logout error: $message');
      return Left('Gagal keluar: $message');
    } catch (e) {
      print('Logout exception: $e');
      return const Left('Gagal keluar: Network error');
    }
  }
}
