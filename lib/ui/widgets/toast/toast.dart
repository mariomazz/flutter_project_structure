import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      timeInSecForIosWeb: 3,
    );
  }
}
