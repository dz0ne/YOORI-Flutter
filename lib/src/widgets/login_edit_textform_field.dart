import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class LoginEditTextField extends StatelessWidget {
  final String? hintText;
  final IconData? fieldIcon;
  final TextInputType? keyboardType;
  final TextEditingController? myController;
  final bool? myobscureText;
  final dynamic myvalidate;
  final dynamic onsave;
  final String? labelText;
  final Widget? sufficon;
  final bool isReadonly;
  const LoginEditTextField({
    Key? key,
    this.isReadonly = false,
    this.labelText,
    this.fieldIcon,
    this.hintText,
    this.myController,
    this.keyboardType,
    this.myobscureText,
    this.sufficon,
    this.myvalidate,
    this.onsave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          //color: Color(0xfff3f3f4),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff404040).withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 30,
              offset: const Offset(0, 15), // changes position of shadow
            ),
          ],
        ),
        child: TextFormField(
          style: isMobile(context)? AppThemeData.titleTextStyle_13:AppThemeData.titleTextStyleTab,
          readOnly: isReadonly,
          obscureText: myobscureText!,
          validator: myvalidate,
          controller: myController,
          onSaved: onsave,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: sufficon,
            suffixIconColor: const Color(0xff999999),
            hintText: hintText,
            hintStyle: isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab,
            contentPadding: EdgeInsets.only(
              left: 8.w,
              right: 8.w,
              top: 15.h,
            ),
            prefixIcon: Icon(
              fieldIcon,
              color: const Color(0xff999999),
              size: isMobile(context)? 17.r:20.r,
            ),
            border: InputBorder.none,
            filled: false,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.w,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.red,
                width: 2.w,
              ),
            ),

            //border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
