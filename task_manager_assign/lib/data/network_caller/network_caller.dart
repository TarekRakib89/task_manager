import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_assign/app.dart';
import 'package:task_manager_assign/data/network_caller/network_response.dart';
import 'package:task_manager_assign/ui/controllers/auth_controllers.dart';
import 'package:task_manager_assign/ui/screens/LoginScreen.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      debugPrint("Url does not exist$url");

      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'Application/json',
        'token': AuthController.token.toString(),
      });

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          backToLogin();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  // Future<NetworkResponse> postRequest(String url,
  //     {Map<String, dynamic>? body, bool isLogin = false}) async {
  //   try {
  //     debugPrint(AuthController.token.toString());
  //     debugPrint("Url does not exist");
  //     final Response response = await post(
  //       Uri.parse("print $url"),
  //       body: jsonEncode(body),
  //       headers: {
  //         'Content-type': 'Application/json',
  //         'token': AuthController.token.toString(),
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       return NetworkResponse(
  //         isSuccess: true,
  //         jsonResponse: jsonDecode(response.body),
  //         statusCode: 200,
  //       );
  //     } else if (response.statusCode == 401) {
  //       if (isLogin == false) {
  //         backToLogin();
  //       }
  //       return NetworkResponse(
  //         isSuccess: false,
  //         statusCode: response.statusCode,
  //         jsonResponse: jsonDecode(response.body),
  //       );
  //     } else {
  //       return NetworkResponse(
  //         isSuccess: false,
  //         statusCode: response.statusCode,
  //         jsonResponse: jsonDecode(response.body),
  //       );
  //     }
  //   } catch (e) {
  //     return NetworkResponse(
  //       isSuccess: false,
  //       errorMessage: e.toString(),
  //     );
  //   }
  // }

  Future<NetworkResponse> getRequest(String url) async {
    try {
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'Content-type': 'Application/json',
          'token': AuthController.token.toString(),
        },
      );
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        backToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      } else {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> getEmailVerification(String url) async {
    try {
      debugPrint(url);
      final Response response = await get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        backToLogin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      } else {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequestForRecoverVerifyOTP(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      debugPrint(url);
      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-type': 'Application/json',
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        debugPrint("yes password Changes");
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          backToLogin();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> getRequestForRecoverVerifyOTP(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      debugPrint(url);
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'Content-type': 'Application/json',
        },
      );
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          backToLogin();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> backToLogin() async {
    await AuthController.clearAuthData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
