import 'dart:io';

import 'package:customer/app/auth_screen/login_screen.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/controllers/login_controller.dart';
import 'package:customer/themes/app_them_data.dart';
import 'package:customer/themes/round_button_fill.dart';
import 'package:customer/utils/SelectedItemWidget.dart';
import 'package:customer/utils/dark_theme_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isAcceptedTc = false;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetBuilder(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeChange.getThem()
                  ? AppThemeData.surfaceDark
                  : AppThemeData.surface,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*  Text(
                        "Create an Account 🚀".tr,
                        style: TextStyle(color: themeChange.getThem() ? AppThemeData.grey50 : AppThemeData.grey900, fontSize: 22, fontFamily: AppThemeData.semiBold),
                      ),
                      Text(
                        "Sign up to start your food adventure with Sameats".tr,
                        style: TextStyle(color: themeChange.getThem() ? AppThemeData.grey400 : AppThemeData.grey500, fontSize: 16, fontFamily: AppThemeData.regular),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              title: 'First Name'.tr,
                              controller: controller.firstNameEditingController.value,
                              hintText: 'Enter First Name'.tr,
                              prefix: Padding(
                                padding: const EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  "assets/icons/ic_user.svg",
                                  colorFilter: ColorFilter.mode(
                                    themeChange.getThem() ? AppThemeData.grey300 : AppThemeData.grey600,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFieldWidget(
                              title: 'Last Name'.tr,
                              controller: controller.lastNameEditingController.value,
                              hintText: 'Enter Last Name'.tr,
                              prefix: Padding(
                                padding: const EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  "assets/icons/ic_user.svg",
                                  colorFilter: ColorFilter.mode(
                                    themeChange.getThem() ? AppThemeData.grey300 : AppThemeData.grey600,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFieldWidget(
                        title: 'Email Address'.tr,
                        textInputType: TextInputType.emailAddress,
                        controller: controller.emailEditingController.value,
                        enable: controller.type.value == "google" || controller.type.value == "apple" ? false : true,
                        hintText: 'Enter Email Address'.tr,
                        prefix: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            "assets/icons/ic_mail.svg",
                            colorFilter: ColorFilter.mode(
                              themeChange.getThem() ? AppThemeData.grey300 : AppThemeData.grey600,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      TextFieldWidget(
                        title: 'Phone Number'.tr,
                        controller: controller.phoneNUmberEditingController.value,
                        hintText: 'Enter Phone Number'.tr,
                        enable: controller.type.value == "mobileNumber" ? false : true,
                        textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        prefix: CountryCodePicker(
                          enabled: controller.type.value == "mobileNumber" ? false : true,
                          onChanged: (value) {
                            controller.countryCodeEditingController.value.text = value.dialCode.toString();
                          },
                          dialogTextStyle:
                              TextStyle(color: themeChange.getThem() ? AppThemeData.grey50 : AppThemeData.grey900, fontWeight: FontWeight.w500, fontFamily: AppThemeData.medium),
                          dialogBackgroundColor: themeChange.getThem() ? AppThemeData.grey800 : AppThemeData.grey100,
                          initialSelection: controller.countryCodeEditingController.value.text,
                          comparator: (a, b) => b.name!.compareTo(a.name.toString()),
                          textStyle: TextStyle(fontSize: 14, color: themeChange.getThem() ? AppThemeData.grey50 : AppThemeData.grey900, fontFamily: AppThemeData.medium),
                          searchDecoration: InputDecoration(iconColor: themeChange.getThem() ? AppThemeData.grey50 : AppThemeData.grey900),
                          searchStyle:
                              TextStyle(color: themeChange.getThem() ? AppThemeData.grey50 : AppThemeData.grey900, fontWeight: FontWeight.w500, fontFamily: AppThemeData.medium),
                        ),
                      ),
                      controller.type.value == "google" || controller.type.value == "apple" || controller.type.value == "mobileNumber"
                          ? const SizedBox()
                          : Column(
                              children: [
                                TextFieldWidget(
                                  title: 'Password'.tr,
                                  controller: controller.passwordEditingController.value,
                                  hintText: 'Enter Password'.tr,
                                  obscureText: controller.passwordVisible.value,
                                  prefix: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(
                                      "assets/icons/ic_lock.svg",
                                      colorFilter: ColorFilter.mode(
                                        themeChange.getThem() ? AppThemeData.grey300 : AppThemeData.grey600,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: InkWell(
                                        onTap: () {
                                          controller.passwordVisible.value = !controller.passwordVisible.value;
                                        },
                                        child: controller.passwordVisible.value
                                            ? SvgPicture.asset(
                                                "assets/icons/ic_password_show.svg",
                                                colorFilter: ColorFilter.mode(
                                                  themeChange.getThem() ? AppThemeData.grey300 : AppThemeData.grey600,
                                                  BlendMode.srcIn,
                                                ),
                                              )
                                            : SvgPicture.asset(
                                                "assets/icons/ic_password_close.svg",
                                                colorFilter: ColorFilter.mode(
                                                  themeChange.getThem() ? AppThemeData.grey300 : AppThemeData.grey600,
                                                  BlendMode.srcIn,
                                                ),
                                              )),
                                  ),
                                ),
                                TextFieldWidget(
                                  title: 'Confirm Password'.tr,
                                  controller: controller.conformPasswordEditingController.value,
                                  hintText: 'Enter Confirm Password'.tr,
                                  obscureText: controller.conformPasswordVisible.value,
                                  prefix: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(
                                      "assets/icons/ic_lock.svg",
                                      colorFilter: ColorFilter.mode(
                                        themeChange.getThem() ? AppThemeData.grey300 : AppThemeData.grey600,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  suffix: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: InkWell(
                                        onTap: () {
                                          controller.conformPasswordVisible.value = !controller.conformPasswordVisible.value;
                                        },
                                        child: controller.conformPasswordVisible.value
                                            ? SvgPicture.asset(
                                                "assets/icons/ic_password_show.svg",
                                                colorFilter: ColorFilter.mode(
                                                  themeChange.getThem() ? AppThemeData.grey300 : AppThemeData.grey600,
                                                  BlendMode.srcIn,
                                                ),
                                              )
                                            : SvgPicture.asset(
                                                "assets/icons/ic_password_close.svg",
                                                colorFilter: ColorFilter.mode(
                                                  themeChange.getThem() ? AppThemeData.grey300 : AppThemeData.grey600,
                                                  BlendMode.srcIn,
                                                ),
                                              )),
                                  ),
                                ),
                              ],
                            ),
                      TextFieldWidget(
                        title: 'Referral Code(Optional)'.tr,
                        controller: controller.referralCodeEditingController.value,
                        hintText: 'Referral Code(Optional)'.tr,
                      ),
                      RoundedButtonFill(
                        title: "Signup".tr,
                        color: AppThemeData.primary300,
                        textColor: AppThemeData.grey50,
                        onPress: () async {
                          if (controller.type.value == "google" || controller.type.value == "apple" || controller.type.value == "mobileNumber") {
                            if (controller.firstNameEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter first name".tr);
                            } else if (controller.lastNameEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter last name".tr);
                            } else if (controller.emailEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter valid email".tr);
                            } else if (controller.phoneNUmberEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter Phone number".tr);
                            } else {
                              controller.signUpWithEmailAndPassword();
                            }
                          } else {
                            if (controller.firstNameEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter first name".tr);
                            } else if (controller.lastNameEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter last name".tr);
                            } else if (controller.emailEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter valid email".tr);
                            } else if (controller.phoneNUmberEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter Phone number".tr);
                            } else if (controller.passwordEditingController.value.text.trim().length < 6) {
                              ShowToastDialog.showToast("Please enter minimum 6 characters password".tr);
                            } else if (controller.passwordEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter password".tr);
                            } else if (controller.conformPasswordEditingController.value.text.trim().isEmpty) {
                              ShowToastDialog.showToast("Please enter Confirm password".tr);
                            } else if (controller.passwordEditingController.value.text.trim() != controller.conformPasswordEditingController.value.text.trim()) {
                              ShowToastDialog.showToast("Password and Confirm password doesn't match".tr);
                            } else {
                              controller.signUpWithEmailAndPassword();
                            }
                          }
                        },
                      ),*/

                      Image.asset("assets/images/ic_logo.png"),
                      Text(
                        "Welcome to Frush",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Signup",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      Divider(
                        color: Color(0xff83CB4D),
                        indent: 120,
                        endIndent: 120,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundedButtonFill(
                              title: "Sign up with Google".tr,
                              textColor: themeChange.getThem()
                                  ? AppThemeData.grey100
                                  : AppThemeData.grey900,
                              color: themeChange.getThem()
                                  ? AppThemeData.grey900
                                  : AppThemeData.grey100,
                              icon: SvgPicture.asset(
                                  "assets/icons/ic_google.svg"),
                              isRight: false,
                              onPress: () async {
                                if (!isAcceptedTc) {
                                  ShowToastDialog.showToast(
                                      "Please agree to the Terms and Privacy Policy");
                                } else {
                                  controller.loginWithGoogle();
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Platform.isIOS
                              ? Expanded(
                                  child: RoundedButtonFill(
                                    title: "with Apple".tr,
                                    textColor: themeChange.getThem()
                                        ? AppThemeData.grey100
                                        : AppThemeData.grey900,
                                    color: themeChange.getThem()
                                        ? AppThemeData.grey900
                                        : AppThemeData.grey100,
                                    icon: SvgPicture.asset(
                                        "assets/icons/ic_apple.svg"),
                                    isRight: false,
                                    onPress: () async {
                                      controller.loginWithApple();
                                    },
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Already have an account?'.tr,
                                style: TextStyle(
                                  color: themeChange.getThem()
                                      ? AppThemeData.grey50
                                      : AppThemeData.grey900,
                                  fontFamily: AppThemeData.medium,
                                  fontWeight: FontWeight.w500,
                                )),
                            const WidgetSpan(
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(const LoginScreen());
                                  },
                                text: 'Sign In'.tr,
                                style: TextStyle(
                                    color: AppThemeData.primary300,
                                    fontFamily: AppThemeData.bold,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppThemeData.primary300)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectedItemWidget(
                            isSelected: isAcceptedTc,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Color(0xff83CB4D)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            onTap: () {
                              setState(() {
                                isAcceptedTc = !isAcceptedTc;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "I agree to your",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: " Terms",
                                style: TextStyle(color: Color(0xff83CB4D))),
                            TextSpan(
                                text: " and ",
                                style: TextStyle(color: Color(0xff83CB4D))),
                            TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(color: Color(0xff83CB4D))),
                          ]))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

/*******************************************************************************************
* Copyright (c) 2025 Movenetics Digital. All rights reserved.
*
* This software and associated documentation files are the property of 
* Movenetics Digital. Unauthorized copying, modification, distribution, or use of this 
* Software, via any medium, is strictly prohibited without prior written permission.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
* INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
* PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
* LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
* OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
* OTHER DEALINGS IN THE SOFTWARE.
*
* Company: Movenetics Digital
* Author: Aman Bhandari 
*******************************************************************************************/

