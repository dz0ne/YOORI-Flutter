import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoori_ecommerce/src/screen/home/home_screen.dart';
import 'package:yoori_ecommerce/src/utils/constants.dart';


class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    sendVerificationEmail();

    //User need to be created before

    // //isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    // if (!isEmailVerified) {
    //   sendVerificationEmail();
    //   timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    //     checkEmailVerified();
    //   });
    // }
  }

  Future checkEmailVerified() async {
    FirebaseAuth.instance.currentUser!.reload();
    // user.reload;
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      // await firebase.auth().currentUser.sendEmailVerification();
      await user!.sendEmailVerification().then((value) {
            printLog("sent email: ");
      });

    } on Exception catch (e) {
      printLog("verification page: error: $e");
    }
  }


  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomeScreenContent()
      : Scaffold(
      appBar: AppBar(
        title: const Text("Verify your email"),
        centerTitle: true,
        elevation: 0,


      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Verification email is sent to you!!",
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center),
        ],
      ));
}