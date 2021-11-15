import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.unfocusAll,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/lf30_editor_h0o5ula8.json',
                  width: 200,
                  height: 200,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 180),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    minWidth: 180,
                    shape: const StadiumBorder(
                        side: BorderSide(color: Colors.black12, width: 1)),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/image/Flat-design-Google-logo-design-Vector-PNG.png'),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        const Text("Login with google"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: controller.validate,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: controller.emailFocusNode,
                          controller: controller.emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 0.7),
                                  borderRadius: BorderRadius.circular(100)),
                              hintText: 'Email',
                              prefixIcon:
                                  const Icon(Icons.alternate_email_outlined)),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        GetX<AuthenticationController>(builder: (state) {
                          return TextFormField(
                            onChanged: controller.validate,
                            controller: controller.passwordController,
                            obscureText: !state.isVisible.value,
                            focusNode: controller.passwordFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                hintText: 'password'.capitalize,
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: GestureDetector(
                                    onTap: state.togglePasswordVisibility,
                                    child: state.isVisible.value
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility))),
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        GetX<AuthenticationController>(builder: (state) {
                          return MaterialButton(
                              minWidth: 200,
                              shape: const StadiumBorder(),
                              disabledColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              color: Theme.of(context).primaryColor,
                              onPressed: state.isValide.value
                                  ? controller.signIn
                                  : null,
                              child: const Text("Sing In"));
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
