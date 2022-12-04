import 'package:flutter/material.dart';
import 'package:flutter_app_kitchen/ui/color.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyle {
  TextStyle get textLogin {
    return GoogleFonts.josefinSans(fontSize: 70, color: colorMain);
  }

  TextStyle get textCategory {
    return GoogleFonts.josefinSans(fontSize: 20, color: Colors.white);
  }

  TextStyle get textUsername {
    return GoogleFonts.josefinSans(fontSize: 16, color: colorMain);
  }

  TextStyle get textManager {
    return GoogleFonts.josefinSans(
        fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
  }

  TextStyle get textName {
    return GoogleFonts.josefinSans(
        fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold);
  }

  TextStyle get textPrice {
    return GoogleFonts.josefinSans(
        fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold);
  }

  TextStyle get textSub {
    return GoogleFonts.josefinSans(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400);
  }

  TextStyle get textAppbar {
    return GoogleFonts.josefinSans(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400);
  }

  TextStyle get textNameBill {
    return GoogleFonts.josefinSans(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
  }

  TextStyle get textPriceBill {
    return GoogleFonts.josefinSans(
        fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold);
  }
}
