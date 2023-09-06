import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipeapp/models/user_model.dart';
import 'package:recipeapp/services/api/user_api.dart';

class LoadingUserDataScreen extends StatefulWidget {
  const LoadingUserDataScreen({super.key});

  @override
  State<LoadingUserDataScreen> createState() => _LoadingUserDataScreenState();
}

class _LoadingUserDataScreenState extends State<LoadingUserDataScreen> {
  String textMessage = "Logging in";
  bool _isHere = true;

  void loadUser() async {
    UserModel? userModel = await UserApi.loadUser();
    if (userModel != null) {
      Navigator.pushNamedAndRemoveUntil(
          context,
          '/homeScreen',
          arguments: userModel,
          (Route<dynamic> route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    initialization();
  }

  @override
  void dispose() {
    _isHere = false;
    super.dispose();
  }

  void initialization() async {
    if (!_isHere) {
      return setState(() {
        textMessage = "Logging in   ";
      });
    }

    await Future.delayed(const Duration(seconds: 1));
    if (_isHere) {
      setState(() {
        textMessage = "Logging in.  ";
      });
    }
    await Future.delayed(const Duration(seconds: 1));
    if (_isHere) {
      setState(() {
        textMessage = "Logging in.. ";
      });
    }

    await Future.delayed(const Duration(seconds: 1));
    if (_isHere) {
      setState(() {
        textMessage = "Logging in...";
      });
    }

    await Future.delayed(const Duration(seconds: 1));
    if (_isHere) {
      initialization();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.threeRotatingDots(
                color: Colors.grey,
                size: 100,
              ),
              Text(
                textMessage,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
