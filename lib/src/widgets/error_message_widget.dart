import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppThemeData.addAddressTextStyle_13.copyWith(color: Colors.black),
      ),
    );
  }
}
