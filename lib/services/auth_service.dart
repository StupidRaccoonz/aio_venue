import 'dart:developer';
import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/main.dart';
import 'package:aio_sport/models/login_response_model.dart';
import 'package:aio_sport/models/register_response_model.dart';
import 'package:aio_sport/models/success_response_model.dart';
import 'package:aio_sport/objecbox_models/login_response_obj.dart';
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'server_urls.dart';

class AuthService {
  Dio dio = Dio(BaseOptions(
      baseUrl: ServerUrls.basUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 40),
      sendTimeout: const Duration(seconds: 40)));

  Future<LoginResponseModel?> login(
      {required String email, required String password}) async {
    var headers = {'Accept': 'application/json'};
    final options = Options(headers: headers);
    Map<String, dynamic> body = {'email': email, "password": password};

    // Request request = Request(url: url, method: method, headers: headers)
    try {
      Response response = await dio.post("login", data: body, options: options);
      print('login data ----------------->');
      print(response.data!);

      if (response.data == null) {
        Constants.showSnackbar(
            "Error", "please check your internet connection");
      }

      if (response.statusCode == 200) {
        log("${response.data}");
        log("Objectbox new ID: ${objectbox.loginBox.put(LoginResponseModelObj.fromJson(response.data))}");
        if (LoginResponseModel.fromJson(response.data).httpCode == 200) {
          getStorage.write(Constants.isLoggedIn, true);

          return LoginResponseModel.fromJson(response.data);
        } else {
          Constants.showSnackbar(
              "Error", LoginResponseModel.fromJson(response.data).message);
          return null;
        }
      } else {
        log("response status code: ${response.statusCode} body: ${response.statusMessage}");
        return null;
      }
    } catch (ex) {
      // Constants.showSnackbar("Error", "check your internet connection");
      return null;
    }
  }

  Future<LoginResponseModel?> signInWithGoogle() async {
    // Trigger the authentication flow
    var headers = {'Accept': 'application/json'};
    final options = Options(headers: headers);

    try {
      if (await GoogleSignIn().isSignedIn()) {
        await GoogleSignIn().disconnect();
      }

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          "https://www.googleapis.com/auth/contacts.readonly",
        ],
      );

      if (googleSignIn.currentUser != null) {
        Map<String, dynamic> body = {
          'email': googleSignIn.currentUser?.email,
          "social_type": "google",
          "social_id": googleSignIn.clientId
        };
        Response response =
            await dio.post("social_login", data: body, options: options);

        if (response.data == null) {
          Constants.showSnackbar(
              "Error", "please check your internet connection");
        }

        if (response.statusCode == 200) {
          log("${response.data}");
          log("Objectbox new ID: ${objectbox.loginBox.put(LoginResponseModelObj.fromJson(response.data))}");
          if (LoginResponseModel.fromJson(response.data).httpCode == 200) {
            getStorage.write(Constants.isLoggedIn, true);

            return LoginResponseModel.fromJson(response.data);
          } else {
            Constants.showSnackbar(
                "Error", LoginResponseModel.fromJson(response.data).message);
            return null;
          }
        }
      }
      return null;
    } catch (e) {
      log(e.toString());
      // Constants.showSnackBar("Error", "Authentication error $e", Get.locale?.languageCode == "ar");

      return null;
    }
  }

  Future<RegisterResponseModel?> registerAccount({
    required String number,
    required String userType,
    required String email,
    required String password,
  }) async {
    var headers = {'Accept': 'application/json'};
    final options = Options(headers: headers);
    Map<String, dynamic> body = {
      // "name": name,
      'email': email,
      'phone': number,
      "password": password,
      "user_type": userType,
      "device_token":
          'Test_device_tokenwkdwiqnwieuwq089du90w8d0w9a8d09wa8d09sa8d0sa8d0sad90siad8as09d9a',
    };

    try {
      // Request request = Request(url: url, method: method, headers: headers)
      Response response = await dio
          .post("register", data: body, options: options)
          .catchError((error) {
        log('Error: $error');
        return error;
      }, test: (error) {
        log("response error: $error");
        return false;
      });
      // log("sent request REGISTER: ${response.request!.files?.fields} body: $body");

      if (response.data == null) {
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (response.statusCode == 200 &&
          SuccessResponseModel.fromJson(response.data).httpCode == 200) {
        // log("${response.bodyString}");
        getStorage.write(Constants.isNewAccount, true);
        RegisterResponseModel model =
            RegisterResponseModel.fromJson(response.data);
        log("response status code success: ${response.statusCode} body: ${response.statusMessage}");
        return model;
      } else {
        log("response status code error: ${response.statusCode} body: ${response.statusMessage}");
        Constants.showSnackbar(
            "Result", SuccessResponseModel.fromJson(response.data).message);
        // response.status.printError(info: response.statusText ?? "-");
        return null;
      }
    } catch (ex) {
      print("connection ------------------------->");
      print("${ex}");
      Constants.showSnackbar("Connection Error", "${ex}");
      return null;
    }
    // return response.bodyString == null ? null : await login(email: email, password: password);
  }

  Future<RegisterResponseModel?> changePassword({
    required String oldPassword,
    required String password,
    required String confirmPassword,
    required String token,
  }) async {
    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    final options = Options(headers: headers);
    Map<String, dynamic> body = {
      'old_password': oldPassword,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    try {
      Response response = await dio
          .post("change_password", data: body, options: options)
          .catchError((error) {
        log('Error: $error');
        return error;
      }, test: (error) {
        log("response error: $error");
        return false;
      });
      // log("sent request REGISTER: ${response.request!.files?.fields} body: $body");

      if (response.data == null) {
        // Constants.showSnackbar("Error", "check your internet connection");
        return null;
      }

      if (response.statusCode == 200 &&
          SuccessResponseModel.fromJson(response.data).httpCode == 200) {
        // log("${response.bodyString}");

        RegisterResponseModel model =
            RegisterResponseModel.fromJson(response.data);
        log("response status code success: ${response.statusCode} body: ${response.statusMessage}");
        Constants.showSnackbar(
            "Sucesss", SuccessResponseModel.fromJson(response.data).message);

        return model;
      } else {
        log("response status code error: ${response.statusCode} body: ${response.statusMessage}");
        Constants.showSnackbar(
            "Error", SuccessResponseModel.fromJson(response.data).message);
        // response.status.printError(info: response.statusText ?? "-");
        return null;
      }
    } catch (ex) {
      print("connection ------------------------->");
      print("${ex}");
      Constants.showSnackbar("Connection Error", "${ex}");
      return null;
    }
    // return response.bodyString == null ? null : await login(email: email, password: password);
  }
}
