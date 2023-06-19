import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constant {
  static String BASE_PATH = "https://members.rotary3131.org/member-login/";
  static String API_URL = BASE_PATH + "android/";
  static const Color color_theme = const Color(0xff104494);

  static const Color color_clubmeeting = const Color(0xFFCFE2FF);
  static const Color color_clubroaster = const Color(0xFFF6CFFF);
  static const Color coior_clubcelebration = const Color(0xFFCFFFDD);
  static const Color color_project = const Color(0xFFFFCFCF);
  static const Color color_clubbulletins = const Color(0xFFFFEFCF);
  static const Color color_membersearch = const Color(0xFFCFD4FF);
  static const Color color_districtcommitees = const Color(0xFFCFF0FF);
  static const Color color_infoofleaders = const Color(0xFFCFFFFA);

  static displayToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3);
  }

  Connectivity connectivity = Connectivity();
  String getConnectionValue(var connectivityResult) {
    String status = '';
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'Mobile';
        break;
      case ConnectivityResult.wifi:
        status = 'Wi-Fi';
        break;
      case ConnectivityResult.none:
        status = '';
        break;
      default:
        status = '';
        break;
    }
    return status;
  }

  Future<String> checkConnectivity() async {
    var connectivityResult = await connectivity.checkConnectivity();
    var conn = getConnectionValue(connectivityResult);
    return conn;
  }
}
