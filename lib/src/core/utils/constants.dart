import 'dart:ui';

class Constants {
  static const String englishFontFamily = "Montserrat";
  static const String arabicFontFamily = "Almarai";
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  ///azure variables
  static const tenantId = "ce69d0a5-3ace-44e9-a829-a7347d06953a";
  static const clientId = "6fa151b3-2e5b-42dc-bbfd-c1558658c647";
  static const clientSecret = "7gq8Q~.NeLhF__rNjJlVM0AG8xkAufVkpDJ6Kby0";
  static const scope =
      "openid profile email offline_access api://6fa151b3-2e5b-42dc-bbfd-c1558658c647/MOFAScope";

  // "api://6fa151b3-2e5b-42dc-bbfd-c1558658c647/MOFAScope";
  static const redirectUri = "msauth.com.mofa.ksa://auth";
  String token = "";
  // static const String userName = "demouser2@transition-se.com";
  // static const String userPassword = "Yow31954";
  static const String grantType = "password";
}
