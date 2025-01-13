import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:globipay_admin_panel/core/network/request_headers.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:universal_io/io.dart';

import '../../flavors/flavor_config.dart';
import '../constants/app_constant.dart';

/// Created by Abdullah on 12/10/24.

class DioProvider {
  static final String baseUrl = FlavorConfig.instance.url;

  static Dio? _instance;
  DioProvider();

  static const int _maxLineWidth = 120;
  static final _prettyDioLogger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      logPrint: (lg) {
        appPrint(lg.toString());
      },
      maxWidth: _maxLineWidth);

  static final BaseOptions _options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: AppConstants.conectionTimeOut),
      receiveTimeout: const Duration(seconds: AppConstants.conectionTimeOut));

  static Dio get httpDio {
    if (_instance == null) {
      _instance = Dio(_options);
      _instance!.interceptors.add(_prettyDioLogger);

      return _instance!;
    } else {
      _instance!.interceptors.clear();
      _instance!.interceptors.add(_prettyDioLogger);

      return _instance!;
    }
  }

  ///returns a Dio client with Access token in header
  static Dio get tokenClient {
    _addInterceptors();
    return _instance!;
  }

  ///returns a Dio client with Access token in header
  ///Also adds a token refresh interceptor which retry the request when it's unauthorized
  static Dio get dioWithHeaderToken {
    _addInterceptors();
    return _instance!;
  }

  static Dio get dioWithHeaderAuthenticationToken {
    _addInterceptors(
      isAuthenticationHeaderRequired: true,
    );
    return _instance!;
  }

  static Dio get dioMultipartWithHeaderAuthenticationToken {
    _addInterceptors(
        isAuthenticationHeaderRequired: true,
        customContentType: "multipart/form-data");
    return _instance!;
  }

  static Dio get dioMultipartWithoutHeaderAuthenticationToken {
    _addInterceptors(
        isAuthenticationHeaderRequired: false,
        customContentType: "multipart/form-data");
    return _instance!;
  }

  static _addInterceptors(
      {isAuthenticationHeaderRequired = false, customContentType}) {
    _instance ??= httpDio;
    _instance!.interceptors.clear();
    _instance!.interceptors.add(RequestHeaderInterceptor(
        isAuthenticationHeaderRequired,
        customContentType: customContentType));
    _instance!.interceptors.add(_prettyDioLogger);
  }

  static String _buildContentType(String version) {
    return "user_defined_content_type+$version";
  }

  DioProvider.setContentType(String version) {
    _instance?.options.contentType = _buildContentType(version);
  }

  DioProvider.setContentTypeApplicationJson() {
    _instance?.options.contentType = "application/json";
  }
}