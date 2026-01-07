import 'package:customer/constant/constant.dart';
import 'package:customer/models/cart_product_model.dart';
import 'package:customer/models/order_model.dart';
import 'package:customer/services/cart_provider.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxList<OrderModel> allList = <OrderModel>[].obs;
  RxList<OrderModel> inProgressList = <OrderModel>[].obs;
  RxList<OrderModel> deliveredList = <OrderModel>[].obs;
  RxList<OrderModel> rejectedList = <OrderModel>[].obs;
  RxList<OrderModel> cancelledList = <OrderModel>[].obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getOrder();
    super.onInit();
  }

  getOrder() async {
    if (Constant.userModel != null) {
      await FireStoreUtils.getAllOrder().then((value) {
        allList.value = value;

        rejectedList.value =
            allList.where((p0) => p0.status == Constant.orderRejected).toList();
        inProgressList.value = allList
            .where((p0) =>
                p0.status == Constant.orderAccepted ||
                p0.status == Constant.driverPending ||
                p0.status == Constant.orderShipped ||
                p0.status == Constant.orderInTransit)
            .toList();

        deliveredList.value = allList
            .where((p0) => p0.status == Constant.orderCompleted)
            .toList();
        cancelledList.value = allList
            .where((p0) => p0.status == Constant.orderCancelled)
            .toList();
      });
    }

    isLoading.value = false;
  }

  final CartProvider cartProvider = CartProvider();

  addToCart({required CartProductModel cartProductModel}) {
    cartProvider.addToCart(
        Get.context!, cartProductModel, cartProductModel.quantity!);
    update();
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

