import 'package:customer/themes/app_them_data.dart';
import 'package:customer/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TextFieldThem {
  const TextFieldThem({Key? key});

  static buildTextFiled(
    BuildContext context, {
    required String hintText,
    required TextEditingController controller,
    TextInputType keyBoardType = TextInputType.text,
    bool enable = true,
    bool readOnly = false,
    int maxLine = 1,
    List<TextInputFormatter>? inputFormatters,
    bool allowEmpty = false,
  }) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    if (!allowEmpty && controller.value == null) {
      controller.text = " ";
    }

    return TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        enabled: enable,
        readOnly: readOnly,
        keyboardType: keyBoardType,
        maxLines: maxLine,
        inputFormatters: inputFormatters,
        style: GoogleFonts.urbanist(
            color: themeChange.getThem()
                ? AppThemeData.grey50
                : AppThemeData.grey900),
        decoration: InputDecoration(
            filled: true,
            fillColor: themeChange.getThem()
                ? AppThemeData.grey800
                : AppThemeData.grey50,
            contentPadding: EdgeInsets.only(
                left: 16, right: 16, top: maxLine == 1 ? 16 : 10, bottom: 16),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: themeChange.getThem()
                      ? AppThemeData.grey700
                      : AppThemeData.grey300,
                  width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppThemeData.primary300, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: themeChange.getThem()
                      ? AppThemeData.grey700
                      : AppThemeData.grey300,
                  width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppThemeData.danger300, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: themeChange.getThem()
                      ? AppThemeData.grey700
                      : AppThemeData.grey300,
                  width: 1),
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.urbanist(
              color: themeChange.getThem()
                  ? AppThemeData.grey500
                  : AppThemeData.grey400,
            )));
  }

  static buildTextFiledWithPrefixIcon(
    BuildContext context, {
    required String hintText,
    required TextEditingController controller,
    required Widget prefix,
    TextInputType keyBoardType = TextInputType.text,
    bool enable = true,
    List<TextInputFormatter>? inputFormatters,
  }) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        enabled: enable,
        keyboardType: keyBoardType,
        inputFormatters: inputFormatters,
        style: GoogleFonts.urbanist(
            color: themeChange.getThem()
                ? AppThemeData.grey50
                : AppThemeData.grey900),
        decoration: InputDecoration(
            prefix: prefix,
            filled: true,
            fillColor: themeChange.getThem()
                ? AppThemeData.grey800
                : AppThemeData.grey50,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: themeChange.getThem()
                      ? AppThemeData.grey700
                      : AppThemeData.grey300,
                  width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppThemeData.primary300, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: themeChange.getThem()
                      ? AppThemeData.grey700
                      : AppThemeData.grey300,
                  width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppThemeData.danger300, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: themeChange.getThem()
                      ? AppThemeData.grey700
                      : AppThemeData.grey300,
                  width: 1),
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.urbanist(
              color: themeChange.getThem()
                  ? AppThemeData.grey500
                  : AppThemeData.grey400,
            )));
  }

  static buildTextFiledWithSuffixIcon(
    BuildContext context, {
    required String hintText,
    required TextEditingController controller,
    required Widget suffixIcon,
    TextInputType keyBoardType = TextInputType.text,
    bool enable = true,
  }) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return TextFormField(
        controller: controller,
        textAlign: TextAlign.start,
        enabled: enable,
        keyboardType: keyBoardType,
        style: GoogleFonts.urbanist(
            color: themeChange.getThem()
                ? AppThemeData.grey50
                : AppThemeData.grey900),
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: themeChange.getThem()
                ? AppThemeData.grey800
                : AppThemeData.grey50,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: themeChange.getThem()
                      ? AppThemeData.grey700
                      : AppThemeData.grey300,
                  width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppThemeData.primary300, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: themeChange.getThem()
                      ? AppThemeData.grey700
                      : AppThemeData.grey300,
                  width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: AppThemeData.danger300, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: themeChange.getThem()
                      ? AppThemeData.grey700
                      : AppThemeData.grey300,
                  width: 1),
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.urbanist(
              color: themeChange.getThem()
                  ? AppThemeData.grey500
                  : AppThemeData.grey400,
            )));
  }
}
