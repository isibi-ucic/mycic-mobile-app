import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/variables.dart';
import 'package:mycic_app/data/datasources/auth_local_datasource.dart';
import 'package:mycic_app/data/models/detail_pertemuan_kelas_response_model.dart';
import 'package:mycic_app/data/models/dsn_skripsi_response_model.dart';
import 'package:mycic_app/data/models/presensi_kelas_response_model.dart';
import 'package:mycic_app/data/models/presensi_rekap_response_model.dart';

class DsnRemoteDatasource {
  final Dio _dio = Dio();

  Future<Either<String, PresensiKelasResponseModel>> getInfoKelas() async {
    const url = '${Variables.baseUrl}/dsn/info-kelas';

    final authData = await AuthLocalDatasource().getAuthData();
    try {
      final response = await _dio.get(
        url,
        queryParameters: {"nidn": authData?.user.userNumber},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return Right(PresensiKelasResponseModel.fromMap(response.data));
      } else {
        return const Left('Data tidak ditemukan!');
      }
    } catch (e) {
      debugPrint('error: $e');
      if (e is DioException) {
        if (e.response != null) {
          final errorResponse = e.response!.data;
          if (errorResponse != null && errorResponse['message'] != null) {
            return Left(errorResponse['message']);
          }
        }
      }
      return const Left('Network error'); // or a more specific error message
    }
  }

  Future<Either<String, PresensiRekapResponseModel>> getRekapPresensi(
    int kelasId,
  ) async {
    const url = '${Variables.baseUrl}/dsn/kelas/rekap-presensi';

    try {
      final response = await _dio.get(
        url,
        queryParameters: {"id_jadwal_kelas": kelasId},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return Right(PresensiRekapResponseModel.fromMap(response.data));
      } else {
        return const Left('Data tidak ditemukan!');
      }
    } catch (e) {
      debugPrint('error: $e');
      if (e is DioException) {
        if (e.response != null) {
          final errorResponse = e.response!.data;
          if (errorResponse != null && errorResponse['message'] != null) {
            return Left(errorResponse['message']);
          }
        }
      }
      return const Left('Network error'); // or a more specific error message
    }
  }

  Future<Either<String, DsnSkripsiResponseModel>> getSkripsi() async {
    final String url;
    final userData = await AuthLocalDatasource().getAuthData();
    url = '${Variables.baseUrl}/dsn/skripsi';

    try {
      final response = await _dio.get(
        url,
        queryParameters: {'nidn': userData?.user.userNumber},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response skripsi: $response');
      if (response.statusCode == 200) {
        return Right(DsnSkripsiResponseModel.fromMap(response.data));
      } else {
        return const Left('Data skripsi tidak ditemukan!');
      }
    } catch (e) {
      if (e is DioException) {
        debugPrint('Underlying error: ${e.error}');

        if (e.response != null) {
          final errorResponse = e.response!.data;
          if (errorResponse != null && errorResponse['message'] != null) {
            return Left(errorResponse['message']);
          }
        }
      }
      return const Left('Network error'); // or a more specific error message
    }
  }
}
