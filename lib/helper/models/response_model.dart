class ResponseModel {
  bool isSuccessful;
  String? message;
  dynamic data;

  ResponseModel({this.message, this.data, required this.isSuccessful});

}