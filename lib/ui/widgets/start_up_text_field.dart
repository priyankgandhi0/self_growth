import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_growth/core/utils/extentions.dart';

import '../../core/constants/app_colors.dart';
import '../../gen/assets.gen.dart';

class AppTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final double prefixIconHeight;
  final double suffixIconHeight;
  final double prefixIconWidth;
  final double suffixIconWidth;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final String prefixIcon;
  final bool showPrefixIcon;
  final String suffixIcon;
  final bool? showSuffixIcon;

  final TextEditingController? textEditingController;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatter;

  final EdgeInsets? textFieldPadding;
  final double? labelTextSize;
  final bool obscureText;

  final bool isError;

  final TextInputType? keyboardType;

  final Function(String value)? onChanged;
  final Function(String value) validator;

  const AppTextField(
      {Key? key,
      this.labelText = '',
      this.textEditingController,
      required this.prefixIcon,
      required this.suffixIcon,
      this.hintTextStyle,
      this.textStyle,
      this.maxLines = 1,
      required this.validator,
      this.onChanged,
      this.textFieldPadding,
      this.labelTextSize,
      this.keyboardType,
      this.isError = false,
      this.obscureText = false,
      this.showPrefixIcon = true,
      this.inputFormatter,
      this.showSuffixIcon,
      this.prefixIconHeight = 16,
      this.suffixIconHeight = 24,
      this.prefixIconWidth = 20,
      this.suffixIconWidth = 24,
      this.hintText = ''})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool isFocus = false;

  void _onFocusChange() {
    setState(() {
      isFocus = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _focusNode.addListener(_onFocusChange);
    super.initState();
  }

  String textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          widget.textFieldPadding ?? EdgeInsets.only(left: 20.w, right: 20.w),
      child: Column(
        children: [
          if (widget.labelText.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: widget.labelText.appTextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: widget.labelTextSize ?? 11.sp,
                  fontColor: _focusNode.hasFocus ? black_000000 : grey_969696),
            ),
          if (widget.labelText.isNotEmpty) (8).spaceH(),
          SizedBox(
            height: 48,
            child: TextFormField(
              maxLines: widget.maxLines,
              controller: widget.textEditingController,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              inputFormatters: widget.inputFormatter,
              focusNode: _focusNode,
              validator: (value) {
                return widget.validator(value!);
              },
              onChanged: (value) {
                textFieldValue = value;
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
              cursorColor: black_000000,
              style: widget.textStyle ??
                  GoogleFonts.plusJakartaSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: black_000000),
              obscureText: widget.obscureText,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                prefixIcon: widget.showPrefixIcon
                    ? SvgGenImage(widget.prefixIcon)
                        .svg(
                            height: widget.prefixIconHeight,
                            width: widget.prefixIconWidth,
                            // ignore: deprecated_member_use_from_same_package
                            color: isFocus ? black_000000 : grey_969696,
                            fit: BoxFit.contain)
                        .paddingAll(16.sp)
                    : null,
                suffixIcon: widget.showSuffixIcon ?? true
                    ? SvgGenImage(widget.suffixIcon)
                        .svg(
                            height: widget.suffixIconHeight,
                            width: widget.suffixIconWidth,
                            fit: BoxFit.contain)
                        .paddingAll(16.sp)
                    : null,
                hintText: widget.hintText,
                hintStyle: widget.hintTextStyle ??
                    GoogleFonts.plusJakartaSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: grey_969696),
                fillColor: textFieldValue.isNotEmpty
                    ? background_F5F5F5.withOpacity(0.1)
                    : widget.isError
                        ? grey_969696.withOpacity(0.5)
                        : (_focusNode.hasFocus)
                            ? background_F5F5F5.withOpacity(0.1)
                            : grey_969696.withOpacity(0.2),
                filled: true,
                errorStyle: const TextStyle(height: 0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(
                        color: textFieldValue.isNotEmpty
                            ? grey_969696.withOpacity(0.5)
                            : grey_969696.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide:
                        BorderSide(color: grey_969696.withOpacity(0.5))),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(
                        color: widget.isError
                            ? appRed.withOpacity(0.5)
                            : grey_969696.withOpacity(0.2))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(
                        color: widget.isError
                            ? appRed.withOpacity(0.5)
                            : grey_969696.withOpacity(0.5))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
