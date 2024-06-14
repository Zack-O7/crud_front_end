import 'package:client/domain/usecases/signUpUseCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/response_classify.dart';
import '../../data/remote/models/request/signUpReqModel.dart';
import '../../data/remote/models/response/signUpResModel.dart';
import '../routes/app_pages.dart';

class AuthCtrl extends GetxController {
  final SignUpUseCase signUpUseCase;

  AuthCtrl(this.signUpUseCase);

  ///SignUp
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();
  TextEditingController cPwdCtrl = TextEditingController();

  final GlobalKey signUpFormKey = GlobalKey<FormState>();

  ///SignUp API
  final signUpList = <SignUpData>[].obs;
  final signUpLoading = false.obs;

  final signUpState = ResponseClassify<SignUpResModel>.error("").obs;

  signUp() async {
    signUpState.value = ResponseClassify.loading();
    try {
      signUpLoading.value = true;
      signUpState.value = ResponseClassify.completed(
        await signUpUseCase.call(
          SignUpReqModel(
            firstName: fNameCtrl.text,
            lastName: lNameCtrl.text,
            email: emailCtrl.text,
            password: cPwdCtrl.text,
          ),
        ),
      );
      print("SignUp API Completed");
      signUpList.clear();
      signUpList.addAll(signUpState.value.data!.data);
      signUpLoading.value = false;
      Get.offAllNamed(AppPages.signIn);
      fNameCtrl.clear();
      lNameCtrl.clear();
      emailCtrl.clear();
      pwdCtrl.clear();
      cPwdCtrl.clear();
    } catch (e) {
      // bottomMsg("Failed", "$e", false);
      signUpState.value = ResponseClassify.error("$e");
    }
  }

  ///SignIn
  // TextEditingController emailCtrl = TextEditingController();
  // TextEditingController pwdCtrl = TextEditingController();
}
