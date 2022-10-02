import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:yoori_ecommerce/src/models/user_data_model.dart';

import 'repository.dart';
import '../screen/dashboard/dashboard_screen.dart';

class SocialAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Apple Login
  Future<bool?> signInWithApple() async {
    User? user = await _signInWithApple();
    if (user != null) {
      UserDataModel? userDataModel = await Repository()
          .postFirebaseAuth(
              name: user.displayName.toString(),
        email: user.email.toString(),
        phone: user.providerData[0].email ?? "",
        image: user.photoURL??"",
        providerId: "apple.com",
        uid: user.uid
      )
          .then((value) =>
              Get.offAll(() => DashboardScreen())); //send user data to server
      //save user login data to database
      if (userDataModel != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<User?> _signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode);
    final User? user = (await _auth.signInWithCredential(credential)).user;
    if (user!.email != null && user.email != "") {
      assert(user.email != null);
    }
    if (user.displayName != null && user.displayName != "") {
      assert(user.displayName != null);
    }
    assert(!user.isAnonymous);

    final User? currentUser =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.uid == currentUser!.uid);
    return user;
  }

  
}
