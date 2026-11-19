import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static const _validUser = 'Daniel'; 
  static const _validPass = '044';

  final RxnString username = RxnString();

  Future<bool> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('sessionUser');
    return username.value != null;
  }

  Future<bool> login(String user, String pass) async {
    if (user != _validUser || pass != _validPass) return false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessionUser', user);
    username.value = user;
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionUser');
    username.value = null;
  }
}