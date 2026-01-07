import 'dart:async';
import 'dart:developer';

import 'package:customer/app/auth_screen/login_screen.dart';
import 'package:customer/app/dash_board_screens/dash_board_screen.dart';
import 'package:customer/app/location_permission_screen/location_permission_screen.dart';
import 'package:customer/app/on_boarding_screen.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/models/user_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:customer/utils/notification_service.dart';
import 'package:customer/utils/preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () => redirectScreen());
    super.onInit();
  }

  redirectScreen() async {
    if (Preferencess.getBoolean(Preferencess.isFinishOnBoardingKey) == false) {
      Get.offAll(const OnBoardingScreen());
    } else {
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        await FireStoreUtils.getUserProfile(firebaseUser.uid)
            .then((value) async {
          if (value != null) {
            UserModel userModel = value;
            log(userModel.toJson().toString());
            if (userModel.role == Constant.userRoleCustomer) {
              if (userModel.active == true) {
                userModel.fcmToken = await NotificationService.getToken();
                await FireStoreUtils.updateUser(userModel);
                if (userModel.shippingAddress != null &&
                    userModel.shippingAddress!.isNotEmpty) {
                  if (userModel.shippingAddress!
                      .where((element) => element.isDefault == true)
                      .isNotEmpty) {
                    Constant.selectedLocation = userModel.shippingAddress!
                        .where((element) => element.isDefault == true)
                        .single;
                  } else {
                    Constant.selectedLocation =
                        userModel.shippingAddress!.first;
                  }
                  Get.offAll(const DashBoardScreen());
                } else {
                  Get.offAll(const LocationPermissionScreen());
                }
              } else {
                await FirebaseAuth.instance.signOut();
                Get.offAll(const LoginScreen());
              }
            } else {
              await FirebaseAuth.instance.signOut();
              Get.offAll(const LoginScreen());
            }
          } else {
            // ❗ Instead of signOut directly, allow user to continue or show error
            log("User profile not found, but user is signed in");
            // You can optionally create a new profile here if needed
            Get.offAll(const LoginScreen());
          }
        });
      } else {
        Get.offAll(const LoginScreen());
      }
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
