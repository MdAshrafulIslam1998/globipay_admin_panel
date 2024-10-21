enum NetworkStatus {
  success("S100000", "Success"),
  unAuthorized("EU401", "UnAuthorized"),
  ;

  const NetworkStatus(this.code, this.message);
  final String code, message;
}
