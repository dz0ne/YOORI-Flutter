// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';

class InputChipWidget extends StatelessWidget {
  late final String label;
   bool isSelected = true;
  Function onSelected;
  InputChipWidget(
      {required this.label,
       
      required this.onSelected,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InputChip(
        padding: const EdgeInsets.all(4.0),
        elevation: 1,
        showCheckmark: true,
        backgroundColor: const Color(0xffF4F4F4),
        checkmarkColor: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        label: Text(
          label,
          style: AppThemeData.categoryTitleTextStyle_12,
        ),
        selected: isSelected,
        selectedColor: Colors.green,
        onSelected: (value) => isSelected = value,
      ),
    );
  }
}
