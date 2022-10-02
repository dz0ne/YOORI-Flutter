import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

String? validateNotEmpty(String value) {
  if (value.isEmpty) {
    return 'field is required!';
  } else {
    return null;
  }
}

String? validateMatch(String value, String value2) {
  if (value.isEmpty || value != value2) {
    return 'Password does not match!';
  } else {
    return null;
  }
}

String? validateMinLength(String value, {int length = 6}) {
  if (value.length < length) {
    return 'minimum $length character are required !';
  } else {
    return null;
  }
}

String? validateMeetingCode(String value, {int length = 9}) {
  if (value.length != length) {
    return 'Meeting code must be of $length digit !';
  } else {
    return null;
  }
}

String? validatePhone(String value) {
  if (value.length < 10) {
    return 'valid phone number is required !';
  } else {
    return null;
  }
}

String? validateEmail(String value) {
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'valid email is required !';
  } else {
    return null;
  }
}

String? validateDelete(String value) {
  if (value != "DELETE") {
    return 'Please Type Delete';
  } else {
    return null;
  }
}

void showShortToast(String message, {Color? bgColor}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: bgColor ?? Colors.black,
      timeInSecForIosWeb: 1);
}

void showErrorToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red);
}

void showCustomSnackBar(String message, {bool isError = true}) {
  if (message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      maxWidth: 200,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.all(10),
      borderRadius: 5,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}
