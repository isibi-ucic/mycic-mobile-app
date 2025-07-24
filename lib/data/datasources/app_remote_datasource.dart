import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constants/variables.dart';
import 'package:myapp/data/models/info_response_model.dart';

class AppRemoteDatasource {
  final Dio _dio = Dio();

  Future<Either<String, InfoResponseModel>> getInfo() async {
    final url = '${Variables.baseUrl}/info';

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return Right(InfoResponseModel.fromMap(response.data));
      } else {
        return const Left('Data tidak ditemukan!');
      }
    } catch (e) {
      if (e is DioException) {
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
}
