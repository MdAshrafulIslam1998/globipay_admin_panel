/// Created by Abdullah on 12/10/24.
library;


class BaseResponse {
  String? responseCode;
  String? responseMessage;
  dynamic data;

  BaseResponse({this.responseCode, this.responseMessage, this.data});
  BaseResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    data = json['data'];
  }
}