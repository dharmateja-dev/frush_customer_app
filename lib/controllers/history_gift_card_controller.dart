import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/models/gift_cards_order_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class HistoryGiftCardController extends GetxController {
  RxList<GiftCardsOrderModel> giftCardsOrderList = <GiftCardsOrderModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    await FireStoreUtils.getGiftHistory().then((value) {
      giftCardsOrderList.value = value;
    });
    isLoading.value = false;
  }

  updateList(int index) {
    GiftCardsOrderModel giftCardsOrderModel = giftCardsOrderList[index];
    giftCardsOrderModel.isPasswordShow = giftCardsOrderModel.isPasswordShow == true ? false : true;

    giftCardsOrderList.removeAt(index);
    giftCardsOrderList.insert(index, giftCardsOrderModel);
  }

  Future<void> share(String giftCode, String giftPin, String msg, String amount, Timestamp date) async {
    await Share.share(
      "${'Gift Code :'.tr} $giftCode\n${'Gift Pin :'.tr} $giftPin\n${'Price :'.tr} ${Constant.amountShow(amount: amount)}\n${'Expire Date :'.tr} ${date.toDate()}\n\n${'Message'.tr} : $msg",
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

