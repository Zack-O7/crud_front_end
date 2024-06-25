import 'package:client/presentation/controllers/authCtrl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/app_pages.dart';
import '../themes/app_colors.dart';
import '../widgets/customTextField.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final authCtrl = Get.find<AuthCtrl>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  key: authCtrl.signUpFormKey,
                  child: Column(
                    children: [
                      Text(
                        "Register",
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
                        controller: authCtrl.fNameCtrl,
                        hintText: "First Name",
                        // validator: ,
                      ),
                      CustomTextField(
                        controller: authCtrl.lNameCtrl,
                        hintText: "Last Name",
                      ),
                      CustomTextField(
                        controller: authCtrl.emailCtrl,
                        hintText: "E-Mail ID",
                      ),
                      CustomTextField(
                        controller: authCtrl.pwdCtrl,
                        hintText: "Password",
                        passwordField: true,
                      ),
                      CustomTextField(
                        controller: authCtrl.cPwdCtrl,
                        hintText: "Confirm Password",
                        passwordField: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            authCtrl.signUp();
                          },
                          child: Text(
                            "Sign Up",
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
                              text: "Already a user? ",
                            ),
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Sign In");
                                  Get.toNamed(AppPages.signIn);
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
