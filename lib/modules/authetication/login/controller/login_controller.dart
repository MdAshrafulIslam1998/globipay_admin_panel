import 'package:flutter/cupertino.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/request/login/login_request.dart';
import 'package:globipay_admin_panel/entity/response/login/login_response.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:globipay_admin_panel/router/route_path.dart';

/**
 * Created by Abdullah on 8/12/24.
 */
class LoginController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AppRepository appRepository;
  TokenRepository tokenRepository;

  LoginController(this.appRepository, this.tokenRepository);

  // Validation state
  final rememberMe = RxBool(false);

  LoginRequest loginRequest ()=> LoginRequest(
        email: emailController.text,
        password: passwordController.text,
      );

  // Handle the Remember Me checkbox
  void toggleRememberMe(bool value) {
    rememberMe.value = value;
  }

  parseLoginResponse(LoginResponse data) async{
    final token = data.token;
    await tokenRepository.saveToken(token ?? "");
    await tokenRepository.saveRole(data.role.toString());
    await tokenRepository.saveStuffId(data.stuff_id ?? "");
    AppRoutes.pushAndReplaceNamed(RoutePath.dashboard);
  }

  void login() {
    if (formKey.currentState!.validate()) {
      requestForLogin();
    }
  }


  void requestForLogin(){
    final request = loginRequest();
    final repo = appRepository.requestForLogin(request);
    callService(repo, onSuccess: (data){
      parseLoginResponse(data);
    });
  }


}
