import 'package:flutter/material.dart';
import 'package:recipeapp/check_auth_status.dart';
import 'package:recipeapp/screens/get_started_screen.dart';
import 'package:recipeapp/screens/home_screen.dart';
import 'package:recipeapp/screens/loading_user_data_screen.dart';
import 'package:recipeapp/screens/login_screen.dart';
import 'package:recipeapp/screens/signup_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (BuildContext context) => const CheckAuthStatus(),
    '/getStartedScreen': (BuildContext context) => const GetStartedScreen(),
    '/signupScreen': (BuildContext context) => const SignUpScreen(),
    '/loginScreen': (BuildContext context) => const LoginScreen(),
    '/loadingUserDataScreen': (BuildContext context) =>
        const LoadingUserDataScreen(),
    '/homeScreen': (BuildContext context) => const HomeScreen(),
  };
}
