import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mistriandlabours/config/app_colors.dart';
import 'package:mistriandlabours/config/app_sizes.dart';

class AppThemes {
  static ThemeData appTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.accentColor,
      primary: AppColors.primaryColor,
    ),
    appBarTheme: AppBarTheme(elevation: 0.6),
    textTheme: TextTheme(
      button: TextStyle(
        color: Colors.white,
      ),
    ),
    drawerTheme: DrawerThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(AppColors.whiteColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.DefaultBorderRadius),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size(50, 50)),
        backgroundColor: MaterialStateProperty.all(AppColors.btnColor),

        // shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: Colors.white,
      ),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.white,
      // labelStyle: PTextTheme.headersMediumTitles.copyWith(
      //   fontSize: PFontSize.fontSize13,
      // ),
      // unselectedLabelStyle: PTextTheme.headersMediumTitles.copyWith(
      //   fontSize: PFontSize.fontSize13,
      // ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.DefaultBorderRadius),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.DefaultBorderRadius),
        borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.6)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.DefaultBorderRadius),
        borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.6)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.DefaultBorderRadius),
        borderSide: BorderSide(color: AppColors.redColor, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.DefaultBorderRadius),
        borderSide: BorderSide(color: AppColors.redColor, width: 2.0),
      ),
    ),
  );
}
