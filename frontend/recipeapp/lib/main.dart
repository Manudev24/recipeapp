import 'package:cookingenial/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pull_down_button/pull_down_button.dart';

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
      title: 'Cookingenial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffFFC674),
        ),
        useMaterial3: true,
        extensions: [
          PullDownButtonTheme(
            routeTheme: PullDownMenuRouteTheme(
              backgroundColor: Colors.grey,
            ),
            itemTheme: PullDownMenuItemTheme(
              destructiveColor: Colors.red,
            ),
            dividerTheme: PullDownMenuDividerTheme(
              dividerColor: Colors.black,
            ),
          ),
        ],
      ),
      routes: Routes.routes,
    );
  }
}
