import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/models/login_response_model.dart';
import 'package:aio_sport/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var loading = false.obs;
  Rx<LoginResponseModel?> loginResponseModel = Rx(null);
  AuthService authService = AuthService();
  var accountType = Constants.acountTypeVenue.obs;
  var isLoginPage = true.obs;
  var isLoggedIn = false.obs;
}
