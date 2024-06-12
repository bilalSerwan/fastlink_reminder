import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fastlink_reminder/links.dart';

class AuthServices {
  final dio = Dio();

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
    // Set the headers for the request.

    log(registerApi);

    // Set the request body.
    final Map<String, String> body = {
      'name': recipientName,
      'email': recipientEmail,
    };

    // Send the POST request to the register API endpoint.
    final response = await dio.post(
      registerApi,
      data: {'email': recipientEmail, 'name': recipientName},
      options: Options(headers: {'Accept': 'application/json'}),
    );

    // Log the response data.
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

  // Future destroyAccount(){

  // }
}
