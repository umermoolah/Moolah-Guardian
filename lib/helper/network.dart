import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moolah/helper/models/response_model.dart';
import 'package:moolah/helper/sharedHelper.dart';

class Network {
  static const String _logHeader = "═══════════════════════════════════════════";

  static Future<ResponseModel> get(String url) async {
    final timestamp = DateTime.now().toString();
    print("\n$_logHeader");
    print("🔵 GET REQUEST - $timestamp");
    print("📍 URL: $url");
    print("📋 Headers: ${getHeaders()}");
    print("$_logHeader");

    try {
      final startTime = DateTime.now();
      var res = await http.get(Uri.parse(url), headers: getHeaders());
      final duration = DateTime.now().difference(startTime);

      print("\n✅ GET RESPONSE (${duration.inMilliseconds}ms)");
      print("🔢 Status Code: ${res.statusCode}");
      print("📦 Response Body:\n${_formatJson(res.body)}");
      print("$_logHeader\n");

      return responseHandler(res: res);
    } catch (e) {
      print("\n❌ GET ERROR: $e");
      print("$_logHeader\n");
      return responseHandler(empty: true);
    }
  }

  static Future<ResponseModel> post(String url,
      {Map<String, dynamic> body = const {}, bool encode = false}) async {
    final timestamp = DateTime.now().toString();
    print("\n$_logHeader");
    print("🔴 POST REQUEST - $timestamp");
    print("📍 URL: $url");
    print("📋 Headers: ${getHeaders()}");
    print("📤 Request Body:\n${_formatJson(jsonEncode(body))}");
    print("$_logHeader");

    try {
      final startTime = DateTime.now();
      var res = await http.post(Uri.parse(url),
        body: jsonEncode(body),
        headers: getHeaders()
      );
      final duration = DateTime.now().difference(startTime);

      print("\n✅ POST RESPONSE (${duration.inMilliseconds}ms)");
      print("🔢 Status Code: ${res.statusCode}");
      print("📥 Response Body:\n${_formatJson(res.body)}");
      print("$_logHeader\n");

      return responseHandler(res: res);
    } catch (e) {
      print("\n❌ POST ERROR: $e");
      print("$_logHeader\n");
      return responseHandler(empty: true);
    }
  }

  static String _formatJson(String jsonString) {
    try {
      final jsonObject = jsonDecode(jsonString);
      return JsonEncoder.withIndent('  ').convert(jsonObject);
    } catch (e) {
      return jsonString;
    }
  }

  static Map<String, String>? getHeaders() {
    Map<String, String> header = {
      "X-API-VERSION":"0.0.0.1",
      "Content-type": "application/json; charset=utf-8"
    };
    if (Prefs.accessToken.get().isNotEmpty) {
      header.addAll({"Authorization": "Bearer ${Prefs.accessToken.get()}"});
    }
    return header;
  }

  static Future<ResponseModel> responseHandler(
      {http.Response? res, bool empty = false}) async {
    print("\n🔍 RESPONSE HANDLER");
    print("📊 Status Code: ${res?.statusCode}");
    print("📄 Body:\n${_formatJson(res?.body ?? 'null')}");

    if (((res?.statusCode ?? 0) == 200 || (res?.statusCode ?? 0) == 201) && !empty) {
      try {
        final responseData = jsonDecode(res!.body);
        final isSuccessful = responseData["status"] ?? true;
        final message = responseData["message"] ?? "";

        print("✅ Response Status: ${isSuccessful ? 'SUCCESS' : 'FAILED'}");
        print("💬 Message: $message");
        print("$_logHeader\n");

        return ResponseModel(
            isSuccessful: isSuccessful,
            data: responseData,
            message: message);
      } catch (e) {
        print("❌ JSON Parse Error: $e");
        print("$_logHeader\n");
        return ResponseModel(isSuccessful: false, message: "Parse Error: $e", data: null);
      }
    }

    print("❌ Error Status: ${res?.statusCode}");
    try {
      final errorData = res?.body != null ? jsonDecode(res!.body) : null;
      final errorMessage = errorData?["message"] ?? res?.body ?? "Unknown error";
      print("💬 Error Message: $errorMessage");
      print("$_logHeader\n");
      return ResponseModel(isSuccessful: false, message: errorMessage, data: errorData);
    } catch (e) {
      print("❌ Error Parse: $e");
      print("$_logHeader\n");
      return ResponseModel(isSuccessful: false, message: res?.body ?? "Error", data: null);
    }
  }
}
