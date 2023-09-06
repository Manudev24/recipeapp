import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:recipeapp/services/auth/auth_service.dart';

class CheckAuthStatus extends StatefulWidget {
  const CheckAuthStatus({super.key});

  @override
  State<CheckAuthStatus> createState() => _CheckAuthStatusState();
}

class _CheckAuthStatusState extends State<CheckAuthStatus> {
  void checkIsLogged() async {
    if (await AuthService.isLogged() == true) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/loadingUserDataScreen', (Route<dynamic> route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/getStartedScreen', (Route<dynamic> route) => false);
    }
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    checkIsLogged();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
