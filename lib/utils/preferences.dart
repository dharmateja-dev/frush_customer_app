import 'dart:convert';

import 'package:customer/constant/constant.dart';
import 'package:customer/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferencess {
  static const languageCodeKey = "languageCodeKey";
  static const isFinishOnBoardingKey = "isFinishOnBoardingKey";
  static const foodDeliveryType = "foodDeliveryType";

  static const themKey = "themKey";

  static const payFastSettings = "payFastSettings";
  static const mercadoPago = "MercadoPago";
  static const paypalSettings = "paypalSettings";
  static const stripeSettings = "stripeSettings";
  static const flutterWave = "flutterWave";
  static const payStack = "payStack";
  static const paytmSettings = "PaytmSettings";
  static const walletSettings = "walletSettings";
  static const razorpaySettings = "razorpaySettings";
  static const codSettings = "CODSettings";
  static const midTransSettings = "midTransSettings";
  static const orangeMoneySettings = "orangeMoneySettings";
  static const xenditSettings = "xenditSettings";

  static late SharedPreferences pref;

  static initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  static bool getBoolean(String key) {
    return pref.getBool(key) ?? false;
  }

  static Future<void> setBoolean(String key, bool value) async {
    await pref.setBool(key, value);
  }

  static String getString(String key, {String? defaultValue}) {
    return pref.getString(key) ?? defaultValue ?? "";
  }

  static Future<void> setString(String key, String value) async {
    await pref.setString(key, value);
  }

  static int getInt(String key) {
    return pref.getInt(key) ?? 0;
  }

  static Future<void> setInt(String key, int value) async {
    await pref.setInt(key, value);
  }

  static Future<void> clearSharPreference() async {
    await pref.clear();
  }

  static Future<void> clearKeyData(String key) async {
    await pref.remove(key);
  }

  static Future<void> saveUserData(UserModel user) async {
    try {
      final String userJson = jsonEncode(user.toJson());
      await setString(Constant.userModelKey, userJson);
      await setBoolean(Constant.isLoggedInKey, true);
      await setString(Constant.userIdKey, user.id.toString());

      // Handle first name and last name
      String fullName = '';
      if (user.firstName != null && user.firstName!.isNotEmpty) {
        fullName = user.firstName!;
        if (user.lastName != null && user.lastName!.isNotEmpty) {
          fullName += ' ${user.lastName}';
        }
      }
      await setString(Constant.userNameKey, fullName);

      await setString(Constant.userEmailKey, user.email.toString());
      await setString(Constant.userImageKey, user.profilePictureURL.toString());
    } catch (e, s) {
      print('Error saving user data: $e');
    }
  }

  /// Retrieves the UserModel data from SharedPreferences.
  static UserModel? getUserData() {
    try {
      final String? userJson = pref.getString(Constant.userModelKey);
      if (userJson != null && userJson.isNotEmpty) {
        return UserModel.fromJson(jsonDecode(userJson));
      }
    } catch (e, s) {
      print('Error getting user data: $e');
    }
    return null;
  }

  /// Clears all user-specific data from SharedPreferences.
  static Future<void> clearUserData() async {
    await clearKeyData(Constant.userModelKey);
    await clearKeyData(Constant.isLoggedInKey);
    await clearKeyData(Constant.userIdKey);
    await clearKeyData(Constant.userNameKey);
    await clearKeyData(Constant.userEmailKey);
    await clearKeyData(Constant.userImageKey);
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
