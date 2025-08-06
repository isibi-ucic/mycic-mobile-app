import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/variables.dart';
import 'package:mycic_app/data/datasources/auth_local_datasource.dart';
import 'package:mycic_app/data/models/info_response_model.dart';
import 'package:mycic_app/data/models/mhs_skripsi_response_model.dart';

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

  Future<Either<String, MhsSkripsiResponseModel>> getSkripsi() async {
    final String url;
    final Map<String, int?> queryData;
    final userData = await AuthLocalDatasource().getAuthData();

    if (userData?.user.role == 'dsn') {
      url = '${Variables.baseUrl}/dsn/skripsi';
      queryData = {'nidn': userData?.user.userNumber};
    } else {
      url = '${Variables.baseUrl}/mhs/skripsi';
      queryData = {'nim': userData?.user.userNumber};
    }

    try {
      final response = await _dio.get(
        url,
        queryParameters: queryData,
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return Right(MhsSkripsiResponseModel.fromMap(response.data));
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

  Future<Either<String, String>> generateQr(
    int pertemuanId,
    DateTime batas_waktu,
  ) async {
    final url = '${Variables.baseUrl}/dsn/kelas/pertemuan';

    String qrCodeValue =
        md5.convert(utf8.encode("ID-${pertemuanId.toString()}")).toString();

    try {
      final response = await _dio.put(
        url,
        data: {
          'id': pertemuanId,
          "qr_code": qrCodeValue,
          'batas_waktu': batas_waktu.toIso8601String(),
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response: $response');
      if (response.statusCode == 200) {
        return const Right("QR Code berhasil dibuat");
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
