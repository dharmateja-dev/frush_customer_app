import 'package:customer/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationController extends GetxController {
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> referralCodeController =
      TextEditingController().obs;

  Rx<UserModel> userModel = UserModel().obs;
  RxString countryCode = "+91".obs;
  RxString loginType = "".obs;

  @override
  void onInit() {
    super.onInit();

    // Get user data from arguments
    if (Get.arguments != null && Get.arguments['userModel'] != null) {
      userModel.value = Get.arguments['userModel'];

      // Pre-fill form fields from Google data
      firstNameController.value.text = userModel.value.firstName ?? '';
      lastNameController.value.text = userModel.value.lastName ?? '';
      emailController.value.text = userModel.value.email ?? '';

      // Handle phone number if exists
      String phoneWithCode = userModel.value.phoneNumber ?? '';
      String userCountryCode = userModel.value.countryCode ?? '+91';

      if (phoneWithCode.isNotEmpty) {
        // Remove country code from phone number if it's included
        if (phoneWithCode.startsWith(userCountryCode)) {
          phoneNumberController.value.text =
              phoneWithCode.substring(userCountryCode.length);
        } else if (phoneWithCode.startsWith('+')) {
          // Handle cases where country code might be different format
          phoneNumberController.value.text =
              phoneWithCode.replaceFirst(RegExp(r'^\+\d+'), '');
        } else {
          phoneNumberController.value.text = phoneWithCode;
        }
        countryCode.value = userCountryCode;
      }

      // Set login type
      loginType.value = userModel.value.provider ?? '';
    }
  }

  @override
  void onClose() {
    firstNameController.value.dispose();
    lastNameController.value.dispose();
    emailController.value.dispose();
    phoneNumberController.value.dispose();
    referralCodeController.value.dispose();
    super.onClose();
  }
}
