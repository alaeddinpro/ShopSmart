import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_users/consts/validator.dart';
import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/widgets/appnametextwidget.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});
  static const String routName = "ForgetPassword";
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController _emailController;
  late final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _forgetPassword() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppNameTextWidget(),
      ),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
              child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  physics: BouncingScrollPhysics(),
                  children: [
                Image.asset(AssetsManager.forgetpasswordimage),
                SubtitleText(
                  label: "Forget Password",
                  size: 24,
                  weight: FontWeight.w500,
                ),
                SubtitleText(
                  label: "Enter your email address to reset your password",
                  size: 16,
                  weight: FontWeight.w400,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 36,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email address",
                            prefixIcon: Icon(IconlyLight.message)),
                        validator: (value) {
                          return MyValidator.emailValidator(value);
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
                            await _forgetPassword();
                          },
                          label: Text(
                            "Request link",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          icon: Icon(
                            IconlyLight.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }
}
