import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopsmart_users/consts/validator.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:shopsmart_users/screens/loading%20manager.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';
import 'package:shopsmart_users/widgets/appnametextwidget.dart';
import 'package:shopsmart_users/widgets/auth/image_picker.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routName = "/Registerscreen";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _namecontroller,
      _emailcontroller,
      _passwordcontroller,
      _repeatpasswordcontroller;

  late final FocusNode _namefocusnode,
      _emailFocusNode,
      _passwordFocusNode,
      _repeatfocusnode;
  bool obscuretext = true;
  final _fromkey = GlobalKey<FormState>();
  XFile? _pickedImage;
  bool isloading = false;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    _namecontroller = TextEditingController();
    _repeatpasswordcontroller = TextEditingController();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _namefocusnode = FocusNode();
    _repeatfocusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (mounted) {
      _namecontroller.dispose();
      _namefocusnode.dispose();
      _repeatfocusnode.dispose();
      _repeatpasswordcontroller.dispose();
      _emailcontroller.dispose();
      _passwordcontroller.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _regFct() async {
    final isValid = _fromkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      try {
        setState(() {
          isloading = true;
        });
        await auth.createUserWithEmailAndPassword(
            email: _emailcontroller.text.trim(),
            password: _passwordcontroller.text.trim());
        Fluttertoast.showToast(
          msg: "Account created successfully",
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

  Future<void> localimagepicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
        context: context,
        cameraFunct: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        galleryFunct: () async {
          _pickedImage = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        removeFunct: () {
          setState(() {
            _pickedImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: isloading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                      label: "Welcome",
                      weight: FontWeight.bold,
                      size: 26,
                    ),
                  ),
                  SubtitleText(
                    label:
                        "Sign up now to recive special offers and updates from our app",
                    size: 14,
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                      height: size.height * 0.15,
                      width: size.width * 0.3,
                      child: Imagepicker(
                        pickedimage: _pickedImage,
                        function: () async {
                          localimagepicker();
                        },
                      )),
                  Form(
                    key: _fromkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _namecontroller,
                          focusNode: _namefocusnode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: "Full Name",
                              prefixIcon: Icon(Icons.person_outline)),
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                          validator: (value) {
                            return MyValidator.displayNamevalidator(value);
                          },
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
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscuretext,
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
                            FocusScope.of(context)
                                .requestFocus(_repeatfocusnode);
                          },
                          validator: (value) {
                            return MyValidator.passwordValidaor(value);
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _repeatpasswordcontroller,
                          focusNode: _repeatfocusnode,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscuretext,
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
                            _regFct();
                          },
                          validator: (value) {
                            return MyValidator.repeatPasswordvalidator(
                                value: value,
                                password: _passwordcontroller.text);
                          },
                        ),
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
                              _regFct();
                            },
                            label: Text(
                              "Sign up",
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(
                              IconlyLight.addUser,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SubtitleText(
                              label: "Do you have an account already?",
                              size: 14,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, LoginScreen.routName);
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        )
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
