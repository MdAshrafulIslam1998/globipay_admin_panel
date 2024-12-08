import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_view_state.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_field.dart';
import 'package:globipay_admin_panel/core/widgets/text_filed/input_regex.dart';
import 'package:globipay_admin_panel/modules/authetication/login/controller/login_controller.dart';
/**
 * Created by Abdullah on 8/12/24.
 */

class LoginScreenBuilder extends StatefulWidget {
  const LoginScreenBuilder({super.key});

  @override
  State<LoginScreenBuilder> createState() => _LoginScreenBuilderState();
}

class _LoginScreenBuilderState
    extends BaseViewState<LoginScreenBuilder, LoginController> {
  @override
  Widget body(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // App Logo or Welcome Text
                    Text(
                      'Admin Panel',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    InputField(
                      controller: controller.emailController,
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      regex: InputRegex.EMAIL,
                    ),
                    const SizedBox(height: 20),


                    // Password Field
                    InputField(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      regex: InputRegex.NOT_EMPTY,
                    ),

                    const SizedBox(height: 20),

                    // Remember Me Checkbox
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) {
                              controller.toggleRememberMe(value ?? false);
                            },
                          ),
                          const Text('Remember Me'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          controller.login();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
