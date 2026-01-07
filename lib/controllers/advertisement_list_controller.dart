import 'package:customer/constant/constant.dart';
import 'package:customer/models/advertisement_model.dart';
import 'package:customer/models/favourite_model.dart';
import 'package:customer/models/vendor_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:get/get.dart';

class AdvertisementListController extends GetxController {
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getAdvertisementList();
    getFavouriteRestaurant();
    super.onInit();
  }

  RxList<AdvertisementModel> advertisementList = <AdvertisementModel>[].obs;

  getAdvertisementList() async {
    advertisementList.clear();
    List<VendorModel> allNearestRestaurant = <VendorModel>[];
    FireStoreUtils.getAllNearestRestaurant().listen((event) async {
      allNearestRestaurant.addAll(event);
      await FireStoreUtils.getAllAdvertisement().then((value) {
        List<AdvertisementModel> adsList = value;
        advertisementList.addAll(
          adsList.where((ads) => allNearestRestaurant.any((restaurant) => restaurant.id == ads.vendorId)),
        );
      });
      isLoading.value = false;
    });
  }

  RxList<FavouriteModel> favouriteList = <FavouriteModel>[].obs;

  getFavouriteRestaurant() async {
    if (Constant.userModel != null) {
      await FireStoreUtils.getFavouriteRestaurant().then(
        (value) {
          favouriteList.value = value;
        },
      );
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

