import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_tags.dart';

class InternetCheckView extends StatelessWidget {
  const InternetCheckView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
                width: 90,
                child: Image.asset("assets/images/nointernet.png"),
            ),
            const SizedBox(height: 10,),
             Text(AppTags.pleaseCheckYourInternet.tr)
          ],
        ),
      ),
    );
  }
}
