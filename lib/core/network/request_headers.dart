import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/core/utils/storage/app_storage.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';

import '../constants/storage_keys.dart';
import '../data/local/repository/token_repository.dart';

/// Created by Abdullah on 12/10/24.

class RequestHeaderInterceptor extends InterceptorsWrapper {
  var isAuthenticationHeaderRequired = false;
  final String? customContentType;

  final TokenRepository _tokenRepository =
  Injector.resolve<TokenRepository>();

  RequestHeaderInterceptor(this.isAuthenticationHeaderRequired,
      {this.customContentType});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    var userType = "";
    if (kIsWeb) {
      userType = "Web";
    } else if (Platform.isAndroid) {
      userType = "Android";
    } else if (Platform.isIOS) {
      userType = "iOS";
    }

    var customHeaders = {
      'user-agent': userType,
      'Content-Type': customContentType ?? 'application/json',
      "Country-Code": "countryCode",
      "Accept-Language": "en",
      'User-Type': '1'
    };

    if (isAuthenticationHeaderRequired) {
      try {
        final token = await _tokenRepository.getToken();
        customHeaders["Authorization"] = "Bearer $token";
      } catch (e) {
        appPrint(e);
      }
    }

    return customHeaders;
  }
}