import 'package:flutter/material.dart';
import 'package:recipeapp/check_auth_status.dart';
import 'package:recipeapp/services/auth/auth_service.dart';
import 'package:recipeapp/utils/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xffFFBB5C),
        ),
        useMaterial3: true,
      ),
      routes: Routes.routes,
      initialRoute: '/',
    );
  }
}
