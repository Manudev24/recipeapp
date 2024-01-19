import 'package:cookingenial/services/api/user_api.dart';
import 'package:cookingenial/services/auth/secure_storage.dart';
import 'package:cookingenial/widgets/modal_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoginFormVisible = false;

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Widget adaptiveAction(
      {required BuildContext context,
      required VoidCallback onPressed,
      required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Center(
                  child: Text(
                    'Cookingenial',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/female_chef-pana.svg',
                // height: 200,
                // width: 200,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    final inAnimation = Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: const Offset(0.0, 0.0))
                        .animate(animation);
                    return ClipRect(
                      child: SlideTransition(
                        position: inAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: _isLoginFormVisible
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Bienvenido de nuevo!',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    child: TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor introduzca su correo electrónico';
                                        }
                                        // else if (!RegExp(
                                        //         r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        //     .hasMatch(value)) {
                                        //   return 'Por favor introduzca una dirección de correo electrónico válida';
                                        // }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(CupertinoIcons.mail),
                                        hintText: 'Correo electrónico',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor, introduzca su contraseña';
                                        } else if (value.length < 6) {
                                          return 'La contraseña debe contener 6 caracteres como mínimo';
                                        }
                                        return null;
                                      },
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(CupertinoIcons.padlock),
                                        hintText: 'Contraseña',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      //show Alertdialog of a loading animation and cant be dismissed
                                      if (_formKey.currentState != null &&
                                          _formKey.currentState!.validate()) {
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return ModalLoadingWidget();
                                          },
                                        );

                                        String? token = await UserApi.loginUser(
                                          emailController.text,
                                          passwordController.text,
                                        );

                                        if (token != null) {
                                          await SecureStorage.secureStorage
                                              .write(
                                                  key: "token", value: token);
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/loadingUserDataScreen',
                                              (Route<dynamic> route) => false);
                                        } else {
                                          Navigator.pop(context, 'Aceptar');
                                          showAdaptiveDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog.adaptive(
                                              title:
                                                  const Text('Acceso denegado'),
                                              content: const Text(
                                                  'Email o contraseña incorrecta.'),
                                              actions: <Widget>[
                                                adaptiveAction(
                                                  context: context,
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Aceptar'),
                                                  child: const Text('Aceptar'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    //Size equal to textfields
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Iniciar sesión',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/signupScreen');
                                  },
                                  child: const Text(
                                    '¿No tienes una cuenta? Regístrate',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome to',
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff353535),
                                    height: 0.9),
                              ),
                              const Text(
                                'Cookingenial',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffFF9B50),
                                  height: 1,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Guarde recetas, cree listas de compras y comparta sus propias creaciones con la comunidad.',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff737373),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLoginFormVisible =
                                              !_isLoginFormVisible;
                                        });
                                      },
                                      child: const Text('Iniciar sesión'),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/signupScreen');
                                      },
                                      child: const Text('Registrarse'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//
//

//
// void _showAlertDialog(BuildContext context) {
//   showCupertinoModalPopup<void>(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: const Text('Access denied'),
//       content: const Text('Incorrect user name or password'),
//       actions: <CupertinoDialogAction>[
//         CupertinoDialogAction(
//           isDestructiveAction: true,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Ok'),
//         ),
//       ],
//     ),
//   );
// }
