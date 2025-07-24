import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  /// primary = #567DF4
  static const Color primary = Color(0xff0352A1);

  /// secondary = #99ACE9
  static const Color secondary = Color(0xff99ACE9);

  /// grey = #A4A4A4
  static const Color grey = Color(0xffA4A4A4);

  /// light = #D0D0D0
  static const Color light = Color(0xffD0D0D0);

  /// lightSheet = #F5F5F5
  static const Color lightSheet = Color(0xffF5F5F5);

  /// blueLight = #C7D0EB
  static const Color blueLight = Color(0xffC7D0EB);

  /// black = #000000
  // static const Color black = Color(0xff000000);
  static const Color black = Color(0xff3A3A3A);

  /// white = #FFFFFF
  static const Color white = Color(0xffFFFFFF);

  /// green = #50C474
  static const Color green = Color(0xff50C474);

  /// greens = #1F6858
  static const Color greens = Color(0xff1F6858);

  /// red = #F65151
  static const Color red = Color(0xffFF3232);

  /// card = #E5E5E5
  static const Color card = Color(0xffE5E5E5);

  /// title = #EFF0F6
  static const Color title = Color(0xffEFF0F6);

  /// disabled = #C8D1E1
  static const Color disabled = Color(0xffC8D1E1);

  /// subtitle = #7890CD
  static const Color subtitle = Color(0xff7890CD);

  /// stroke = #DBDBDB
  static const Color stroke = Color(0xff3A3A3A);

  static const Color bgDefault = Color(0xFFF1F1F1);
}

// TextStyle definitions
TextStyle blackTextStyle = GoogleFonts.plusJakartaSans(color: AppColors.black);

TextStyle whiteTextStyle = GoogleFonts.plusJakartaSans(color: AppColors.white);

TextStyle greyTextStyle = GoogleFonts.plusJakartaSans(color: AppColors.grey);

TextStyle greenTextStyle = GoogleFonts.plusJakartaSans(color: AppColors.green);

TextStyle redTextStyle = GoogleFonts.plusJakartaSans(color: AppColors.red);

TextStyle primaryTextStyle = GoogleFonts.plusJakartaSans(
  color: AppColors.primary,
);

// FontWeight definitions
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
