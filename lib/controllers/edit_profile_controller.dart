import 'dart:io';

import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/models/user_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<UserModel> userModel = UserModel().obs;

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> countryCodeController =
      TextEditingController(text: "+91").obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid())
        .then((value) {
      if (value != null) {
        userModel.value = value;
        firstNameController.value.text = userModel.value.firstName.toString();
        lastNameController.value.text = userModel.value.lastName.toString();
        emailController.value.text = userModel.value.email.toString();
        phoneNumberController.value.text =
            userModel.value.phoneNumber.toString();
        countryCodeController.value.text =
            userModel.value.countryCode.toString();
        profileImage.value = userModel.value.profilePictureURL ?? "";
      }
    });

    isLoading.value = false;
  }

  saveData() async {
    String firstName = firstNameController.value.text.trim();
    String lastName = lastNameController.value.text.trim();
    String phoneNumber = phoneNumberController.value.text.trim();

    if (firstName.isEmpty) {
      ShowToastDialog.showToast(
        "Please enter your first name".tr,
      );
      return;
    }

    if (lastName.isEmpty) {
      ShowToastDialog.showToast(
        "Please enter your last name".tr,
      );
      return;
    }

    if (phoneNumber.isEmpty) {
      ShowToastDialog.showToast(
        "Please enter your phone number".tr,
      );
      return;
    }

    if (phoneNumber.length != 10) {
      ShowToastDialog.showToast(
        "Please enter a valid 10-digit phone number".tr,
      );
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber)) {
      ShowToastDialog.showToast(
        "Phone number must contain only numbers".tr,
      );
      return;
    }

    ShowToastDialog.showLoader("Please wait".tr);

    try {
      if (Constant().hasValidUrl(profileImage.value) == false &&
          profileImage.value.isNotEmpty) {
        profileImage.value = await Constant.uploadUserImageToFireStorage(
          File(profileImage.value),
          "profileImage/${FireStoreUtils.getCurrentUid()}",
          File(profileImage.value).path.split('/').last,
        );
      }

      userModel.value.firstName = firstName;
      userModel.value.lastName = lastName;
      userModel.value.profilePictureURL = profileImage.value;
      userModel.value.phoneNumber = phoneNumber;

      await FireStoreUtils.updateUser(userModel.value).then((value) {
        ShowToastDialog.closeLoader();
        Get.back(result: true);
      });
    } catch (e) {
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast(
        "Failed to update profile. Please try again".tr,
      );
    }
  }

  final ImagePicker _imagePicker = ImagePicker();
  RxString profileImage = "".obs;

  Future pickFile({required ImageSource source}) async {
    try {
      XFile? image = await _imagePicker.pickImage(source: source);
      if (image == null) return;
      Get.back();
      profileImage.value = image.path;
    } on PlatformException catch (e) {
      ShowToastDialog.showToast("${"failed_to_pick".tr} : \n $e");
    }
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

