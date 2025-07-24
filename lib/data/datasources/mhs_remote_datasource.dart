import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/constants/variables.dart';
import 'package:myapp/data/datasources/auth_local_datasource.dart';
import 'package:myapp/data/models/presensi_response_model.dart';
import 'package:myapp/data/models/transkrip_response_model.dart';

class MhsRemoteDatasource {
  final Dio _dio = Dio();
  final authData = AuthLocalDatasource();
  Future<Either<String, PresensiResponseModel>> getPresensi() async {
    final url = '${Variables.baseUrl}/mhs/presensi';
    final mhsData = await authData.getAuthData();

    try {
      final response = await _dio.get(
        url,
        queryParameters: {'nim': mhsData?.user.userNumber},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return Right(PresensiResponseModel.fromMap(response.data));
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

  Future<Either<String, TranskripResponseModel>> getTranskrip() async {
    final url = '${Variables.baseUrl}/mhs/transkrip';
    final mhsData = await authData.getAuthData();

    try {
      final response = await _dio.get(
        url,
        queryParameters: {'nim': mhsData?.user.userNumber},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return Right(TranskripResponseModel.fromMap(response.data));
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
