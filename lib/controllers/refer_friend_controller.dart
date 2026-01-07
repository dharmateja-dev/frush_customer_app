import 'package:customer/models/referral_model.dart';
import 'package:flutter/foundation.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:customer/constant/constant.dart';
import 'package:get/get.dart';

class ReferFriendController extends GetxController {
  Rx<ReferralModel> referralModel = ReferralModel().obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  getData() async {
    await FireStoreUtils.getReferralUserBy().then((value) async {
      if (value != null) {
        referralModel.value = value;
      } else {
        // If no referral doc exists, create one with a generated code
        ReferralModel ownReferralModel = ReferralModel(
            id: FireStoreUtils.getCurrentUid(),
            referralBy: "",
            referralCode: Constant.getReferralCode());
        await FireStoreUtils.referralAdd(ownReferralModel);
        debugPrint(
            'Referral document created for user: ${ownReferralModel.id} with code: ${ownReferralModel.referralCode}');
        referralModel.value = ownReferralModel;
      }
    });
    isLoading.value = false;
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
