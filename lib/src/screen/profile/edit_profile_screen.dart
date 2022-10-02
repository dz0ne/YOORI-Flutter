import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoori_ecommerce/src/controllers/profile_content_controller.dart';
import 'package:yoori_ecommerce/src/servers/repository.dart';
import 'package:yoori_ecommerce/src/utils/app_tags.dart';
import 'package:yoori_ecommerce/src/utils/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:yoori_ecommerce/src/widgets/button_widget.dart';
import 'dart:convert';
import 'dart:io';

import '../../models/profile_data_model.dart';
import '../../utils/responsive.dart';
import '../../widgets/loader/loader_widget.dart';
import '../../widgets/login_edit_textform_field.dart';




class EditProfile extends StatefulWidget {
  final ProfileDataModel userDataModel;
  const EditProfile({Key? key, required this.userDataModel}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  bool showPassword = false;
  bool isLoading = false;
  List genderList = ["Male", "Female"];
  String? selectGender;
  File? selectedImage;
  String base64Image = "";
  final _profileController = Get.find<ProfileContentController>();

  Future<void> chooseImage(type) async {
    XFile? image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image!.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }
  }
  @override
  void initState() {
    firstNameController =
        TextEditingController(text: widget.userDataModel.data!.firstName);
    lastNameController =
        TextEditingController(text: widget.userDataModel.data!.lastName);
    emailController =
        TextEditingController(text: widget.userDataModel.data!.email);
    phoneController =
        TextEditingController(text: widget.userDataModel.data!.phone);
    super.initState();
  }

  @override
  void dispose() {
    firstNameController!.dispose();
    lastNameController!.dispose();
    emailController!.dispose();
    phoneController!.dispose();
    super.dispose();
  }

  String? formetedDate;
  DateTime? datePicked;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar:isMobile(context)? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),

          onPressed: () {
            Get.back();
          }, // null disables the button
        ),
        centerTitle: true,
        title: Text(
          AppTags.editProfile.tr,
          style: AppThemeData.headerTextStyle_16,
        ),
      ): AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 60.h,
      leadingWidth: 40.w,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 25.r,
        ),

        onPressed: () {
          Get.back();
        }, // null disables the button
      ),
      centerTitle: true,
      title: Text(
        AppTags.editProfile.tr,
        style: AppThemeData.headerTextStyle_14,
      ),
    ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _ui(),
                isLoading ? const LoaderWidget() : const SizedBox(),
              ],
            )),
      ),
    );
  }

  Widget _ui() {
    return ListView(
      children: [
        SizedBox(
          height: 15.h,
        ),
        Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(1), // Border radius
                child: selectedImage != null ||
                        widget.userDataModel.data!.image != null
                    ? ClipOval(
                        child: selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                                height: 75.h,
                                width: isMobile(context)? 75.w:50.w,
                              )
                            : Image.network(
                                widget.userDataModel.data!.image!,
                                fit: BoxFit.cover,
                                height: 75.h,
                                width:isMobile(context)? 75.w:50.w,
                              ))
                    : ClipOval(
                        child: SvgPicture.asset(
                        "assets/icons/d_user.svg",
                        fit: BoxFit.cover,
                        height: 75.h,
                        width: isMobile(context)? 75.w:50.w,
                      )),
              ),
              Positioned(
                  bottom: 0.h,
                  right:isMobile(context)? 2.w:0.w,
                  child: InkWell(
                    onTap: () {
                      chooseImage("Gallery");
                    },
                    child: Container(
                      height: 24.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: Colors.green,
                        ),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.green,
                        size: 15.r,
                      ),
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            AppTags.firstName.tr,
            style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,
          ),
        ),
        LoginEditTextField(
          myController: firstNameController,
          keyboardType: TextInputType.text,
          hintText: AppTags.firstName.tr,
          fieldIcon: Icons.person,
          myobscureText: false,
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            AppTags.lastName.tr,
            style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,
          ),
        ),
        LoginEditTextField(
          myController: lastNameController,
          keyboardType: TextInputType.text,
          hintText: AppTags.lastName.tr,
          fieldIcon: Icons.person,
          myobscureText: false,
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(AppTags.phone.tr, style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,),
        ),
        LoginEditTextField(
          isReadonly: true,
          myController: phoneController,
          keyboardType: TextInputType.text,
          hintText: AppTags.phone.tr,
          fieldIcon: Icons.phone,
          myobscureText: false,
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(AppTags.email.tr, style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,),
        ),
        LoginEditTextField(
          isReadonly: true,
          myController: emailController,
          keyboardType: TextInputType.text,
          hintText: AppTags.email.tr,
          fieldIcon: Icons.email,
          myobscureText: false,
        ),
        SizedBox(
          height: 8.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(AppTags.gender.tr, style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal:isMobile(context)? 15.w:15.w),
          child: Container(
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
            child: Padding(
              padding: EdgeInsets.only(left: 15.w, right: 10.w,top: isMobile(context)? 3.h:8.h,bottom: isMobile(context)? 3.h:8.h),
              child: DropdownButton<String>(
                hint: Text(widget.userDataModel.data!.gender!.isNotEmpty?widget.userDataModel.data!.gender!:AppTags.selectGender.tr,
                    style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,),
                value: selectGender,
                isExpanded: true,
                underline: Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectGender = newValue;
                  });
                },
                items: genderList.map((user) {
                  return DropdownMenuItem<String>(
                    value: user,
                    child: Text(
                      user,
                      style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(AppTags.dateOfBirth.tr, style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,),
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 12,
                shadowColor: const Color(0xff404040).withOpacity(0.15),
                padding: EdgeInsets.all(12.r),
                primary: Colors.white, // background
                onPrimary: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ) // foreground
                ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      formetedDate != null
                          ? formetedDate!
                          : widget.userDataModel.data!.dateOfBirth!.isNotEmpty?widget.userDataModel.data!.dateOfBirth!: AppTags.selectDateOfBirth.tr,
                      style: isMobile(context)? AppThemeData.titleTextStyle_14:AppThemeData.titleTextStyle_11Tab,),
                  const Icon(Icons.date_range)
                ],
              ),
            ),
            onPressed: () async {
              datePicked = await DatePicker.showSimpleDatePicker(
                context,
                initialDate: DateTime(1994),
                firstDate: DateTime(1960),
                lastDate: DateTime(2012),
                dateFormat: "dd-MMMM-yyyy",
                locale: DateTimePickerLocale.en_us,
                looping: true,
              );
              setState(() {
                formetedDate = DateFormat('yyyy-MM-dd').format(datePicked!);
              });
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.all(15.r),
          child: GestureDetector(
            onTap: () {
              if(isLoading==false){
                updateProfile();
              }
            },
            child: ButtonWidget(buttonTittle: AppTags.update.tr),
          ),
        )
      ],
    );
  }

  void updateProfile() {
    setState(() {
      isLoading = true;
    });
    selectedImage != null
        ? Repository()
            .postUpdateProfile(
            firstName: firstNameController!.text,
            lastName: lastNameController!.text,
            emailAddress: emailController!.text,
            phoneNumber: phoneController!.text,
            gender: selectGender != null
                ? selectGender.toString()
                : widget.userDataModel.data!.gender.toString(),
            dob: formetedDate != null
                ? formetedDate!.toString()
                : widget.userDataModel.data!.dateOfBirth.toString(),
            image: selectedImage!,
          )
            .then((value) {
            if (value != null) {
              _profileController.updateUserData(value);
            }
            setState(() {
              isLoading = false;
            });
            Get.snackbar(
                value != null ? "Success" : "Failed",
                value != null
                    ? AppTags.profileUpdatedSuccessfully.tr
                    : AppTags.failedToUpdateProfile.tr,
                backgroundColor: value != null ? Colors.white : Colors.red,
                snackPosition: SnackPosition.BOTTOM);
          })
        : Repository()
            .postUpdateProfileWithOutImage(
            firstName: firstNameController!.text,
            lastName: lastNameController!.text,
            emailAddress: emailController!.text,
            phoneNumber: phoneController!.text,
            gender: selectGender != null
                ? selectGender.toString()
                : widget.userDataModel.data!.gender.toString(),
            dob: formetedDate != null
                ? formetedDate!.toString()
                : widget.userDataModel.data!.dateOfBirth.toString(),
          )
            .then((value) {
            if (value != null) {
              _profileController.updateUserData(value);
            }

            setState(() {
              isLoading = false;
            });
            Get.snackbar(
                value != null ? "Success" : "Failed",
                value != null
                    ? AppTags.profileUpdatedSuccessfully.tr
                    : AppTags.failedToUpdateProfile.tr,
                backgroundColor: value != null ? Colors.white : Colors.red,
                snackPosition: SnackPosition.BOTTOM);
          });
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3.h),
            labelText: labelText,
            labelStyle: isMobile(context)? AppThemeData.labelTextStyle_16 :AppThemeData.priceTextStyle_14,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle:isMobile(context)? AppThemeData.hintTextStyle_13:AppThemeData.hintTextStyle_10Tab),
      ),
    );
  }
}
