import 'package:customer/themes/app_them_data.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ButtonThem {
  const ButtonThem({Key? key});

  static buildButton(
    BuildContext context, {
    required String title,
    double btnHeight = 48,
    double txtSize = 14,
    double btnWidthRatio = 0.9,
    double btnRadius = 8,
    Color? btnColor,
    Color? txtColor,
    required Function()? onPress,
    bool isVisible = true,
    bool isLoading = false,
  }) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Visibility(
      visible: isVisible,
      child: SizedBox(
        width: Responsive.width(100, context) * btnWidthRatio,
        child: MaterialButton(
          onPressed: isLoading ? null : onPress,
          height: btnHeight,
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnRadius),
          ),
          color: btnColor ??
              (themeChange.getThem()
                  ? AppThemeData.primary300
                  : AppThemeData.primary300),
          disabledColor: (btnColor ?? AppThemeData.primary300).withOpacity(0.6),
          child: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      txtColor ?? AppThemeData.grey50,
                    ),
                  ),
                )
              : Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                    color: txtColor ?? AppThemeData.grey50,
                    fontSize: txtSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  static buildBorderButton(
    BuildContext context, {
    required String title,
    double btnHeight = 48,
    double txtSize = 14,
    double btnWidthRatio = 0.9,
    double borderRadius = 8,
    Color? borderColor,
    Color? txtColor,
    required Function() onPress,
    bool isVisible = true,
    bool iconVisibility = false,
    String iconAssetImage = '',
  }) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Visibility(
      visible: isVisible,
      child: SizedBox(
        width: Responsive.width(100, context) * btnWidthRatio,
        height: btnHeight,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              themeChange.getThem()
                  ? AppThemeData.surfaceDark
                  : AppThemeData.surface,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              txtColor ??
                  (themeChange.getThem()
                      ? AppThemeData.grey50
                      : AppThemeData.grey900),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                  color: borderColor ??
                      (themeChange.getThem()
                          ? AppThemeData.primary300
                          : AppThemeData.primary300),
                  width: 1.5,
                ),
              ),
            ),
          ),
          onPressed: onPress,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: iconVisibility,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    iconAssetImage,
                    fit: BoxFit.cover,
                    width: 32,
                  ),
                ),
              ),
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  color: txtColor ??
                      (themeChange.getThem()
                          ? AppThemeData.grey50
                          : AppThemeData.grey900),
                  fontSize: txtSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static roundButton(
    BuildContext context, {
    required String title,
    required Color btnColor,
    required Color txtColor,
    double btnHeight = 48,
    double txtSize = 14,
    double btnWidthRatio = 0.9,
    required Function() onPress,
    bool isVisible = true,
  }) {
    return Visibility(
      visible: isVisible,
      child: SizedBox(
        width: Responsive.width(100, context) * btnWidthRatio,
        child: MaterialButton(
          onPressed: onPress,
          height: btnHeight,
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: btnColor,
          child: Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              color: txtColor,
              fontSize: txtSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
