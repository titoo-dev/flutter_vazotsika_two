import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../routes/app_pages.dart';

import 'package:http/http.dart' as http;

import 'package:crypto/crypto.dart';

class AuthenticationController extends GetxController
    with SingleGetTickerProviderMixin {
  final GlobalKey<FormFieldState> formFieldKey = GlobalKey<FormFieldState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  RxBool busy = false.obs;

  RxBool isVisible = false.obs;

  RxBool isValide = false.obs;

  void validate(String value) {
    if (emailController.text.isNotEmpty &&
        emailController.text.isEmail &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length > 8) {
      isValide.value = true;
    } else {
      isValide.value = false;
    }
  }

  void signIn() async {
    showLoading();
    // final Hash hasher = md5;

    // final value = hasher.convert(data)

    // final secretKey = await algorithm.newSecretKey();

    // final password = passwordController.text.codeUnits;
    // // Encrypt
    // final secretBox = await algorithm.encrypt(password, secretKey: secretKey);

    // debugPrint("CypherText => ${secretBox.cipherText.join()}");

    // final http.Response res = await http
    //     .post(Uri.parse('http://192.168.43.72:3000/api/auth'), body: {
    //   "email": emailController.text,
    //   "password": secretBox.cipherText.join()
    // });
    // if (res.statusCode == 200) {
    // Get.back();
    // Future.delayed(const Duration(milliseconds: 700), () {
    //   logIn();
    // });
    // } else {
    //   Get.rawSnackbar(
    //       messageText: const Text("User not found",
    //           style: TextStyle(color: Colors.white)));
    // }
    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
      Future.delayed(const Duration(milliseconds: 700), () {
        logIn();
      });
    });
  }

  void showLoading() {
    Get.dialog(AlertDialog(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 14),
          Text("Authentication...")
        ],
      ),
    ));
  }

  void togglePasswordVisibility() {
    isVisible.value = !isVisible.value;
  }

  void unfocusAll() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  Future<bool>? requestPermission() async {
    if (await Permission.storage.request() != PermissionStatus.granted) {
      return false;
    }
    return true;
  }

  void logIn() {
    Get.offAndToNamed(Routes.home);
  }
}
