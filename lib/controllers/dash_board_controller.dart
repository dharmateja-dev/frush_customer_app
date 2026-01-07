import 'package:customer/app/favourite_screens/favourite_screen.dart';
import 'package:customer/app/home_screen/home_screen.dart';
import 'package:customer/app/home_screen/home_screen_two.dart';
import 'package:customer/app/order_list_screen/order_screen.dart';
import 'package:customer/app/profile_screen/profile_screen.dart';
import 'package:customer/app/wallet_screen/wallet_screen.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxList pageList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getTaxList();
    if (Constant.theme == "theme_2") {
      if (Constant.walletSetting == false) {
        pageList.value = [
          const HomeScreen(),
          const FavouriteScreen(),
          const OrderScreen(),
          const ProfileScreen(),
        ];
      } else {
        pageList.value = [
          const HomeScreen(),
          const FavouriteScreen(),
          const WalletScreen(),
          const OrderScreen(),
          const ProfileScreen(),
        ];
      }
    } else {
      if (Constant.walletSetting == false) {
        pageList.value = [
          const HomeScreenTwo(),
          const FavouriteScreen(),
          const OrderScreen(),
          const ProfileScreen(),
        ];
      } else {
        pageList.value = [
          const HomeScreenTwo(),
          const FavouriteScreen(),
          const WalletScreen(),
          const OrderScreen(),
          const ProfileScreen(),
        ];
      }
    }
    super.onInit();
  }

  getTaxList() async {
    await FireStoreUtils.getTaxList().then(
      (value) {
        if (value != null) {
          Constant.taxList = value;
        }
      },
    );
  }

  DateTime? currentBackPressTime;
  RxBool canPopNow = false.obs;
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

