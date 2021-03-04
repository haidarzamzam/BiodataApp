import 'package:flutter/material.dart';

class DecorationUtil {
  static final DecorationUtil _singleton = DecorationUtil._internal();

  factory DecorationUtil() => _singleton;

  DecorationUtil._internal();

  InputDecoration roundedFormField({
    Widget prefixIcon,
    Widget suffixIcon,
    Color fillColor,
    Color borderSideColor,
    double radius = 4.0,
    String hintText,
    double contentPadding = 15.0,
  }) {
    final decoration = InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor ?? Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        borderSide: BorderSide(
          color: borderSideColor ?? Color(0xFF000000),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        borderSide: BorderSide(
          color: borderSideColor ?? Color(0xFF000000),
          width: 2,
        ),
      ),
      contentPadding: EdgeInsets.all(contentPadding),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
    );

    return decoration;
  }
}
