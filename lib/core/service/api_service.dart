import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/common.dart';
import '../core.dart';

class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
      String uri, String method, Map<String, dynamic>? params,
      {bool passHeader = false}) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == Method.postMethod) {
        if (passHeader) {
          response = await http.post(
            url,
            body: params,
            headers: {
              'Accept': 'application/json',
              'Authorization': token,
            },
          );
        } else {
          response = await http.post(
            url,
            body: params,
          );
        }
      } else if (method == Method.putMethod) {
        response = await http.put(
          url,
          body: params,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': token,
          },
        );
      } else if (method == Method.deleteMethod) {
        response = await http.delete(
          url,
          headers: {
            'Accept': 'application/json',
            'Authorization': token,
          },
        );
      } else {
        if (passHeader) {
          response = await http.get(url, headers: {
            'Accept': 'application/json',
            'Authorization': token,
          });
        } else {
          response = await http.get(url);
        }
      }

      if (kDebugMode) {
        print('====> url: ${uri.toString()}');
        print('====> method: $method');
        print('====> params: ${params.toString()}');
        print('====> status: ${response.statusCode}');
        print('====> body: ${response.body.toString()}');
        print('====> token: $token');
      }

      StatusModel model = StatusModel.fromJson(
        jsonDecode(
          response.body,
        ),
      );

      if (response.statusCode == 200) {
        try {
          if (!model.status!) {
            sharedPreferences.setBool(
                SharedPreferenceHelper.accessTokenKey, false);
            sharedPreferences.remove(SharedPreferenceHelper.token);
            Get.offAllNamed(RouteHelper.loginScreen);
          }
        } catch (e) {
          e.toString();
        }
        return ResponseModel(true, model.message!.tr, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(false, model.message!.tr, response.body);
      } else if (response.statusCode == 404) {
        return ResponseModel(false, model.message!.tr, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(
            false, model.message?.tr ?? LocalStrings.serverError.tr, '');
      } else {
        return ResponseModel(
            false, model.message?.tr ?? LocalStrings.somethingWentWrong.tr, '');
      }
    } on SocketException {
      return ResponseModel(false, LocalStrings.somethingWentWrong, '');
    } on FormatException {
      sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
      Get.offAllNamed(RouteHelper.loginScreen);
      return ResponseModel(false, LocalStrings.badResponseMsg.tr, '');
    } catch (e) {
      return ResponseModel(false, e.toString(), '');
    }
  }

  String token = '';
  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t =
          sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      token = t ?? '';
    } else {
      token = '';
    }
  }
}
