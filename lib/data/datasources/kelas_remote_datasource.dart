import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/variables.dart';
import 'package:mycic_app/data/datasources/auth_local_datasource.dart';
import 'package:mycic_app/data/models/detail_pertemuan_kelas_response_model.dart';
import 'package:mycic_app/data/models/dsn_tugas_response_model.dart';
import 'package:mycic_app/data/models/kelas_response_model.dart';
import 'package:mycic_app/data/models/kelas_today_response_model.dart';
import 'package:mycic_app/data/models/mhs_kelas_today_response_model.dart';
import 'package:mycic_app/data/models/mhs_tugas_response_model.dart';
import 'package:mycic_app/data/models/pertemuan_kelas_response_model.dart';

class KelasRemoteDatasource {
  final Dio _dio = Dio();

  Future<Either<String, KelasResponseModel>> getKelasMhs() async {
    const url = '${Variables.baseUrl}/mhs/kelas';
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

  Future<Either<String, PertemuanKelasResponseModel>> getKelasPertemuanMhs(
    int mkId,
  ) async {
    const url = '${Variables.baseUrl}/mhs/kelas/pertemuan';
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

  Future<Either<String, MhsKelasTodayResponseModel>> getKelasTodayMhs() async {
    const url = '${Variables.baseUrl}/mhs/kelas/today';
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
        return Right(MhsKelasTodayResponseModel.fromMap(response.data));
      } else {
        return const Left('Data tidak ditemukan!');
      }
    } catch (e) {
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

  Future<Either<String, DetailPertemuanKelasResponseModel>>
  getKelasPertemuanDetailMhs(int pertemuanId) async {
    const url = '${Variables.baseUrl}/mhs/kelas/pertemuan/detail';

    debugPrint('pertemuanId: $pertemuanId');
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'id': pertemuanId},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response pertemuan: $response');
      if (response.statusCode == 200) {
        return Right(DetailPertemuanKelasResponseModel.fromMap(response.data));
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

  Future<Either<String, MhsTugasResponseModel>> getTugasMhs() async {
    const url = '${Variables.baseUrl}/mhs/kelas/tugas';
    final authData = await AuthLocalDatasource().getAuthData();

    debugPrint('authData tugas: $url');
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'nim': authData?.user.userNumber},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response tugas: $response');

      if (response.statusCode == 200) {
        return Right(MhsTugasResponseModel.fromMap(response.data));
      } else {
        return const Left('Data tidak ditemukan!');
      }
    } catch (e) {
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

  Future<Either<String, String>> submitPresensi(String qrCode) async {
    const url = '${Variables.baseUrl}/mhs/presensi';
    final authData = await AuthLocalDatasource().getAuthData();

    debugPrint('authData tugas: $url');
    try {
      final response = await _dio.post(
        url,
        data: {'nim': authData?.user.userNumber, 'qr_code': qrCode},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response tugas: $response');

      if (response.statusCode == 201) {
        return Right(response.data['message']);
      } else {
        return const Left('Data tidak ditemukan!');
      }
    } catch (e) {
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

  // ---- ROLE DOSEN ---- //
  Future<Either<String, KelasResponseModel>> getKelasDsn() async {
    const url = '${Variables.baseUrl}/dsn/kelas';
    final authData = await AuthLocalDatasource().getAuthData();

    debugPrint('authData: ${authData?.user.userNumber}');
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'nidn': authData?.user.userNumber},
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

  Future<Either<String, KelasTodayResponseModel>> getKelasTodayDsn() async {
    const url = '${Variables.baseUrl}/dsn/kelas/today';
    final authData = await AuthLocalDatasource().getAuthData();

    debugPrint('authData: ${authData?.user.userNumber}');
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'nidn': authData?.user.userNumber},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response today doesn: ${response.statusCode}');
      if (response.statusCode == 200) {
        return Right(KelasTodayResponseModel.fromMap(response.data));
      } else {
        return const Left('Data tidak ditemukan!');
      }
    } catch (e) {
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

  Future<Either<String, DsnTugasResponseModel>> getTugasDsn() async {
    const url = '${Variables.baseUrl}/dsn';
    final authData = await AuthLocalDatasource().getAuthData();

    debugPrint('authData: ${authData?.user.userNumber}');
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'nidn': authData?.user.userNumber},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response today doesn: ${response.statusCode}');
      if (response.statusCode == 200) {
        return Right(DsnTugasResponseModel.fromMap(response.data));
      } else {
        return const Left('Data tidak ditemukan!');
      }
    } catch (e) {
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

  Future<Either<String, PertemuanKelasResponseModel>> getKelasPertemuanDsn(
    int mkId,
  ) async {
    const url = '${Variables.baseUrl}/dsn/kelas/pertemuan';
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'id_jadwal_kelas': mkId},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response pertemuan dosen: $response');
      if (response.statusCode == 200) {
        return Right(PertemuanKelasResponseModel.fromMap(response.data));
      } else {
        return const Left('Data tidak ditemukan!');
      }
    } catch (e) {
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

  Future<Either<String, DetailPertemuanKelasResponseModel>>
  getKelasPertemuanDetailDsn(int pertemuanId) async {
    const url = '${Variables.baseUrl}/mhs/kelas/pertemuan/detail';

    debugPrint('pertemuanId: $pertemuanId');
    try {
      final response = await _dio.get(
        url,
        queryParameters: {'id': pertemuanId},
        options: Options(headers: {'Accept': 'application/json'}),
      );

      debugPrint('response pertemuan: $response');
      if (response.statusCode == 200) {
        return Right(DetailPertemuanKelasResponseModel.fromMap(response.data));
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
}
