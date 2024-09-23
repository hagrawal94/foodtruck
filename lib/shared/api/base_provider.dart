import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:departuretimes/shared/helper/di.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_x;
import 'package:http/http.dart';

class BaseHttpProvider {
  FirebaseRemoteConfig remoteConfig = get_x.Get.find();
  late String host;

  BaseHttpProvider._();
  static final _instance = BaseHttpProvider._();
  factory BaseHttpProvider() {
    // get the host from the remote config based on the build mode
    _instance.host =
        _instance.remoteConfig.getString('${DependencyInject.buildMode}_host');
    // for local testing
    // _instance.host = "e4a2-103-13-43-136.ngrok-free.app";
    return _instance;
  }

  Future<Response> getRequest(String endPoint,
      {Map<String, dynamic> newHeaders = const {},
      Map<String, dynamic>? queryParameters = const {}}) async {
    try {
      final url = Uri.https(host, endPoint, queryParameters);
      log(url.toString());

      final headers = await _createHeaders(newHeaders);

      final response = await get(url, headers: {...headers, ...newHeaders});

      _handleResponse(response);

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> postRequest(String endPoint, Map body,
      {Map<String, dynamic> newHeaders = const {},
      Map<String, dynamic>? queryParameters}) async {
    try {
      final url = Uri.https(host, endPoint, queryParameters);
      log(url.toString());
      final headers = await _createHeaders(newHeaders);
      Map data = {};
      body.forEach((key, value) {
        data.addIf(value != null, key, value);
      });
      debugPrint(body.toString());

      final response = await post(url, body: json.encode(data), headers: {
        ...headers,
        ...newHeaders,
      });

      _handleResponse(response);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> deleteRequest(String endPoint,
      {Map body = const {},
      Map<String, dynamic> newHeaders = const {},
      Map<String, dynamic>? queryParameters}) async {
    try {
      final url = Uri.https(host, endPoint, queryParameters);
      log(url.toString());
      final headers = await _createHeaders(newHeaders);
      Map data = {};
      body.forEach((key, value) {
        data.addIf(value != null, key, value);
      });
      debugPrint(body.toString());

      final response = await delete(url, body: json.encode(data), headers: {
        ...headers,
        ...newHeaders,
      });

      _handleResponse(response);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> putRequest(String endPoint, Map body,
      {Map<String, dynamic> newHeaders = const {},
      Map<String, dynamic>? queryParameters}) async {
    try {
      final url = Uri.https(host, endPoint, queryParameters);
      log(url.toString());
      final headers = await _createHeaders(newHeaders);
      Map data = {};
      body.forEach((key, value) {
        data.addIf(value != null, key, value);
      });
      debugPrint(body.toString());

      final response = await put(url, body: json.encode(data), headers: {
        ...headers,
        ...newHeaders,
      });

      _handleResponse(response);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, String>> _createHeaders(
      Map<String, dynamic> newHeaders) async {
    // create the headers, can be used to add auth tokens and other headers
    return {'content-type': 'application/json'};
  }

  void _handleResponse(Response response) {
    // handle the response, can be used to trigger events based on the status code
    debugPrint('Status code: ${response.statusCode}');
    debugPrint('Body: ${response.body}');
    if (response.statusCode >= 400) {
      final errorMessage = jsonDecode(response.body)['message'];
      throw Exception(errorMessage);
    }
  }
}
