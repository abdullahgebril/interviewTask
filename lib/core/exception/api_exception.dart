class ApiException implements Exception{
  int statusCode;
  String error;
  ApiException(this.statusCode , this.error);
}