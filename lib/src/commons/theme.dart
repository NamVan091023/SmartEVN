import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'constants.dart';

ThemeData themeLight() {
  return FlexThemeData.light(
    scheme: FlexScheme.aquaBlue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 18,
    appBarStyle: FlexAppBarStyle.primary,
    appBarOpacity: 0.95,
    appBarElevation: 0,
    transparentStatusBar: true,
    tabBarStyle: FlexTabBarStyle.forAppBar,
    tooltipsMatchBackground: true,
    swapColors: false,
    lightIsWhite: false,
    useSubThemes: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // To use playground font, add GoogleFonts package and uncomment:
    fontFamily: GoogleFonts.notoSans().fontFamily,
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      fabUseShape: true,
      interactionEffects: true,
      bottomNavigationBarElevation: 0,
      bottomNavigationBarOpacity: 0.95,
      navigationBarOpacity: 0.95,
      navigationBarMutedUnselectedText: true,
      navigationBarMutedUnselectedIcon: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorUnfocusedHasBorder: true,
      blendOnColors: true,
      blendTextTheme: true,
      popupMenuOpacity: 0.95,
    ),
  );
}

ThemeData themeDark() {
  return FlexThemeData.dark(
    scheme: FlexScheme.aquaBlue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 18,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.95,
    appBarElevation: 0,
    transparentStatusBar: true,
    tabBarStyle: FlexTabBarStyle.forAppBar,
    tooltipsMatchBackground: true,
    swapColors: false,
    darkIsTrueBlack: false,
    useSubThemes: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    // To use playground font, add GoogleFonts package and uncomment:
    fontFamily: GoogleFonts.notoSans().fontFamily,
    subThemesData: const FlexSubThemesData(
      useTextTheme: true,
      fabUseShape: true,
      interactionEffects: true,
      bottomNavigationBarElevation: 0,
      bottomNavigationBarOpacity: 0.95,
      navigationBarOpacity: 0.95,
      navigationBarMutedUnselectedText: true,
      navigationBarMutedUnselectedIcon: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorUnfocusedHasBorder: true,
      blendOnColors: true,
      blendTextTheme: true,
      popupMenuOpacity: 0.95,
    ),
  );
}
// InputDecorationTheme inputDecorationTheme() {
//   OutlineInputBorder outlineInputBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(14),
//     borderSide: BorderSide(color: kTextColor),
//     gapPadding: 10,
//   );
//   OutlineInputBorder outlineForcusInputBorder = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(14),
//     borderSide: BorderSide(color: Colors.green),
//     gapPadding: 10,
//   );
//   return InputDecorationTheme(
//     // If  you are using latest version of flutter then lable text and hint text shown like this
//     // if you r using flutter less then 1.20.* then maybe this is not working properly
//     // if we are define our floatingLabelBehavior in our theme then it's not applayed
//     floatingLabelBehavior: FloatingLabelBehavior.always,
//     contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//     enabledBorder: outlineInputBorder,
//     focusedBorder: outlineForcusInputBorder,
//     border: outlineInputBorder,
//     labelStyle: TextStyle(fontSize: 16),
//   );
// }

// TextTheme textTheme() {
//   return TextTheme(
//     bodyText1: TextStyle(color: kTextColor),
//     bodyText2: TextStyle(color: kTextColor, fontSize: 16),
//     subtitle1: TextStyle(color: Colors.black, fontSize: 14),
//   );
// }

// AppBarTheme appBarTheme() {
//   return AppBarTheme(
//     color: Colors.transparent,
//     elevation: 0,
//     systemOverlayStyle: SystemUiOverlayStyle.dark,
//     iconTheme: IconThemeData(color: Colors.black),
//     titleTextStyle: TextStyle(
//         color: Colors.black,
//         fontSize: 28,
//         fontWeight: FontWeight.bold,
//         height: 1.5),
//   );
// }
