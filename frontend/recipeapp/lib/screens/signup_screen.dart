import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3E3E3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'RecipeApp',
                        style: TextStyle(
                            fontFamily: 'FuzzyBubbles',
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      // SizedBox(
                      //   height: 50,
                      // ),
                      const Text(
                        'Let us meet you',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Material(
                        elevation: 5.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          decoration: InputDecoration(
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
                            labelText: 'First name',
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
                        child: TextField(
                          decoration: InputDecoration(
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
                            labelText: 'Last name',
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
                        child: TextField(
                          decoration: InputDecoration(
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
                        height: 10,
                      ),
                      Material(
                        elevation: 5.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
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
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'By using NameApp you agree to our Term of Service and Privacy Policy.',
                          style: TextStyle(color: Color(0xff505050)),
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
                            onPressed: () {},
                            child: !isLoading
                                ? const Text(
                                    'Continue',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                      const SizedBox(
                        height: 10,
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
                          'Do you already have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, '/loginScreen'),
                          child: const Text(
                            ' Login',
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
      ),
    );
  }
}
