import 'package:flutter/material.dart';
import 'package:toastification/src/built_in/layout/standard/style/style.dart';
import 'package:toastification/src/utils/color_utils.dart';

class SimpleStandardToastStyle extends BaseStandardToastStyle {
  const SimpleStandardToastStyle({
    required super.type,
    super.providedValues,
    super.flutterTheme,
  });

  @override
  DefaultStyleValues get defaults => DefaultStyleValues(
        primaryColor: type.color.toMaterialColor,
        surfaceLight: Colors.white,
        surfaceDark: Colors.black,
        borderSide: const BorderSide(
          color: Color(0xffEBEBEB),
          width: 1.5,
        ),
        constraints: const BoxConstraints(),
      );

  @override
  Color get iconColor => primaryColor;
}
