import 'package:client/domain/usecases/signUpUseCase.dart';
import 'package:client/presentation/widgets/snackBarMsg.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/response_classify.dart';
import '../../data/remote/models/request/signInReqModel.dart';
import '../../data/remote/models/request/signUpReqModel.dart';
import '../../data/remote/models/response/signInResModel.dart';
import '../../data/remote/models/response/signUpResModel.dart';
import '../../domain/usecases/signInUseCase.dart';
import '../routes/app_pages.dart';

class AuthCtrl extends GetxController {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;

  AuthCtrl(this.signUpUseCase, this.signInUseCase);

  ///SignUp
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();
  TextEditingController cPwdCtrl = TextEditingController();

  final GlobalKey signUpFormKey = GlobalKey<FormState>();
  final GlobalKey signInFormKey = GlobalKey<FormState>();

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
      snackBarMsg("${signUpState.value.data!.data[0].statusMessage}",
          "${signUpState.value.data!.data[0].fullName}", true);
      signUpLoading.value = false;
      // Get.offAllNamed(AppPages.signIn);
      Get.offAllNamed(AppPages.dashboard);
      fNameCtrl.clear();
      lNameCtrl.clear();
      emailCtrl.clear();
      pwdCtrl.clear();
      cPwdCtrl.clear();
    } catch (e) {
      snackBarMsg("Failed", "$e", false);
      signUpState.value = ResponseClassify.error("$e");
    }
  }

  ///Direct HTTP API Call
  // Future<void> signUp() async {
  //   var headers = {'Content-Type': 'application/json'};
  //   prettyPrint("starting http");
  //
  //   var request = http.Request(
  //     'POST',
  //     Uri.parse('https://crud-server-ed5h.onrender.com/api/users/signup'),
  //   );
  //
  //   request.body = json.encode({
  //     "firstName": fNameCtrl.text,
  //     "lastName": lNameCtrl.text,
  //     "email": emailCtrl.text,
  //     "password": cPwdCtrl.text
  //   });
  //
  //   request.headers.addAll(headers);
  //
  //   try {
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       var responseBody = await response.stream.bytesToString();
  //       prettyPrint(responseBody);
  //     } else {
  //       prettyPrint('Error: ${response.reasonPhrase}');
  //     }
  //   } on SocketException catch (e) {
  //     prettyPrint('Network error: $e');
  //   } on HttpException catch (e) {
  //     prettyPrint('HTTP error: $e');
  //   } on FormatException catch (e) {
  //     prettyPrint('Format error: $e');
  //   } catch (e) {
  //     prettyPrint('Unexpected error: $e');
  //   }
  // }

  ///SignIn
  // TextEditingController emailCtrl = TextEditingController();
  // TextEditingController pwdCtrl = TextEditingController();

  final signInList = <SignInResData>[];
  final signInLoading = false.obs;

  final signInState = ResponseClassify<SignInResModel>.error("").obs;

  signIn() async {
    signInState.value = ResponseClassify.loading();
    try {
      signInLoading.value = true;
      signInState.value = ResponseClassify.completed(
        await signInUseCase.call(
          SignInReqModel(
            email: emailCtrl.text,
            password: pwdCtrl.text,
          ),
        ),
      );
      print("SignIn API Completed");
      signInList.clear();

      signInList.addAll(signInState.value.data!.data);
      snackBarMsg("Login Status",
          "${signInState.value.data!.data[0].statusMessage}", true);
      signInLoading.value = false;
      Get.offAllNamed(AppPages.dashboard);
      emailCtrl.clear();
      pwdCtrl.clear();
    } catch (e) {
      print("Failed $e");
      snackBarMsg("Failed", "$e", false);
      signInState.value = ResponseClassify.error("$e");
    }
  }
}
