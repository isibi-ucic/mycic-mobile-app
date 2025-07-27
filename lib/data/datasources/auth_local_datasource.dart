import 'package:mycic_app/data/models/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  // save data auth
  Future<void> saveAuthData(AuthResponseModel data) async {
    // initialize
    final pref = await SharedPreferences.getInstance();

    await pref.setString('auth_data', data.toJson());
  }

  // ambil data auth, data nullable
  Future<AuthResponseModel?> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');

    if (data != null) {
      return AuthResponseModel.fromJson(data);
    } else {
      // wajib return null karena <AuthResponseModel?> nullable handling
      return null;
    }
  }

  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
  }

  Future<void> updateAuthData(AuthResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    final authData = await getAuthData();
    if (authData != null) {
      final updatedData = authData.copyWith(user: data.user);
      await pref.setString('auth_data', updatedData.toJson());
    }
  }

  Future<bool> isAuth() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    return data != null;
  }
}
