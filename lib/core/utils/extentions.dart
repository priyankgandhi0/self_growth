import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:self_growth/core/constants/app_colors.dart';
import 'package:self_growth/core/constants/request_const.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

extension AddSpace on num {
  SizedBox spaceH() {
    return SizedBox(height: toDouble());
  }

  SizedBox spaceW() {
    return SizedBox(width: toDouble());
  }
}

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var wom = 0;
    var date = this;

    while (date.month == month) {
      wom++;
      date = date.subtract(const Duration(days: 7));
    }

    return wom;
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

extension DateTimeOB on DateTime {
  DateTime getLocalDateTime() {
    String dateUtc = DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc, true);
    var dateLocal = dateTime.toLocal();
    return dateLocal;
  }

  int getDateForChatListGroup() {
    return DateTime(year, month, day, 0, 0, 0)
        .getLocalDateTime()
        .millisecondsSinceEpoch;
  }

  String timeDifferenceForChatListGroup() {
    DateTime currentDate = DateTime.now();

    var different = currentDate.difference(getLocalDateTime());

    if (different.inDays > 365) return DateFormat("dd MMM, yyyy").format(this);

    if (different.inDays >= 1) return DateFormat("dd MMM, EEEE").format(this);

    if (different.inDays == 0) return "Today";

    return DateFormat("dd MMM, yyyy").format(this);
  }

  String timeAgo() {
    return DateFormat("h:mm a").format(this);
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

Future<File> urlToFile(String imageUrl, String moodType) async {
  final http.Response responseData = await http.get(Uri.parse(imageUrl));
  Uint8List uint8list = responseData.bodyBytes;
  var buffer = uint8list.buffer;
  ByteData byteData = ByteData.view(buffer);
  Directory cacheDirectory = await getApplicationCacheDirectory();
  File file = await (moodType == moodVoiceType
          ? File("${cacheDirectory.path}/${Random().nextInt(1500)}.wav")
          : File("${cacheDirectory.path}/${Random().nextInt(1500)}.png"))
      .writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  // print('file--${file.path}');

  return file;
}
