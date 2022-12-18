import 'package:flutter/material.dart';
import 'package:test_tech/Core/Utils/colorsConstant.dart';
//font size by default 14
//fontFamily SFProText
//color by default ColorConstant.textColor

class CustomText extends StatelessWidget {
  final String? value;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool? softWrap;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  // ignore: use_key_in_widget_constructors
  const CustomText(
      {this.value,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.overflow,
      this.maxLines,
      this.softWrap,
      this.textAlign,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      value.toString(),
      overflow: overflow,
      maxLines: maxLines,
      textScaleFactor: 1.0,
      textAlign: textAlign,
      softWrap: softWrap,
      style: TextStyle(
          letterSpacing: 0.1,
          decoration: decoration,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 14,
          color: color ?? ColorConstant.blackColor),
    );
  }
}
