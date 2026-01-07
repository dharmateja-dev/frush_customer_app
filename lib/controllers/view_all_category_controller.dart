import 'package:customer/constant/constant.dart';
import 'package:customer/models/vendor_category_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:get/get.dart';

class ViewAllCategoryController extends GetxController {
  RxBool isLoading = true.obs;

  RxList<VendorCategoryModel> vendorCategoryModel = <VendorCategoryModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getCategoryData();
    super.onInit();
  }

  getCategoryData() async {
    await FireStoreUtils.getVendorCategory().then(
      (value) {
        vendorCategoryModel.value = value;
      },
    );

    if (Constant.restaurantList != null) {
      List<String> usedCategoryIds = Constant.restaurantList!.expand((vendor) => vendor.categoryID ?? []).whereType<String>().toSet().toList();
      vendorCategoryModel.value = vendorCategoryModel.where((category) => usedCategoryIds.contains(category.id)).toList();
    }

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

