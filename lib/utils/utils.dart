import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StringCheck on String? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
  bool get isEmailValid {
    if (this == null || this!.isEmpty) return false;
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this!);
    return emailValid;
  }

  bool get isPasswordValid {
    if (this == null || this!.isEmpty||this!.length<6) return false;
    return true;
  }

  bool get validateInfo  => isNotNullOrEmpty && this!.length>=3;

  bool get validateMobile {
    RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
    if (!isNotNullOrEmpty) {
      return false;
    } else if (!regExp.hasMatch(this!)) {
      return false;
    }
    return true;
  }
}



/// Padding
const vPaddingBetweenWidgets = 15.0;
const vPaddingBetweenSectionWidgets = 35.0;
const hPaddingFromScreen =15.0;

void showToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );
}