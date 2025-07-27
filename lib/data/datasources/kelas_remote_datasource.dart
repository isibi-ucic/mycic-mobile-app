import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/variables.dart';
import 'package:mycic_app/data/datasources/auth_local_datasource.dart';
import 'package:mycic_app/data/models/kelas_response_model.dart';
import 'package:mycic_app/data/models/kelas_today_response_model.dart';
import 'package:mycic_app/data/models/pertemuan_kelas_response_model.dart';

class KelasRemoteDatasource {
  final Dio _dio = Dio();

  Future<Either<String, KelasResponseModel>> getKelasMhs() async {
    final url = '${Variables.baseUrl}/mhs/kelas';
    final authData = await AuthLocalDatasource().getAuthData();

    debugPrint('authData: ${authData?.user.userNumber}');
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'nim': authData?.user.userNumber},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return Right(KelasResponseModel.fromMap(response.data));
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

  Future<Either<String, PertemuanKelasResponseModel>> getKelasPertemuanMhs(
    int mkId,
  ) async {
    final url = '${Variables.baseUrl}/mhs/kelas/pertemuan';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'id_jadwal_kelas': mkId},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return Right(PertemuanKelasResponseModel.fromMap(response.data));
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

  Future<Either<String, KelasTodayResponseModel>> getKelasTodayMhs(
    int mkId,
  ) async {
    final url = '${Variables.baseUrl}/mhs/kelas/today';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'id_jadwal_kelas': mkId},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return Right(KelasTodayResponseModel.fromMap(response.data));
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
