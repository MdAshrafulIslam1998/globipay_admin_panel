/**
 * Created by Abdullah on 10/10/24.
 */

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/core/exception/app_exceptions.dart';
import 'package:globipay_admin_panel/core/network/exceptions/api_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/app_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/bad_request_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/conflict_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/network_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/not_found_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/timeout_exception.dart';
import 'package:globipay_admin_panel/core/network/exceptions/token_exception.dart';
import 'package:globipay_admin_panel/core/services/navigator/app_navigator_service.dart';
import 'package:globipay_admin_panel/core/services/storage/app_preferences_service.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/entity/request/file_upload/byte_file_upload_request.dart';
import 'package:globipay_admin_panel/entity/request/file_upload/file_upload_request.dart';
import '../network/exceptions/service_unavailable_exception.dart';
import '../network/exceptions/unauthorize_exception.dart';
import '../utils/custom_dialog.dart';
import 'base_page_state.dart';
class BaseController extends GetxController{

  final TokenRepository tokenRepository = Injector.resolve<TokenRepository>();
  String currentPath = "";
  @override
  void onClose() {
    _pageSateController.close();
    super.onClose();
  }

  //Controls page state
  final _pageSateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageSateController.value;
  updatePageState(PageState state) => _pageSateController(state);
  resetPageState() => _pageSateController(PageState.DEFAULT);
  showLoader() => updatePageState(PageState.LOADING);
  hideLoader() => resetPageState();

  // A method to automatically manage loading, success, and error states
  Future<T> execute<T>(
      Future<T>  asyncFunction,
      {Function(T response)? onSuccess,
        Function()? onError}) async {
    try {
      showLoader();  // Show loader before starting the operation

      T response = await callWithExceptionsHandler(
        asyncFunction,
        onError: (exception) {
          hideLoader();  // Hide loader if an error occurs
          if (onError != null) onError();
        },
        onSuccess: (response) {
          if (onSuccess != null) onSuccess(response);
        },
      );

      hideLoader();  // Hide loader after the operation is complete

      return response;  // Return the response
    } finally {
      hideLoader();  // Ensure loader is hidden if anything goes wrong
    }
  }


  dynamic callService<T>(
      Future<T> future, {
        Function(Exception exception)? onError,
        Function(T response)? onSuccess,
        Function? onStart,
        Function? onComplete,
        bool isShowLoader = true,
        bool willShowError = true,
        bool isShowToast = true,
      }) async {
    Exception? _exception;
    onStart?.call();

    if (isShowLoader) {
      showLoader();
    }

    try {
        final T response = await future;
        if (onSuccess != null) onSuccess(response);
        onComplete == null ? hideLoader() : onComplete();


        return response;

    } on TokenException catch (exception) {
      _exception = exception;
      if (isShowLoader) {
        hideLoader();
      }

      showCustomDialog(
        exception.message,
        title: "Session Expired",
        positiveButtonAction: () {
          // TODO : Navigate to login screen
        },
        positiveButtonText: "Login",
      );


      showErrorMessage(exception.message,
          isToast: isShowToast, willShowError: willShowError,

      );
    }on ServiceUnavailableException catch (exception) {
      _exception = exception;
      if (isShowLoader) {
        hideLoader();
      }

      showErrorMessage(exception.message,
          isToast: isShowToast, willShowError: willShowError);
    } on UnauthorizedException catch (exception) {
      if (isShowLoader) hideLoader();

      _exception = exception;
      // TODO : manage unauthorized exception

    } on TimeoutException catch (exception) {
      if (isShowLoader) {
        hideLoader();
      }
      _exception = exception;

      showErrorMessage(exception.message,
          isToast: isShowToast, willShowError: willShowError);
    } on BadRequestException catch (exception) {
      if (isShowLoader) {
        hideLoader();
      }
      _exception = exception;

      showErrorMessage(exception.message,
          isToast: isShowToast, willShowError: willShowError);
    } on NetworkException catch (exception) {
      if (isShowLoader) {
        hideLoader();
      }
      _exception = exception;

      showErrorMessage(exception.message,
          isToast: isShowToast, willShowError: willShowError);
    } on NotFoundException catch (exception) {
      if (isShowLoader) {
        hideLoader();
      }
      _exception = exception;

      showErrorMessage(exception.message,
          isToast: isShowToast, willShowError: willShowError);
    } on ConflictException catch (exception) {
      if (isShowLoader) {
        hideLoader();
      }
      _exception = exception;

      showErrorMessage(exception.message,
          isToast: isShowToast, willShowError: willShowError);
    } on ApiException catch (exception) {
      if (isShowLoader) {
        hideLoader();
      }
      _exception = exception;

      showErrorMessage(exception.message,
          isToast: isShowToast, willShowError: willShowError);
    } on AppException catch (exception) {
      if (isShowLoader) {
        hideLoader();
      }
      _exception = exception;
      showErrorMessage(exception.message,
          isToast: isShowToast, willShowError: willShowError);
    } catch (error) {
      if (isShowLoader) {
        hideLoader();
      }
      _exception = AppException(message: "$error");
      appPrint(error, tag: "Controller:CallService::");
    }

    if (onError != null) onError(_exception);

    if (onComplete != null) onComplete();
  }

  showErrorMessage(String message , {bool isToast = false , bool willShowError = true}){
    if(willShowError){
      appPrint(tag: 'BASE#CONTROLLER', message);
      if(isToast){
        showCustomDialog(message);
      }else{
        showCustomDialog(message);
      }
    }
  }


  Future<String> getLoggedInUserId() async{
    final id = await tokenRepository.getStuffId();
    return id ;
  }

  FileUploadRequest fileUploadRequest(String path, String fileName) =>
      FileUploadRequest(
        documents: path,
        fileName: fileName,
      );

  ByteFileUploadRequest byteFieUploadRequest(Uint8List bytes, String fileName) =>
      ByteFileUploadRequest(
        bytes: bytes,
        fileName: fileName,
      );


  showSnackBar({required String message, SnackBarStatus? status}) {
    ScaffoldMessenger.of(AppNavigatorService.navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: getColor(status ?? SnackBarStatus.INFO),
        ),
    );
  }

  getColor(SnackBarStatus status) {
    switch (status) {
      case SnackBarStatus.ERROR:
        return Colors.red[600];
      case SnackBarStatus.SUCCESS:
        return Colors.green[600];
      case SnackBarStatus.INFO:
        return Colors.blue[600];
    }
  }

  void askForConfirmation({String? message, required Function onPositiveAction}) {
    showCustomDialog(
      message ?? "Do you want to remove the item?",
      positiveButtonAction: (){
        onPositiveAction();
      },
      positiveButtonText: "Delete",
      negativeButtonText: "Cancel",
      negativeButtonAction: (){

      },
    );
  }

}

enum SnackBarStatus {
  ERROR,
  SUCCESS,
  INFO,
}