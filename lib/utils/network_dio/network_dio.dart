import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/utils/app_constants.dart';
import 'package:ecommerce_app/utils/snackbar.dart';
import 'package:flutter/material.dart';

class NetworkDioHttp {
  late Dio _dio;

  NetworkDioHttp() {
    init();
  }

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiAppConstants.apiEndPoint,
        followRedirects: false,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
    initializeInterceptors();
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.next(options);
      },
      onResponse: (e, handler) {
        handler.next(e);
      },
      onError: (e, handler) async {
        log("${e.response?.statusCode}", name: 'STATUS_CODE');
        logger.e("ERROR_DATA : ${e.response?.data}");
        switch (e.response?.statusCode) {
          case 400: //Bad Request
            debugPrint("0=========> ${e.response?.data.toString() ?? "Something Went Wrong"}");
            CustomSnackBar.showGetXSnackBar(toastType: ToastType.error, message: e.response?.data["message"].toString() ?? "Something Went Wrong");
            break;
          case 401: //UnAuthorized User
            debugPrint("1=========> ${e.response?.data.toString() ?? "Something Went Wrong"}");
            CustomSnackBar.showGetXSnackBar(toastType: ToastType.error, message: e.response?.data["message"].toString() ?? "Something Went Wrong");
            break;
          case 403: //Bad Request
            debugPrint("2=========> ${e.response?.data.toString() ?? "Something Went Wrong"}");
            CustomSnackBar.showGetXSnackBar(toastType: ToastType.error, message: e.response?.data["message"].toString() ?? "Something Went Wrong");
            break;
          case 404: //Not Found
            debugPrint("3=========> ${e.response?.data.toString() ?? "Something Went Wrong"}");
            CustomSnackBar.showGetXSnackBar(toastType: ToastType.error, message: e.response?.data["message"].toString() ?? "Something Went Wrong");
            break;
          case 500: //Internal Server Error
            debugPrint("4=========> ${e.response?.data.toString() ?? "Something Went Wrong"}");
            CustomSnackBar.showGetXSnackBar(toastType: ToastType.error, message: e.response?.data["message"].toString() ?? "Something Went Wrong");
            break;
          case 501: //Internal Server Error
            debugPrint("5=========> ${e.response?.data.toString() ?? "Something Went Wrong"}");
            CustomSnackBar.showGetXSnackBar(toastType: ToastType.error, message: e.response?.data["message"].toString() ?? "Something Went Wrong");
            break;

          default:
            debugPrint("6=========> ${"Something Went Wrong"}");
            CustomSnackBar.showGetXSnackBar(toastType: ToastType.error, message: "Something Went Wrong");
            break;
        }
        handler.next(e);
      },
    ));
  }

  Future<Response> postRequest({required String url, required bool isHeader, required bool isBody, Object? bodyData, name}) async {
    Response response;
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      _dio.options.headers['Accept'] = 'application/json';
      // if (isHeader == true) _dio.options.headers['authorization'] = dataStorage.read(AppStrings.token);

      log(url, name: '${name}_REQUEST_URL');
      logger.t("${name}_REQUEST_BODY :${json.encode(bodyData)}");

      response = isBody == true ? await _dio.post(url, data: bodyData) : await _dio.post(url);

      logger.i(json.decode(response.toString()));
      // log("${response.data}", name: '${name}_RESPONSE_DATA');

      return response;
    } on DioException catch (exception) {
      return exception.response!.data;
    }
  }

  Future<Response> getRequest({required String url, required bool isHeader, name}) async {
    Response response;
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      _dio.options.headers['Accept'] = 'application/json';
      // if (isHeader == true) _dio.options.headers['authorization'] = dataStorage.read(AppStrings.token);

      log(url, name: '${name}_REQUEST_URL');

      response = await _dio.get(url);

      // logger.i(json.decode(response.toString()));
      // log("${response.data}", name: '${name}_RESPONSE_DATA');

      return response;
    } on DioException catch (exception) {
      return exception.response!;
    }
  }

  Future<Response> putRequest({required String url, required bool isHeader, Object? bodyData, name}) async {
    Response response;
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      _dio.options.headers['Accept'] = 'application/json';
      // if (isHeader == true) _dio.options.headers['authorization'] = dataStorage.read(AppStrings.token);

      log(url, name: '${name}_REQUEST_URL');
      logger.t("${name}_REQUEST_BODY :${json.encode(bodyData)}");

      response = await _dio.put(url, data: bodyData);

      logger.i(json.decode(response.toString()));

      return response;
    } on DioException catch (exception) {
      return exception.response!;
    }
  }

  Future<Response> deleteRequest({required String url, required bool isHeader, name}) async {
    Response response;
    try {
      _dio.options.headers['Content-Type'] = 'application/json';
      _dio.options.headers['Accept'] = 'application/json';
      // if (isHeader == true) _dio.options.headers['authorization'] = dataStorage.read(AppStrings.token);

      log(url, name: '${name}_REQUEST_URL');

      response = await _dio.delete(url);

      logger.i(json.decode(response.toString()));
      // log("${response.data}", name: '${name}_RESPONSE_DATA');

      return response;
    } on DioException catch (exception) {
      return exception.response!;
    }
  }
}
