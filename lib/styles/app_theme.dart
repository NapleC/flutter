import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color scaffoldBG = Color(0xFFF2F2F2); // Scaffold 默认背景色
  static const Color cursorColor = Color(0xFFF2F2F2); // 光标颜色
  static const Color selectionColor = Color(0XFF2196F3); // 文本选中颜色
  static const Color hintColor = Color(0xFF999999); // 提示文本或占位符文本的颜色

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);

  // APP 默认主题
  static ThemeData defaultTheme = ThemeData(
    primarySwatch: Colors.blue,
    textTheme: AppTheme.textTheme,
    platform: TargetPlatform.iOS,
    scaffoldBackgroundColor: scaffoldBG,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: cursorColor,
      selectionColor: selectionColor.withOpacity(0.3),
    ),
    hintColor: hintColor,
  );

  static const String fontName = 'WorkSans';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}
