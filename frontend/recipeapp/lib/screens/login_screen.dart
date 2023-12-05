import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cookingenial/models/user_model.dart';
import 'package:cookingenial/services/api/user_api.dart';
import 'package:cookingenial/services/auth/secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  UserModel? userModel;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Access denied'),
        content: const Text('Incorrect user name or password'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3E3E3),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Cookingenial',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Material(
                            elevation: 5.0,
                            shadowColor: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please, enter a user name.';
                                } else if (value.length < 4) {
                                  return 'Please, enter a valid user name.';
                                }
                                return null;
                              },
                              controller: userNameController,
                              maxLength: 10,
                              decoration: InputDecoration(
                                counterText: '',
                                prefixIcon: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                    'assets/icons/userIcon.svg',
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'User name',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 5.0,
                            shadowColor: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please, enter a password.';
                                }
                                return null;
                              },
                              maxLength: 30,
                              decoration: InputDecoration(
                                counterText: '',
                                prefixIcon: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                    'assets/icons/padlockIcon.svg',
                                  ),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Forgot your password?',
                          style: TextStyle(color: Color(0xff505050)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Material(
                      elevation: 5.0,
                      shadowColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 50,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xffFFBB5C),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true; //
                              });

                              String? token = await UserApi.loginUser(
                                userNameController.text,
                                passwordController.text,
                              );

                              if (token != null) {
                                await SecureStorage.secureStorage
                                    .write(key: "token", value: token);
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/loadingUserDataScreen',
                                    (Route<dynamic> route) => false);
                              } else {
                                _showAlertDialog(context);
                              }

                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: !isLoading
                              ? const Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LoadingAnimationWidget.threeRotatingDots(
                                      color: const Color(0xff4F4F4F),
                                      size: 25,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      'Loading',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff4F4F4F),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30,
                    top: 10,
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      const Text(
                        'You do not have an account yet?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, '/signupScreen'),
                        child: const Text(
                          ' Sign Up',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
