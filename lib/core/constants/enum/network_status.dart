enum NetworkStatus {
  success("S100000", "Success"),
  unAuthorized("E10004", "UnAuthorized"),
  ;

  const NetworkStatus(this.code, this.message);
  final String code, message;
}
