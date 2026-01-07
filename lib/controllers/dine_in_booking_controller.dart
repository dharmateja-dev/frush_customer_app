import 'package:customer/models/dine_in_booking_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:get/get.dart';

class DineInBookingController extends GetxController {
  RxBool isLoading = true.obs;

  RxBool isFeature = true.obs;

  RxList<DineInBookingModel> featureList = <DineInBookingModel>[].obs;
  RxList<DineInBookingModel> historyList = <DineInBookingModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getDineInBooking();
    super.onInit();
  }

  getDineInBooking() async {
    await FireStoreUtils.getDineInBooking(true).then(
      (value) {
        featureList.value = value;
      },
    );
    await FireStoreUtils.getDineInBooking(false).then(
      (value) {
        historyList.value = value;
      },
    );

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

