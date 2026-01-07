import 'dart:async';

import 'package:customer/models/order_model.dart';
import 'package:customer/services/database_helper.dart';
import 'package:get/get.dart';

class OrderPlacingController extends GetxController {
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getArgument();
    startTimer();
    super.onInit();
  }

  Rx<OrderModel> orderModel = OrderModel().obs;

  getArgument() async {
    DatabaseHelper.instance.deleteAllCartProducts();
    dynamic argumentData = Get.arguments;
    if (argumentData != null) {
      orderModel.value = argumentData['orderModel'];
    }
    isLoading.value = false;
    update();
  }

  Timer? timer;
  RxInt counter = 0.obs;

  RxBool isPlacing = false.obs;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter.value == 3) {
        timer.cancel();
        isPlacing.value = true;
      }
      counter++;
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

