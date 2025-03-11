import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/services/common_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  var isLoginPage = true.obs;
  var isLongTerm = false.obs;
  var accountType = Constants.acountTypeCoach.obs;

  CommonService commonService = CommonService();

  /* @override
  void onInit() {
    super.onInit();
  } */
}
