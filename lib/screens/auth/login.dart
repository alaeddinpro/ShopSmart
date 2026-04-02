import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopsmart_users/consts/validator.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/forget_password.dart';
import 'package:shopsmart_users/screens/auth/register.dart';
import 'package:shopsmart_users/screens/loading%20manager.dart';
import 'package:shopsmart_users/widgets/appnametextwidget.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

import '../../services/my_app_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routName = "/LoginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailcontroller;
  late final TextEditingController _passwordcontroller;
  bool obscuretext = true;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _fromkey = GlobalKey<FormState>();
  bool isloading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (mounted) {
      _emailcontroller.dispose();
      _passwordcontroller.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _googleSignIn() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          final authResult =
              await auth.signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ));
        }
      }
      if (!mounted) {
        return;
      }
      Navigator.pushReplacementNamed(context, RootScreen.routName);
    } on FirebaseException catch (e) {
      MyAppFunctions.showErrorOrWarningDialog(
          context: context, title: e.message.toString(), fct: () {});
    } catch (e) {
      MyAppFunctions.showErrorOrWarningDialog(
          context: context, title: e.toString(), fct: () {});
    }
  }

  Future<void> _loginFct() async {
    final isValid = _fromkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      try {
        setState(() {
          isloading = true;
        });
        await auth.signInWithEmailAndPassword(
            email: _emailcontroller.text.trim(),
            password: _passwordcontroller.text.trim());
        Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        if (!mounted) {
          return;
        }
        Navigator.pushReplacementNamed(context, RootScreen.routName);
      } on FirebaseException catch (e) {
        MyAppFunctions.showErrorOrWarningDialog(
            context: context, title: e.message.toString(), fct: () {});
      } catch (e) {
        MyAppFunctions.showErrorOrWarningDialog(
            context: context, title: e.toString(), fct: () {});
      } finally {
        setState(() {
          isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: isloading,
          child: Form(
            key: _fromkey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    AppNameTextWidget(),
                    SizedBox(
                      height: 36,
                    ),
                    Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: SubtitleText(
                        label: "Welcome Back",
                        weight: FontWeight.bold,
                        size: 26,
                      ),
                    ),
                    SubtitleText(
                      label:
                          "Let's get you logged in so you can start exploring",
                      size: 14,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _emailcontroller,
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email address",
                          prefixIcon: Icon(IconlyLight.message)),
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      validator: (value) {
                        return MyValidator.emailValidator(value);
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordcontroller,
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(IconlyLight.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscuretext = !obscuretext;
                                });
                              },
                              icon: Icon(obscuretext
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      onFieldSubmitted: (value) {
                        _loginFct();
                      },
                      validator: (value) {
                        return MyValidator.passwordValidaor(value);
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                        alignment: AlignmentGeometry.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ForgetPassword.routName);
                            },
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline),
                            ))),
                    SizedBox(
                      height: 36,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          await _loginFct();
                        },
                        label: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          IconlyLight.logout,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    SubtitleText(
                      label: "Or Conncet using".toUpperCase(),
                      weight: FontWeight.w200,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            await _googleSignIn();
                          },
                          label: Text(
                            "Sign in with Google",
                            style: TextStyle(color: Colors.black),
                          ),
                          icon: Icon(
                            Ionicons.logo_google,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.pushNamed(context, RootScreen.routName);
                            },
                            child: Text(
                              "Guest?",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SubtitleText(
                          label: "Don't have an account?",
                          size: 14,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RegisterScreen.routName);
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
