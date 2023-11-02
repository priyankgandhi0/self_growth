import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:self_growth/core/utils/extentions.dart';

import '../../core/constants/app_colors.dart';
import '../../gen/assets.gen.dart';

class AppTextField extends StatefulWidget {
  final String labelText;
  final FontWeight? labelFontWeight;
  final String hintText;
  final double prefixIconHeight;
  final double suffixIconHeight;
  final double prefixIconWidth;
  final double suffixIconWidth;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final String? prefixIcon;
  final bool showPrefixIcon;
  final String? suffixIcon;
  final String obscuringCharacter;
  final bool? showSuffixIcon;

  final TextEditingController? textEditingController;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatter;

  final EdgeInsets? textFieldPadding;
  final double? labelTextSize;
  final bool obscureText;
  final int? maxLength;

  final bool isError;

  final TextInputType? keyboardType;

  final Function(String value)? onChanged;
  final Function(String value)? validator;

  const AppTextField(
      {Key? key,
      this.labelText = '',
      this.textEditingController,
      this.prefixIcon,
      this.suffixIcon,
      this.hintTextStyle,
      this.textStyle,
      this.maxLines = 1,
      this.validator,
      this.onChanged,
      this.textFieldPadding,
      this.labelTextSize,
      this.maxLength,
      this.labelFontWeight,
      this.keyboardType,
      this.isError = false,
      this.obscureText = false,
      this.showPrefixIcon = false,
      this.inputFormatter,
      this.showSuffixIcon = false,
      this.prefixIconHeight = 16,
      this.suffixIconHeight = 24,
      this.prefixIconWidth = 20,
      this.suffixIconWidth = 24,
      this.hintText = '',
      this.obscuringCharacter = '.'})
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
    return Column(
      children: [
        if (widget.labelText.isNotEmpty)
          Align(
            alignment: Alignment.centerLeft,
            child: widget.labelText.appSwitzerTextStyle(
              fontWeight: widget.labelFontWeight ?? FontWeight.w500,
              fontColor: borderPurpleColor.withOpacity(0.6),
              fontSize: widget.labelTextSize ?? 14.sp,
              // fontColor: _focusNode.hasFocus ? grey_969696 : borderPurpleColor,
            ),
          ),
        if (widget.labelText.isNotEmpty) (8).spaceH(),
        SizedBox(
          child: TextFormField(
            maxLength: widget.maxLength,
            scrollPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).viewInsets.bottom),
            obscuringCharacter: widget.obscuringCharacter,
            maxLines: widget.maxLines,
            controller: widget.textEditingController,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            inputFormatters: widget.inputFormatter,
            focusNode: _focusNode,
            validator: (value) {
              if (widget.validator != null) {
                return widget.validator!(value!);
              }
              return null;
            },
            onChanged: (value) {
              textFieldValue = value;
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            cursorColor: borderPurpleColor,
            style: widget.textStyle ??
                TextStyle(
                    fontFamily: 'Switzer',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: borderPurpleColor),
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              prefixIcon: widget.showPrefixIcon
                  ? SvgGenImage(widget.prefixIcon!)
                      .svg(
                          height: widget.prefixIconHeight,
                          width: widget.prefixIconWidth,
                          // ignore: deprecated_member_use_from_same_package
                          color: isFocus ? borderPurpleColor : grey_969696,
                          fit: BoxFit.contain)
                      .paddingAll(16.sp)
                  : null,
              suffixIcon: widget.showSuffixIcon ?? true
                  ? SvgGenImage(widget.suffixIcon!)
                      .svg(
                          height: widget.suffixIconHeight,
                          width: widget.suffixIconWidth,
                          fit: BoxFit.contain)
                      .paddingAll(16.sp)
                  : null,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle ??
                  TextStyle(
                      fontFamily: 'Switzer',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: doteColor),
              fillColor: textFiledColor,
              filled: true,
              errorStyle: const TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                  borderSide: const BorderSide(color: borderPurpleColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                  borderSide: BorderSide(color: appRed.withOpacity(0.5))),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.sp),
                  borderSide: BorderSide(color: appRed.withOpacity(0.5))),
            ),
          ),
        ),
      ],
    );
  }
}
