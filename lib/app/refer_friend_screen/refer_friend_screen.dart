import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/controllers/refer_friend_controller.dart';
import 'package:customer/themes/app_them_data.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/themes/round_button_fill.dart';
import 'package:customer/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ReferFriendScreen extends StatelessWidget {
  const ReferFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX(
        init: ReferFriendController(),
        builder: (controller) {
          return Scaffold(
            body: controller.isLoading.value
                ? Constant.loader()
                : Container(
                    width: Responsive.width(100, context),
                    height: Responsive.height(100, context),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).viewPadding.top),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: AppThemeData.grey50,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 60,
                                ),
                                Center(
                                  child: Image.asset("assets/images/refer.png"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Refer your friend and earn".tr,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: themeChange.getThem()
                                        ? AppThemeData.surfaceDark
                                        : AppThemeData.surfaceDark,
                                    fontFamily: AppThemeData.regular,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${Constant.amountShow(amount: Constant.referralAmount)} ${'Each🎉'.tr}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: themeChange.getThem()
                                        ? AppThemeData.surfaceDark
                                        : AppThemeData.surfaceDark,
                                    fontFamily: AppThemeData.semiBold,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  "Invite Friends & Businesses".tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: themeChange.getThem()
                                        ? AppThemeData.surfaceDark
                                        : AppThemeData.surfaceDark,
                                    fontFamily: AppThemeData.semiBold,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${'Invite your friends to sign up with Frush using your code, and you’ll earn'.tr} ${Constant.amountShow(amount: Constant.referralAmount)} ${'after their Success the first order! 💸🍔'.tr}"
                                      .tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: themeChange.getThem()
                                        ? AppThemeData.surfaceDark
                                        : AppThemeData.surfaceDark,
                                    fontFamily: AppThemeData.regular,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: AppThemeData.primary300,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          controller
                                              .referralModel.value.referralCode
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: themeChange.getThem()
                                                ? AppThemeData.grey50
                                                : AppThemeData.grey50,
                                            fontFamily: AppThemeData.semiBold,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: controller.referralModel
                                                      .value.referralCode
                                                      .toString()));
                                              ShowToastDialog.showToast(
                                                  "Copied".tr);
                                            },
                                            child: const Icon(
                                              Icons.copy,
                                              color: AppThemeData.grey50,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          thickness: 1,
                                          color: themeChange.getThem()
                                              ? AppThemeData.surfaceDark
                                              : AppThemeData.surfaceDark,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 30),
                                        child: Text(
                                          "or".tr,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: themeChange.getThem()
                                                ? AppThemeData.surfaceDark
                                                : AppThemeData.surfaceDark,
                                            fontSize: 12,
                                            fontFamily: AppThemeData.medium,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: themeChange.getThem()
                                              ? AppThemeData.surfaceDark
                                              : AppThemeData.surfaceDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RoundedButtonFill(
                                  title: "Share Code".tr,
                                  width: 55,
                                  color: AppThemeData.primary300,
                                  textColor: AppThemeData.grey50,
                                  onPress: () async {
                                    await Share.share(
                                      "${"Hey there, thanks for choosing Frush. Hope you love our product. If you do, share it with your friends using code".tr} ${controller.referralModel.value.referralCode.toString()} ${"and get".tr}${Constant.amountShow(amount: Constant.referralAmount.toString())} ${"when order completed".tr}",
                                    );
                                  },
                                ),
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

