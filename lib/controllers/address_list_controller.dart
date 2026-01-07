import 'package:customer/models/user_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressListController extends GetxController {
  Rx<UserModel> userModel = UserModel().obs;

  RxList<ShippingAddress> shippingAddressList = <ShippingAddress>[].obs;

  List saveAsList = ['Home', 'Work', 'Hotel', 'other'].obs;
  RxString selectedSaveAs = "Home".obs;

  Rx<TextEditingController> houseBuildingTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> localityEditingController = TextEditingController().obs;
  Rx<TextEditingController> landmarkEditingController = TextEditingController().obs;
  Rx<UserLocation> location = UserLocation().obs;
  Rx<ShippingAddress> shippingModel = ShippingAddress().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getUser();
    super.onInit();
  }

  clearData() {
    shippingModel.value = ShippingAddress();
    houseBuildingTextEditingController.value.clear();
    localityEditingController.value.clear();
    landmarkEditingController.value.clear();
    location.value = UserLocation();
    selectedSaveAs.value = "Home".tr;
  }

  setData(ShippingAddress shippingAddress) {
    shippingModel.value = shippingAddress;
    houseBuildingTextEditingController.value.text = shippingAddress.address.toString();
    localityEditingController.value.text = shippingAddress.locality.toString();
    landmarkEditingController.value.text = shippingAddress.landmark.toString();
    selectedSaveAs.value = shippingAddress.addressAs.toString();
    location.value = shippingAddress.location!;
  }

  getUser() async {
    await FireStoreUtils.getUserProfile(FireStoreUtils.getCurrentUid()).then(
      (value) {
        if (value != null) {
          userModel.value = value;
          if (userModel.value.shippingAddress != null) {
            shippingAddressList.value = userModel.value.shippingAddress!;
          }
        }
      },
    );
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

