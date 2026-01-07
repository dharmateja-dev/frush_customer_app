import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:customer/app/location_permission_screen/location_permission_screen.dart';
import 'package:customer/constant/collection_name.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/controllers/information_controller.dart';
import 'package:customer/themes/app_them_data.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/text_field_them.dart';
// Preferences import removed (unused)
import 'package:customer/utils/dark_theme_provider.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:customer/models/referral_model.dart';
import 'package:customer/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double tabletBreakpoint = 600;
    const double tabletWidthFactor = 0.8;
    // const double tabletImageScale = 0.7; // unused, removed
    const double tabletFontScale = 1.2;
    const double tabletFieldScale = 1.1;
    const double tabletSpacingScale = 1.5;

    final themeChange = Provider.of<DarkThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > tabletBreakpoint;

    return GetX<InformationController>(
      init: InformationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: themeChange.getThem()
              ? AppThemeData.surfaceDark
              : AppThemeData.surface,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Content Section
                  Center(
                    child: Container(
                      width: isTablet
                          ? screenWidth * tabletWidthFactor
                          : screenWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 40 : 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Padding(
                              padding: EdgeInsets.only(
                                top: isTablet ? 20 * tabletSpacingScale : 10,
                              ),
                              child: Text(
                                "Complete Your Profile".tr,
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  fontSize:
                                      isTablet ? 18 * tabletFontScale : 18,
                                  color: themeChange.getThem()
                                      ? AppThemeData.grey50
                                      : AppThemeData.grey900,
                                ),
                              ),
                            ),

                            // Subtitle
                            Padding(
                              padding: EdgeInsets.only(
                                top: isTablet ? 8 : 4,
                              ),
                              child: Text(
                                "Please provide additional information to continue"
                                    .tr,
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                      isTablet ? 14 * tabletFontScale : 14,
                                  color: themeChange.getThem()
                                      ? AppThemeData.grey400
                                      : AppThemeData.grey600,
                                ),
                              ),
                            ),

                            SizedBox(
                                height:
                                    isTablet ? 20 * tabletSpacingScale : 20),

                            // Form Fields Section
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  // First Name Field
                                  TextFieldThem.buildTextFiled(
                                    context,
                                    hintText: 'First name'.tr,
                                    controller:
                                        controller.firstNameController.value,
                                    enable:
                                        controller.loginType.value == 'google'
                                            ? false
                                            : true,
                                  ),

                                  SizedBox(
                                      height: isTablet
                                          ? 10 * tabletSpacingScale
                                          : 10),

                                  // Last Name Field
                                  TextFieldThem.buildTextFiled(
                                    context,
                                    hintText: 'Last name'.tr,
                                    controller:
                                        controller.lastNameController.value,
                                    enable:
                                        controller.loginType.value == 'google'
                                            ? false
                                            : true,
                                  ),

                                  SizedBox(
                                      height: isTablet
                                          ? 10 * tabletSpacingScale
                                          : 10),

                                  // Email Field
                                  TextFieldThem.buildTextFiled(
                                    context,
                                    hintText: 'Email'.tr,
                                    controller:
                                        controller.emailController.value,
                                    enable:
                                        controller.loginType.value == 'google'
                                            ? false
                                            : true,
                                  ),

                                  SizedBox(
                                      height: isTablet
                                          ? 10 * tabletSpacingScale
                                          : 10),

                                  // Phone Number Field with Country Code
                                  TextFormField(
                                    maxLength: 15,
                                    validator: (value) =>
                                        value != null && value.isNotEmpty
                                            ? null
                                            : 'Required',
                                    keyboardType: TextInputType.number,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller:
                                        controller.phoneNumberController.value,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.urbanist(
                                      fontSize:
                                          isTablet ? 14 * tabletFontScale : 14,
                                      color: themeChange.getThem()
                                          ? AppThemeData.grey50
                                          : AppThemeData.grey900,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor: themeChange.getThem()
                                          ? AppThemeData.grey800
                                          : AppThemeData.grey50,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: isTablet
                                            ? 12 * tabletFieldScale
                                            : 12,
                                      ),
                                      prefixIcon: SizedBox(
                                        width: isTablet ? 120 : 100,
                                        child: CountryCodePicker(
                                          onChanged: (value) {
                                            controller.countryCode.value =
                                                value.dialCode.toString();
                                          },
                                          dialogBackgroundColor:
                                              themeChange.getThem()
                                                  ? AppThemeData.surfaceDark
                                                  : AppThemeData.surface,
                                          initialSelection:
                                              controller.countryCode.value,
                                          comparator: (a, b) => b.name!
                                              .compareTo(a.name.toString()),
                                          flagDecoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2)),
                                          ),
                                          textStyle: GoogleFonts.urbanist(
                                            fontSize: isTablet
                                                ? 14 * tabletFontScale
                                                : 14,
                                            color: themeChange.getThem()
                                                ? AppThemeData.grey50
                                                : AppThemeData.grey900,
                                          ),
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                          color: themeChange.getThem()
                                              ? AppThemeData.grey700
                                              : AppThemeData.grey300,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                          color: AppThemeData.primary300,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                          color: themeChange.getThem()
                                              ? AppThemeData.grey700
                                              : AppThemeData.grey300,
                                          width: 1,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                          color: AppThemeData.danger300,
                                          width: 1,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                          color: themeChange.getThem()
                                              ? AppThemeData.grey700
                                              : AppThemeData.grey300,
                                          width: 1,
                                        ),
                                      ),
                                      hintText: "Phone number".tr,
                                      hintStyle: GoogleFonts.urbanist(
                                        fontSize: isTablet
                                            ? 14 * tabletFontScale
                                            : 14,
                                        color: themeChange.getThem()
                                            ? AppThemeData.grey500
                                            : AppThemeData.grey400,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                      height: isTablet
                                          ? 10 * tabletSpacingScale
                                          : 10),

                                  // Referral Code Field
                                  TextFieldThem.buildTextFiled(
                                    context,
                                    hintText: 'Referral Code (Optional)'.tr,
                                    controller:
                                        controller.referralCodeController.value,
                                    enable: true,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                                height:
                                    isTablet ? 60 * tabletSpacingScale : 60),

                            // Continue Button
                            Center(
                              child: Container(
                                width: isTablet ? 300 : double.infinity,
                                child: ButtonThem.buildButton(
                                  context,
                                  title: "Continue".tr,
                                  btnColor: AppThemeData.primary300,
                                  txtColor: AppThemeData.grey50,
                                  onPress: () async {
                                    if (controller.firstNameController.value
                                        .text.isEmpty) {
                                      ShowToastDialog.showToast(
                                          "Please enter first name".tr);
                                    } else if (controller.lastNameController
                                        .value.text.isEmpty) {
                                      ShowToastDialog.showToast(
                                          "Please enter last name".tr);
                                    } else if (controller
                                        .emailController.value.text.isEmpty) {
                                      ShowToastDialog.showToast(
                                          "Please enter email".tr);
                                    } else if (controller.phoneNumberController
                                        .value.text.isEmpty) {
                                      ShowToastDialog.showToast(
                                          "Please enter phone number".tr);
                                    } else {
                                      ShowToastDialog.showLoader(
                                          "Please wait".tr);

                                      // Update user model with form data
                                      controller.userModel.value.firstName =
                                          controller
                                              .firstNameController.value.text;
                                      controller.userModel.value.lastName =
                                          controller
                                              .lastNameController.value.text;
                                      controller.userModel.value.email =
                                          controller.emailController.value.text;
                                      controller.userModel.value.countryCode =
                                          controller.countryCode.value;
                                      controller.userModel.value.phoneNumber =
                                          controller
                                              .phoneNumberController.value.text;
                                      controller.userModel.value.active = true;
                                      controller.userModel.value.createdAt =
                                          Timestamp.now();

                                      // Handle referral code if provided
                                      if (controller.referralCodeController
                                          .value.text.isNotEmpty) {
                                        String referralCode = controller
                                            .referralCodeController.value.text
                                            .trim();

                                        try {
                                          // Validate and process referral code
                                          QuerySnapshot referralQuery =
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      CollectionName.referral)
                                                  .where('referralCode',
                                                      isEqualTo: referralCode)
                                                  .limit(1)
                                                  .get();

                                          if (referralQuery.docs.isNotEmpty) {
                                            // Valid referral code found
                                            String referrerId =
                                                referralQuery.docs.first.id;

                                            // Update current user's referral document with referredBy
                                            await FirebaseFirestore.instance
                                                .collection(
                                                    CollectionName.referral)
                                                .doc(controller
                                                    .userModel.value.id)
                                                .set({
                                              'referralBy': referrerId,
                                            }, SetOptions(merge: true));

                                            print(
                                                "Referral code applied: $referralCode by user: $referrerId");
                                          } else {
                                            print(
                                                "Invalid referral code: $referralCode");
                                          }
                                        } catch (e) {
                                          print(
                                              "Error processing referral code: $e");
                                        }
                                      }

                                      // Save to Firestore
                                      await FireStoreUtils.updateUser(
                                              controller.userModel.value)
                                          .then((value) async {
                                        if (value == true) {
                                          await Preferencess.saveUserData(
                                              controller.userModel.value);

                                          // Update current user
                                          FireStoreUtils.currentUser =
                                              controller.userModel.value;

                                          // Ensure the current user has a referral document
                                          // with a referralCode. Users who sign up via
                                          // external providers (Google/Apple) may not
                                          // have had a referral doc created during
                                          // the initial sign-up flow, so create one
                                          // here if needed.
                                          try {
                                            var existingReferral =
                                                await FireStoreUtils
                                                    .getReferralUserBy();

                                            if (existingReferral == null ||
                                                (existingReferral
                                                            .referralCode ==
                                                        null ||
                                                    existingReferral
                                                        .referralCode!
                                                        .isEmpty)) {
                                              ReferralModel ownReferralModel =
                                                  ReferralModel(
                                                      id: FireStoreUtils
                                                          .getCurrentUid(),
                                                      referralBy:
                                                          existingReferral
                                                                  ?.referralBy ??
                                                              "",
                                                      referralCode: Constant
                                                          .getReferralCode());

                                              await FireStoreUtils.referralAdd(
                                                  ownReferralModel);
                                            }
                                          } catch (e) {
                                            print(
                                                "Error ensuring referral doc: $e");
                                          }

                                          ShowToastDialog.closeLoader();
                                          ShowToastDialog.showToast(
                                              "Profile completed successfully!"
                                                  .tr);

                                          // Navigate to location screen
                                          Get.offAll(
                                              const LocationPermissionScreen());
                                        } else {
                                          ShowToastDialog.closeLoader();
                                          ShowToastDialog.showToast(
                                              "Failed to save information. Please try again.");
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),

                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
