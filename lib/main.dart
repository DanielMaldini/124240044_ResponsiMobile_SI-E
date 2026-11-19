import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'controllers/favorite_controller.dart';
import 'pages/list_page.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = Get.put(AuthController(), permanent: true);
  Get.put(FavoriteController(), permanent: true);
  final loggedIn = await auth.restoreSession();
  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;
  const MyApp({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resep Masakan',
      theme: ThemeData(colorSchemeSeed: Colors.pinkAccent, useMaterial3: true),
      home: loggedIn ? const ListPage() : const LoginPage(),
    );
  }
}