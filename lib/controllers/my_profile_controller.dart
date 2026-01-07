import 'dart:developer';

import 'package:customer/constant/constant.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:customer/utils/preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyProfileController extends GetxController {
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getThem();
    super.onInit();
  }

  RxString isDarkMode = "Light".obs;
  RxBool isDarkModeSwitch = false.obs;

  getThem() {
    isDarkMode.value = Preferencess.getString(Preferencess.themKey);
    if (isDarkMode.value == "Dark") {
      isDarkModeSwitch.value = true;
    } else if (isDarkMode.value == "Light") {
      isDarkModeSwitch.value = false;
    } else {
      isDarkModeSwitch.value = false;
    }
    isLoading.value = false;
  }

  Future<bool> deleteUserFromServer() async {
    var url = '${Constant.websiteUrl}/api/delete-user';
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'uuid': FireStoreUtils.getCurrentUid(),
        },
      );
      log("deleteUserFromServer :: ${response.body}");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
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
