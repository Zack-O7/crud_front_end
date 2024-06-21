import 'package:client/presentation/controllers/authCtrl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/app_pages.dart';
import '../themes/app_colors.dart';
import '../widgets/customTextField.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  final authCtrl = Get.find<AuthCtrl>();

  final TextEditingController emailId = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: width * 0.6,
              // height: height * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.cardLightGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: authCtrl.signInFormKey,
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.exo(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          // fontSize: width <= 1050 ? 12 : 14,
                          // fontSize: width * 0.02,
                          fontSize: width > 1050
                              ? width * 0.018
                              : width >= 900
                                  ? width * 0.02
                                  : 20,
                        ),
                      ),
                      CustomTextField(
                        controller: authCtrl.emailCtrl,
                        hintText: "EMail ID",
                        // validator: ,
                      ),
                      CustomTextField(
                        controller: authCtrl.pwdCtrl,
                        hintText: "Password",
                        passwordField: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            authCtrl.signIn();
                          },
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.orbitron(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              // fontSize: width <= 1050 ? 12 : 14,
                              // fontSize: width * 0.02,
                              fontSize: width > 1050
                                  ? width * 0.015
                                  : width >= 900
                                      ? width * 0.018
                                      : 14,
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "New User? ",
                            ),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Sign Up");
                                  Get.toNamed(AppPages.signUp);
                                },
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
        ],
      ),
    );
  }
}
