import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:newtask/core/exception/api_exception.dart';
import 'package:newtask/core/network/api_response.dart';
import 'package:newtask/core/network/request_body.dart';
import 'package:newtask/core/util/cache_manager.dart';

class ApiManager {
  static final Dio _dio = Dio();
  static const bool _isTestMode = true;

  static void init() {
    // Set default configs
    _dio.options.baseUrl = ApiManager.getBaseUrl();
    _dio.options.connectTimeout = const Duration(milliseconds: 30000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 30000);
    _dio.options.responseType = ResponseType.plain;
    _dio.options.followRedirects = false;
    if (_isTestMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          requestBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false));
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) {
          return handler.next(e);
        },
      ),
    );
  }

  static Future<ApiResponse?> sendRequest(
      {required String link,
      RequestBody? body,
      Map<String, dynamic>? queryParams,
      FormData? formData,
      Method method = Method.POST}) async {
    Map<String, dynamic> headers = {};
    if (UserPreference.isContainUserToken()) {
      headers.putIfAbsent("usertoken", () => UserPreference.getUserToken());
    }

    // headers.putIfAbsent("Accept", () => "application/json");

    try {
      Response? response;
      if (method == Method.POST) {
        response = await _dio.post(link,
            data: formData ?? body?.getBody(),
            queryParameters: queryParams,
            options: Options(headers: headers));
      } else if (method == Method.PUT) {
        response = await _dio.put(link,
            data: formData ?? body?.getBody(),
            queryParameters: queryParams,
            options: Options(headers: headers));
      } else if (method == Method.GET) {
        response = await _dio.get(link,
            queryParameters: queryParams, options: Options(headers: headers));
      } else if (method == Method.DELETE) {
        response = await _dio.delete(link,
            data: body,
            queryParameters: queryParams,
            options: Options(headers: headers));
      } else if (method == Method.PATCH) {
        response = await _dio.patch(link,
            data: formData ?? body?.getBody(),
            queryParameters: queryParams,
            options: Options(headers: headers));
      }

      return ApiResponse(
          response!.statusCode, jsonDecode(response.data.toString()), "");
    } on DioError catch (e) {
      if (e.response != null && e.response?.statusCode == 401) {
        throw ApiException(
            e.response!.statusCode!, getErrorMsg(e.response?.data));
      } else if (e.response != null &&
          (e.response?.statusCode == 400 ||
              e.response?.statusCode == 404 ||
              e.response?.statusCode == 422)) {
        throw ApiException(
            e.response!.statusCode!, getErrorMsg(e.response?.data));
      } else {
        // cannot reach server , server may be down or no internet connection.
        throw ApiException(-1, "Error in server");
      }
    }
  }

  static String getBaseUrl() {
    if (_isTestMode) {
      return 'https://engaztechnology.net/Himam/User/';
    } else {
      return 'https://engaztechnology.net/Himam/User/';
    }
  }

  static String buildFileUrl(String filePatUrl) {
    return getBaseUrl() + filePatUrl;
  }

  static getErrorMsg(dynamic data) {
    if (data == null || data == "") {
      return "Error in server";
    }
    var error = "";
    final map = jsonDecode(data);
    map.keys.forEach((key) {
      if (key == "errors") {
        final errors = map['errors'] as Map<String, dynamic>;
        for (var errKey in errors.keys) {
          var exceptions = errors[errKey] as List<dynamic>;
          error += "${exceptions[0]}\n";
        }
      }
    });
    if (error == "") {
      if (map["message"] != null) {
        error = map["message"];
      }
    }
    return error;
  }
}

enum Method { POST, PUT, GET, DELETE, PATCH }
