import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Text(
                    'Welcome to RecipeApp',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Image(image: AssetImage('assets/images/GetStartedIcon.png')),
                  Text(
                    'Start You Cooking Journey With Us',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Save recipes, create shopping lists, and share your own creations with the community.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff737373),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(
                  //   height: 40,
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Material(
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/loginScreen'),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
