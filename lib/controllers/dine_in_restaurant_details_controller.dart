import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/app/dine_in_booking/dine_in_booking_screen.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/constant/send_notification.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/models/dine_in_booking_model.dart';
import 'package:customer/models/favourite_model.dart';
import 'package:customer/models/vendor_model.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DineInRestaurantDetailsController extends GetxController {
  static final Map<String, DateTime> _bookingCache = {};
  static const Duration _cacheDuration = Duration(minutes: 2);
  Rx<TextEditingController> searchEditingController =
      TextEditingController().obs;

  Rx<TextEditingController> additionRequestController =
      TextEditingController().obs;
  final isBooking = false.obs;
  RxBool isLoading = true.obs;
  RxBool firstVisit = false.obs;
  Rx<PageController> pageController = PageController().obs;
  RxInt currentPage = 0.obs;
  RxInt noOfQuantity = 1.obs;

  RxList<FavouriteModel> favouriteList = <FavouriteModel>[].obs;
  RxList tags = [].obs;

  List occasionList = ["Birthday", "Anniversary"];
  RxString selectedOccasion = "".obs;

  RxList<DateModel> dateList = <DateModel>[].obs;
  RxList<TimeModel> timeSlotList = <TimeModel>[].obs;

  Rx<Timestamp> selectedDate = Timestamp.now().obs;
  RxString selectedTimeSlot = '6:00 PM'.obs;

  RxString selectedTimeDiscount = '0'.obs;
  RxString selectedTimeDiscountType = ''.obs;

  @override
  void onInit() {
    getArgument();
    getRecord();
    super.onInit();
  }

  orderBook() async {
    if (isBooking.value) {
      ShowToastDialog.showToast("Booking in progress, please wait".tr);
      return;
    }

    isBooking.value = true;

    try {
      ShowToastDialog.showLoader("Please wait".tr);

      // Check if restaurant's dine-in service is active
      if (vendorModel.value.dineInActive != true) {
        ShowToastDialog.closeLoader();
        ShowToastDialog.showToast(
            "This restaurant's dine-in service is currently inactive. Please try again later."
                .tr);
        isBooking.value = false;
        return;
      }

      // Parse selected date and time
      DateTime dt = selectedDate.value.toDate();
      String hour = DateFormat("kk:mm").format(DateFormat('hh:mm a').parse(
          (Intl.getCurrentLocale() == "en_US")
              ? selectedTimeSlot.value
              : selectedTimeSlot.value.toLowerCase()));
      dt = DateTime(dt.year, dt.month, dt.day, int.parse(hour.split(":")[0]),
          int.parse(hour.split(":")[1]), 0, 0, 0);

      // Check if booking time is in the past
      if (dt.isBefore(DateTime.now())) {
        ShowToastDialog.closeLoader();
        ShowToastDialog.showToast(
            "You cannot book a table for a past date or time. Please select a future time."
                .tr);
        isBooking.value = false;
        return;
      }

      // Create cache key for this specific booking
      String cacheKey =
          "${FireStoreUtils.getCurrentUid()}_${vendorModel.value.id}_${dt.millisecondsSinceEpoch}";

      // Check local cache first (prevents immediate re-booking)
      if (_bookingCache.containsKey(cacheKey)) {
        DateTime cachedTime = _bookingCache[cacheKey]!;
        Duration timeSinceCache = DateTime.now().difference(cachedTime);

        if (timeSinceCache < _cacheDuration) {
          ShowToastDialog.closeLoader();
          ShowToastDialog.showToast(
              "You just created a booking for this time. Please wait a moment before booking again."
                  .tr);
          isBooking.value = false;
          return;
        } else {
          _bookingCache.remove(cacheKey);
        }
      } else {}

      // Check Firestore for existing bookings
      bool hasExistingBooking = await checkExistingBooking();

      if (hasExistingBooking) {
        ShowToastDialog.closeLoader();
        ShowToastDialog.showToast(
            "You already have a booking at this restaurant for the selected date and time."
                .tr);
        isBooking.value = false;
        return;
      }

      // Prepare final booking timestamp
      DateTime dateTime = selectedDate.value.toDate();
      String hourStr = DateFormat("kk:mm").format(DateFormat('hh:mm a').parse(
          (Intl.getCurrentLocale() == "en_US")
              ? selectedTimeSlot.value
              : selectedTimeSlot.value.toLowerCase()));
      dateTime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          int.parse(hourStr.split(":")[0]),
          int.parse(hourStr.split(":")[1]),
          dateTime.second,
          dateTime.millisecond,
          dateTime.microsecond);
      selectedDate.value = Timestamp.fromDate(dateTime);

      DineInBookingModel dineInBookingModel = DineInBookingModel(
          id: Constant.getUuid(),
          author: Constant.userModel,
          authorID: FireStoreUtils.getCurrentUid(),
          createdAt: Timestamp.now(),
          date: selectedDate.value,
          status: Constant.orderPlaced,
          vendor: vendorModel.value,
          specialRequest: additionRequestController.value.text.isEmpty
              ? ""
              : additionRequestController.value.text,
          vendorID: vendorModel.value.id,
          guestEmail: Constant.userModel!.email,
          guestFirstName: Constant.userModel!.firstName,
          guestLastName: Constant.userModel!.lastName,
          guestPhone: Constant.userModel!.phoneNumber,
          occasion: selectedOccasion.value,
          discount: selectedTimeDiscount.value,
          discountType: selectedTimeDiscountType.value,
          totalGuest: noOfQuantity.value.toString(),
          firstVisit: firstVisit.value);

      // Final validation check before saving (prevents race conditions)
      final finalDuplicateCheck =
          await FireStoreUtils.checkDuplicateDineInBooking(
              userId: FireStoreUtils.getCurrentUid(),
              vendorId: vendorModel.value.id!,
              bookingDate: selectedDate.value);

      if (finalDuplicateCheck != null) {
        ShowToastDialog.closeLoader();
        ShowToastDialog.showToast(
            "Another booking for this time was just created. Please select a different time."
                .tr);
        isBooking.value = false;
        return;
      }

      // Add to cache BEFORE saving to Firestore (critical for preventing duplicates)
      _bookingCache[cacheKey] = DateTime.now();

      await FireStoreUtils.setBookedOrder(dineInBookingModel);

      await SendNotification.sendFcmMessage(
          Constant.dineInPlaced, vendorModel.value.fcmToken.toString(), {});

      ShowToastDialog.closeLoader();
      Get.back();
      Get.to(const DineInBookingScreen());
      ShowToastDialog.showToast('Dine-In Request submitted successfully.'.tr);

      // Clean up old cache entries
      _cleanupCache();
    } catch (e) {
      ShowToastDialog.closeLoader();
      ShowToastDialog.showToast("Failed to book table. Please try again.".tr);
    } finally {
      isBooking.value = false;
    }
  }

// Add this helper method to your controller class
  void _cleanupCache() {
    final now = DateTime.now();
    int removedCount = 0;
    _bookingCache.removeWhere((key, cachedTime) {
      bool shouldRemove = now.difference(cachedTime) > _cacheDuration;
      if (shouldRemove) removedCount++;
      return shouldRemove;
    });
  }

  Future<bool> checkExistingBooking() async {
    try {
      DateTime dt = selectedDate.value.toDate();
      String hour = DateFormat("kk:mm").format(DateFormat('hh:mm a').parse(
          (Intl.getCurrentLocale() == "en_US")
              ? selectedTimeSlot.value
              : selectedTimeSlot.value.toLowerCase()));
      dt = DateTime(dt.year, dt.month, dt.day, int.parse(hour.split(":")[0]),
          int.parse(hour.split(":")[1]), 0, 0, 0);

      Timestamp bookingTimestamp = Timestamp.fromDate(dt);

      // Use FireStoreUtils method for consistency
      final duplicateId = await FireStoreUtils.checkDuplicateDineInBooking(
          userId: FireStoreUtils.getCurrentUid(),
          vendorId: vendorModel.value.id!,
          bookingDate: bookingTimestamp);

      return duplicateId != null;
    } catch (e) {
      print("Error checking existing booking: $e");
      return false;
    }
  }

  getRecord() {
    for (int i = 0; i < 7; i++) {
      final now = DateTime.now().add(Duration(days: i));
      var day = DateFormat('EEEE').format(now);
      if (vendorModel.value.specialDiscount?.isNotEmpty == true &&
          vendorModel.value.specialDiscountEnable == true) {
        for (var element in vendorModel.value.specialDiscount!) {
          if (day == element.day.toString()) {
            if (element.timeslot!.isNotEmpty) {
              SpecialDiscountTimeslot employeeWithMaxSalary = element.timeslot!
                  .reduce((item1, item2) =>
                      double.parse(item1.discount.toString()) >
                              double.parse(item2.discount.toString())
                          ? item1
                          : item2);
              if (employeeWithMaxSalary.discountType == "dinein") {
                DateModel model = DateModel(
                    date: Timestamp.fromDate(now),
                    discountPer: employeeWithMaxSalary.discount.toString());
                dateList.add(model);
              } else {
                DateModel model =
                    DateModel(date: Timestamp.fromDate(now), discountPer: "0");
                dateList.add(model);
              }
            } else {
              DateModel model =
                  DateModel(date: Timestamp.fromDate(now), discountPer: "0");
              dateList.add(model);
            }
          }
        }
      } else {
        DateModel model =
            DateModel(date: Timestamp.fromDate(now), discountPer: "0");
        dateList.add(model);
      }
    }
    selectedDate.value = dateList.first.date;

    timeSet(selectedDate.value);
    if (timeSlotList.isNotEmpty) {
      selectedTimeSlot.value =
          DateFormat('hh:mm a').format(timeSlotList[0].time!);
    }
  }

  timeSet(Timestamp selectedDate) {
    timeSlotList.clear();

    for (DateTime time =
            Constant.stringToDate(vendorModel.value.openDineTime.toString());
        time.isBefore(
            Constant.stringToDate(vendorModel.value.closeDineTime.toString()));
        time = time.add(const Duration(minutes: 30))) {
      final now = DateTime.parse(selectedDate.toDate().toString());
      var day = DateFormat('EEEE').format(now);
      var date = DateFormat('dd-MM-yyyy').format(now);

      if (vendorModel.value.specialDiscount?.isNotEmpty == true &&
          vendorModel.value.specialDiscountEnable == true) {
        for (var element in vendorModel.value.specialDiscount!) {
          if (day == element.day.toString()) {
            if (element.timeslot!.isNotEmpty) {
              for (var element in element.timeslot!) {
                if (element.discountType == "dinein") {
                  var start = DateFormat("dd-MM-yyyy HH:mm")
                      .parse("$date ${element.from}");
                  var end = DateFormat("dd-MM-yyyy HH:mm")
                      .parse("$date ${element.to}");
                  var selected = DateFormat("dd-MM-yyyy HH:mm")
                      .parse("$date ${DateFormat.Hm().format(time)}");

                  if (isCurrentDateInRangeDineIn(start, end, selected)) {
                    var contains =
                        timeSlotList.where((element) => element.time == time);
                    if (contains.isNotEmpty) {
                      var index = timeSlotList
                          .indexWhere((element) => element.time == time);
                      if (timeSlotList[index].discountPer == "0") {
                        timeSlotList.removeAt(index);
                        TimeModel model = TimeModel(
                            time: time,
                            discountPer: element.discount,
                            discountType: element.type);
                        timeSlotList.insert(index == 0 ? 0 : index, model);
                      }
                    } else {
                      TimeModel model = TimeModel(
                          time: time,
                          discountPer: element.discount,
                          discountType: element.type);
                      timeSlotList.add(model);
                    }
                  } else {
                    var contains =
                        timeSlotList.where((element) => element.time == time);
                    if (contains.isEmpty) {
                      TimeModel model = TimeModel(
                          time: time, discountPer: "0", discountType: "amount");
                      timeSlotList.add(model);
                    }
                  }
                } else {
                  TimeModel model = TimeModel(
                      time: time, discountPer: "0", discountType: "amount");
                  timeSlotList.add(model);
                }
              }
            } else {
              TimeModel model = TimeModel(
                  time: time, discountPer: "0", discountType: "amount");
              timeSlotList.add(model);
            }
          }
        }
      } else {
        TimeModel model =
            TimeModel(time: time, discountPer: "0", discountType: "amount");
        timeSlotList.add(model);
      }
    }
  }

  void animateSlider() {
    if (vendorModel.value.photos != null &&
        vendorModel.value.photos!.isNotEmpty) {
      Timer.periodic(const Duration(seconds: 2), (Timer timer) {
        if (currentPage < vendorModel.value.photos!.length) {
          currentPage++;
        } else {
          currentPage.value = 0;
        }

        if (pageController.value.hasClients) {
          pageController.value.animateToPage(
            currentPage.value,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      });
    }
  }

  Rx<VendorModel> vendorModel = VendorModel().obs;

  getArgument() async {
    dynamic argumentData = Get.arguments;
    if (argumentData != null) {
      vendorModel.value = argumentData['vendorModel'];
    }
    animateSlider();
    statusCheck();
    isLoading.value = false;
    await getFavouriteList();

    update();
  }

  getFavouriteList() async {
    if (Constant.userModel != null) {
      await FireStoreUtils.getFavouriteRestaurant().then(
        (value) {
          favouriteList.value = value;
        },
      );
    }

    await FireStoreUtils.getVendorCuisines(vendorModel.value.id.toString())
        .then(
      (value) {
        tags.value = value;
      },
    );
    update();
  }

  RxBool isOpen = false.obs;

  statusCheck() {
    final now = DateTime.now();
    var day = DateFormat('EEEE', 'en_US').format(now);
    var date = DateFormat('dd-MM-yyyy').format(now);
    for (var element in vendorModel.value.workingHours!) {
      if (day == element.day.toString()) {
        if (element.timeslot!.isNotEmpty) {
          for (var element in element.timeslot!) {
            var start =
                DateFormat("dd-MM-yyyy HH:mm").parse("$date ${element.from}");
            var end =
                DateFormat("dd-MM-yyyy HH:mm").parse("$date ${element.to}");
            if (isCurrentDateInRange(start, end)) {
              isOpen.value = true;
            }
          }
        }
      }
    }
  }

  bool isCurrentDateInRangeDineIn(
      DateTime startDate, DateTime endDate, DateTime selected) {
    return selected.isAtSameMomentAs(startDate) ||
        selected.isAtSameMomentAs(endDate) ||
        selected.isAfter(startDate) && selected.isBefore(endDate);
  }

  bool isCurrentDateInRange(DateTime startDate, DateTime endDate) {
    final currentDate = DateTime.now();
    return currentDate.isAfter(startDate) && currentDate.isBefore(endDate);
  }
}

class DateModel {
  late Timestamp date;
  late String discountPer;

  DateModel({required this.date, required this.discountPer});
}

class TimeModel {
  DateTime? time;
  String? discountPer;
  String? discountType;

  TimeModel(
      {required this.time,
      required this.discountPer,
      required this.discountType});
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
