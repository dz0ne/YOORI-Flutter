import 'package:flutter/material.dart';

class Config {
  // copy your server url from admin panel
  static String apiServerUrl = "https://achri-mn-eulma.com/api";
  // copy your api key from admin panel
  static String apiKey = "ZLZWGOAAMPHIXNSO";

  //enter onesignal app id below
  static String oneSignalAppId = "fe15cb82-a45f-4ea7-8501-9dd973547563";
  // find your ios APP id from app store
  static const String iosAppId = "";
  static const bool enableGoogleLogin = true;
  static const bool enableFacebookLogin = true;

  static var supportedLanguageList = [
    const Locale("en", "US"),
    const Locale("bn", "BD"),
    const Locale("ar", "SA"),
  ];
  static const String initialCountrySelection = "BD";
}
