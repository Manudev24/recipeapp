import 'package:cookingenial/check_auth_status.dart';
import 'package:cookingenial/screens/categories_screen.dart';
import 'package:cookingenial/screens/chief_screen.dart';
import 'package:cookingenial/screens/daily_recipes_screen.dart';
import 'package:cookingenial/screens/get_started_screen.dart';
import 'package:cookingenial/screens/home_screen.dart';
import 'package:cookingenial/screens/loading_user_data_screen.dart';
import 'package:cookingenial/screens/login_screen.dart';
import 'package:cookingenial/screens/recipe_screen.dart';
import 'package:cookingenial/screens/search_recipe_screen.dart';
import 'package:cookingenial/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (BuildContext context) => const CheckAuthStatus(),
    '/getStartedScreen': (BuildContext context) => const GetStartedScreen(),
    '/signupScreen': (BuildContext context) => const SignUpScreen(),
    '/loginScreen': (BuildContext context) => const LoginScreen(),
    '/loadingUserDataScreen': (BuildContext context) =>
        const LoadingUserDataScreen(),
    '/homeScreen': (BuildContext context) => const HomeScreen(),
    '/recipeScreen': (BuildContext context) => const RecipeScreen(),
    '/chiefScreen': (BuildContext context) => const ChiefScreen(),
    '/searchRecipeScreen': (BuildContext context) => const SearchRecipeScreen(),
    '/categoriesScreen': (BuildContext context) => const CategoriesScreen(),
    '/dailyRecipesScreen': (BuildContext context) => const DailyRecipesScreen(),
  };
}
