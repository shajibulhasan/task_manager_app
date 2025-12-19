import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiCaller {

  static Logger logger = Logger();

  static Future<ApiResponse> getResponse({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      logRequest(url);
      Response response = await get(uri);
      logResponse(url, response);
      final int statusCode = response.statusCode;
      final decodedBody = jsonDecode(response.body);

      if (statusCode == 200) {
        return ApiResponse(
          statusCode: statusCode,
          body: decodedBody,
          isSuccess: true,
        );
      } else {
        return ApiResponse(
          statusCode: statusCode,
          body: decodedBody,
          isSuccess: false,
        );
      }
    } catch (e) {
      return ApiResponse(
        statusCode: -1,
        body: '',
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<ApiResponse> postResponse({required String url, Map<String,dynamic>?body}) async {
    try {
      logRequest(url, body: body);
      Uri uri = Uri.parse(url);
      Response response = await post(uri,
          headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
          },
          body: body != null ? jsonEncode(body) : null
      );
      logResponse(url, response);
      final int statusCode = response.statusCode;
      final decodedBody = jsonDecode(response.body);

      if (statusCode == 200 || statusCode == 201) {
        return ApiResponse(
          statusCode: statusCode,
          body: decodedBody,
          isSuccess: true,
        );
      } else {
        return ApiResponse(
          statusCode: statusCode,
          body: decodedBody,
          isSuccess: false,
        );
      }
    } catch (e) {
      return ApiResponse(
        statusCode: -1,
        body: '',
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
  static void logRequest(String url, {Map<String,dynamic>? body}) {
    logger.i('API Request: $url');
    if (body != null) {
      logger.i('Request Body: ${jsonEncode(body)}');
    }
  }

  static void logResponse(String url , Response response) {
    logger.i('API Response Status Code: ${response.statusCode}');
    logger.i('API Response Body: ${response.body}');

  }

}

class ApiResponse {
  final int statusCode;
  final String body;
  final bool isSuccess;
  final String? errorMessage;

  ApiResponse(
    {
          this.errorMessage = 'Something went wrong',
          required this.statusCode,
          required this.body,
          required this.isSuccess,
    }
      );
    }
