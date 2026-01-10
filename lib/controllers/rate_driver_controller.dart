import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/models/order_model.dart';
import 'package:customer/models/rating_model.dart';
import 'package:customer/models/user_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RateDriverController extends GetxController {
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  Rx<TextEditingController> commentController = TextEditingController().obs;

  Rx<OrderModel> orderModel = OrderModel().obs;
  Rx<UserModel> driverModel = UserModel().obs;
  Rx<RatingModel> ratingModel = RatingModel().obs;

  RxDouble ratings = 0.0.obs;

  getArgument() async {
    dynamic argumentData = Get.arguments;
    if (argumentData != null) {
      orderModel.value = argumentData['orderModel'];
      driverModel.value = argumentData['driverModel'];

      // Check if already rated
      // As per existing implementation logic, we might need a way to check existing review
      // For now, assuming new rating or we can implement getOrderReviewsByID equivalent
      // tailored for driver if needed.
      // However, looking at RateProductController, it checks existing review.
      // We can check if we have a rating for this order and driver.

      // Since we don't have a direct method `getDriverOrderReviewsByID` in FireStoreUtils yet,
      // we will skip pre-filling for now or assume it's a new rating.
      // If re-rating is a requirement, we would need to add a query.
    }
    isLoading.value = false;
  }

  saveRating() async {
    if (ratings.value != 0.0) {
      ShowToastDialog.showLoader("Please wait".tr);

      // Update Driver Review Stats
      // Note: We need to handle nulls safely
      double currentCount =
          double.tryParse(driverModel.value.reviewsCount.toString()) ?? 0.0;
      double currentSum =
          double.tryParse(driverModel.value.reviewsSum.toString()) ?? 0.0;

      driverModel.value.reviewsCount = currentCount + 1;
      driverModel.value.reviewsSum = currentSum + ratings.value;

      // Upload Images
      for (int i = 0; i < images.length; i++) {
        if (images[i].runtimeType == XFile) {
          String url = await Constant.uploadUserImageToFireStorage(
            File(images[i].path),
            "profileImage/${FireStoreUtils.getCurrentUid()}",
            File(images[i].path).path.split('/').last,
          );
          images.removeAt(i);
          images.insert(i, url);
        }
      }

      RatingModel ratingDriver = RatingModel(
        driverId: driverModel.value.id,
        comment: commentController.value.text,
        photos: images,
        rating: ratings.value,
        customerId: FireStoreUtils.getCurrentUid(),
        id: ratingModel.value.id ?? Constant.getUuid(),
        orderId: orderModel.value.id,
        createdAt: Timestamp.now(),
        uname: Constant.userModel!.fullName(),
        profile: Constant.userModel!.profilePictureURL,
      );

      await FireStoreUtils.setRatingModel(ratingDriver);
      await FireStoreUtils.updateUser(driverModel.value);

      ShowToastDialog.closeLoader();
      Get.back();
    } else {
      ShowToastDialog.showToast("Please add rating for driver.".tr);
    }
  }

  final ImagePicker _imagePicker = ImagePicker();
  RxList images = <dynamic>[].obs;

  Future pickFile({required ImageSource source}) async {
    try {
      XFile? image = await _imagePicker.pickImage(source: source);
      if (image == null) return;
      images.add(image);
      Get.back();
    } on PlatformException catch (e) {
      ShowToastDialog.showToast("Failed to Pick : \n $e");
    }
  }
}
