import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fastlink_reminder/links.dart';

class AuthServices {
  final dio = Dio();
  dynamic errorMessage = "";
  AuthServices() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) {
          // Check for the 422 status code
          if (e.response?.statusCode == 422) {
            // Handle the 422 error specifically
            print('Error 422: ${e.response?.data}');
            errorMessage = e.response?.data['message'];
            // Optionally, you can do more specific handling here
          }
          // Handle other errors
          return handler.next(e); // continue
        },
      ),
    );
  }

  /// Logs in a user using the provided email, password, and FCM token.
  ///
  /// Parameters:
  /// - [email]: The user's email.
  /// - [password]: The user's password.
  /// - [fcmToken]: The user's FCM token.
  ///
  /// Returns:
  /// A [Future] that completes with the decoded JSON response from the server.
  Future<Map<String, dynamic>> loginUser(
      {required String email,
      required String password,
      required String fcmToken}) async {
    final response = await dio.post(
      loginApi,
      data: {'email': email, 'password': password, 'fcm_token': fcmToken},
      options: Options(headers: {'Accept': 'application/json'}),
    );
    log(' response data =============>   ${response.data}');
    return response.data;
  }

  /// Checks the validity of the given token by sending a request to the server and parsing the response.
  ///
  /// [token] The token to check.
  ///
  /// Returns [Future] that completes with the decoded JSON response from the server.
  Future checkTokenExpiered({required String token}) async {
    try {
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };
      final response =
          await dio.get(checktokenApi, options: Options(headers: headers));
      log('check token response data ================>${response.data}');
      return response.data;
    } catch (e) {
      log('error in check token expiered =========>${e.toString()}');
    }
    return null;
  }

  /// Sends an email to the specified recipient using the register API endpoint.
  ///
  /// Parameters:
  /// - [recipientEmail]: The email address of the recipient.
  /// - [recipientName]: The name of the recipient.
  ///
  /// Returns:
  /// A [Future] that completes with the decoded JSON response from the server.
  Future<Map<String, dynamic>> sendEmail(
      {required String recipientEmail, required String recipientName}) async {
    log('send email ...............................');

    log(registerApi);
    final Map<String, String> body = {
      'name': recipientName,
      'email': recipientEmail,
    };
    final Response response;
    try {
      response = await dio.post(
          'https://d-reminder-api.net-performance.online/api/register',
          data: body,
          options: Options(
            headers: {'Accept': 'application/json'},
          ));
    } catch (e) {
      print('catch error');
      return {'message': errorMessage};
    }
    log('response for send email method =====>>>>>${response.data}');

    // Return the decoded JSON response from the server.
    return response.data;
  }

  /// Logs out a user by sending a POST request to the logout API endpoint
  /// with the provided token.
  ///
  /// Parameters:
  /// - [authToken]: The user's authentication token.
  ///
  /// Returns:
  /// A [Future] that completes with the decoded JSON response from the server.
  Future<Map<String, dynamic>> logOut(String authToken) async {
    final headers = {
      'Authorization': 'Bearer $authToken',
      'Accept': 'application/json',
    };

    final response = await dio.post(
      logOutApi,
      options: Options(headers: headers),
    );
    log('response for log out method ============>>>> $response');
    return response.data;
  }

  Future<Response> destroyAccount(String userToken) async {
    return await dio.post(
      destroyAccountApi,
      options: Options(
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'application/json'
        },
      ),
    );
  }

  confirmDestroyAccount(String userToken, String confirmCode) async {
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Accept': 'application/json'
    };
    return await dio.post(
      destroyAccountConfirmationApi,
      options: Options(headers: headers),
      data: {'code': confirmCode},
    );
  }
}
