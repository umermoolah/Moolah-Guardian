import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moolah/helper/models/response_model.dart';
import 'package:moolah/helper/sharedHelper.dart';

class Network {
  static Future<ResponseModel> get(String url) async {
    // print("REQ BODY: $body");
    try {
      print("HEADERS: ${getHeaders()}");
      var res = await http.get(Uri.parse(url), headers: getHeaders());
      print("RES STATUS: ${res.statusCode}");
      return responseHandler(res: res);
    } catch (e) {
      print("e:::$e");
      return responseHandler(empty: true);
    }
  }

  static Future<ResponseModel> post(String url,
      {Map<String, dynamic> body = const {}}) async {
    try {
      print("REQ BODY: $body");
      print("HEADERS: ${getHeaders()}");
      var res =
          await http.post(Uri.parse(url), body: body, headers: getHeaders());
      return responseHandler(res: res);
    } catch (e) {
      print("e:::$e");
      return responseHandler(empty: true);
    }
  }

  static Map<String, String>? getHeaders() {
    Map<String, String> header = {
      "X-API-VERSION":"0.0.0.1"
    };
    if (Prefs.accessToken.get().isNotEmpty) {
      header.addAll({"Authorization": "Bearer ${Prefs.accessToken.get()}"});
    }

    return header;
  }

  static Future<ResponseModel> responseHandler(
      {http.Response? res, bool empty = false}) async {
    print("responceHandler: ${res!.body}");
    print("responceHandler:Status Code: ${res!.statusCode}");
    if (((res?.statusCode ?? 0) == 200 || (res?.statusCode ?? 0) == 201) && !empty) {
      if (jsonDecode(res!.body)["status"] ?? true) {
        return ResponseModel(
            isSuccessful: true,
            data: jsonDecode(res.body),
            message: jsonDecode(res!.body)["message"]);
      } else {
        return ResponseModel(
            isSuccessful: false,
            data: jsonDecode(res.body),
            message: jsonDecode(res!.body)["message"]);
      }
    }
    print("HELLO ${res.statusCode}");
    return ResponseModel(isSuccessful: false, message: jsonDecode(res.body)["message"], data: jsonDecode(res.body));
  }
}
