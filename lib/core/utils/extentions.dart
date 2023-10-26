import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

extension AddSpace on num {
  SizedBox spaceH() {
    return SizedBox(height: toDouble());
  }

  SizedBox spaceW() {
    return SizedBox(width: toDouble());
  }
}

extension WidgetExt on Widget {
  Widget onTap(GestureTapCallback onTap) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: this,
    );
  }

  Widget onClick(GestureTapCallback onClick) {
    return GestureDetector(
      onTap: onClick,
      child: this,
    );
  }
}

extension AddText on String {
  Widget appTextStyle(
      {Color fontColor = borderPurpleColor,
      bool? opacity,
      double? fontSize,
      TextAlign textAlign = TextAlign.center,
      FontWeight fontWeight = FontWeight.w500,
      TextOverflow? textOverflow,
      int? maxLines,
      TextDecoration? decoration,
      double? letterSpacing,
      String? fontFamily,
      FontStyle? fontStyle,
      List<Color>? gradientColors,
      Color? decorationColor}) {
    return Text(
      maxLines: maxLines,
      this,
      overflow: textOverflow,
      style: GoogleFonts.plusJakartaSans(
        fontSize: fontSize?.sp ?? 16.sp,
        color: (opacity ?? false) ? fontColor.withOpacity(0.5) : fontColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle ?? FontStyle.normal,
        decoration: decoration ?? TextDecoration.none,
        letterSpacing: letterSpacing ?? 0,
        decorationColor:
            (opacity ?? false) ? fontColor.withOpacity(0.5) : fontColor,
      ),
      textAlign: textAlign,
    );
  }
}

extension AddGradientText on String {
  Widget appGradientTextStyle(
      {Color fontColor = black_000000,
      bool? opacity,
      double? fontSize,
      TextAlign textAlign = TextAlign.center,
      FontWeight fontWeight = FontWeight.w500,
      TextOverflow? textOverflow,
      int? maxLines,
      TextDecoration? decoration,
      double? letterSpacing,
      String? fontFamily,
      FontStyle? fontStyle,
      List<Color>? gradientColors,
      Color? decorationColor}) {
    return GradientText(
      maxLines: maxLines,
      this,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: fontSize?.sp ?? 16.sp,
        color: (opacity ?? false) ? fontColor.withOpacity(0.5) : fontColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: 'Switzer',
        decoration: decoration ?? TextDecoration.none,
        letterSpacing: letterSpacing ?? 0,
        decorationColor:
            (opacity ?? false) ? fontColor.withOpacity(0.5) : fontColor,
      ),
      textAlign: textAlign,
      colors: gradientColors ??
          [
            const Color(0xffD4E0DF),
            const Color(0xffE0CECD),
            const Color(0xffEDE3FF)
          ],
    );
  }
}

extension AddSwitzerText on String {
  Widget appSwitzerTextStyle(
      {Color fontColor = black_000000,
      bool? opacity,
      double? fontSize,
      TextAlign textAlign = TextAlign.center,
      FontWeight fontWeight = FontWeight.w500,
      TextOverflow? textOverflow,
      int? maxLines,
      TextDecoration? decoration,
      double? letterSpacing,
      String? fontFamily,
      FontStyle? fontStyle,
      Color? decorationColor}) {
    return Text(
      maxLines: maxLines,
      this,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: fontSize?.sp ?? 16.sp,
        color: (opacity ?? false) ? fontColor.withOpacity(0.5) : fontColor,
        fontWeight: fontWeight,
        fontFamily: 'Switzer',
        fontStyle: fontStyle ?? FontStyle.normal,
        decoration: decoration ?? TextDecoration.none,
        letterSpacing: letterSpacing ?? 0,
        decorationColor:
            (opacity ?? false) ? fontColor.withOpacity(0.5) : fontColor,
      ),
      textAlign: textAlign,
    );
  }
}

TextStyle getTextStyle(
    {Color fontColor = black_000000,
    bool? opacity,
    double? fontSize,
    TextAlign textAlign = TextAlign.center,
    FontWeight fontWeight = FontWeight.w500,
    TextOverflow? textOverflow,
    int? maxLines,
    TextDecoration? decoration,
    double? letterSpacing,
    String? fontFamily,
    FontStyle? fontStyle,
    Color? decorationColor}) {
  return TextStyle(
    fontSize: fontSize?.sp ?? 16.sp,
    color: (opacity ?? false) ? fontColor.withOpacity(0.5) : fontColor,
    fontWeight: fontWeight,
    fontStyle: fontStyle ?? FontStyle.normal,
    decoration: decoration ?? TextDecoration.none,
    letterSpacing: letterSpacing ?? 0,
    fontFamily: 'Switzer',
    decorationColor:
        (opacity ?? false) ? fontColor.withOpacity(0.5) : fontColor,
  );
}

bool isEmailValid(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return regex.hasMatch(email);
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write('-');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    final offset = text.length + 1;

    return newValue.copyWith(
      text: text.length >= 1 ? '+$text' : '',
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

class ExpirationDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 2 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write('/');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
