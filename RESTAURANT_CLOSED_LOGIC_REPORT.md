# Restaurant Closed Logic - Implementation Report

**Date:** January 9, 2026  
**Feature:** Prevent ordering when restaurant is closed  
**Status:** ✅ Completed

---

## 📋 Issue Description

When a restaurant is closed (outside operating hours), customers should not be able to:
1. Reorder from order history
2. Reorder from order details
3. Place new orders from cart

A toast message should be displayed to inform the user that the restaurant is currently closed.

---

## 📁 Files Modified

| # | File Path | Change Type |
|---|-----------|-------------|
| 1 | `lib/constant/constant.dart` | Added helper function |
| 2 | `lib/lang/app_en.dart` | Added translation |
| 3 | `lib/lang/app_es.dart` | Added translation |
| 4 | `lib/lang/app_ar.dart` | Added translation |
| 5 | `lib/app/order_list_screen/order_screen.dart` | Added closed check |
| 6 | `lib/app/order_list_screen/order_details_screen.dart` | Added closed check |
| 7 | `lib/controllers/cart_controller.dart` | Added closed check |

---

## 🔧 Detailed Changes

### 1. lib/constant/constant.dart

**Location:** After `calculateDifference()` function (around line 408)

**Add this new static function:**

```dart
/// Check if a vendor/restaurant is currently open based on their working hours
static bool isVendorOpen(VendorModel? vendorModel) {
  if (vendorModel == null || vendorModel.workingHours == null) {
    return false;
  }
  
  final now = DateTime.now();
  var day = DateFormat('EEEE', 'en_US').format(now);
  var date = DateFormat('dd-MM-yyyy').format(now);
  
  for (var element in vendorModel.workingHours!) {
    if (day == element.day.toString()) {
      if (element.timeslot != null && element.timeslot!.isNotEmpty) {
        for (var timeslot in element.timeslot!) {
          try {
            var start = DateFormat("dd-MM-yyyy HH:mm").parse("$date ${timeslot.from}");
            var end = DateFormat("dd-MM-yyyy HH:mm").parse("$date ${timeslot.to}");
            if (now.isAfter(start) && now.isBefore(end)) {
              return true;
            }
          } catch (e) {
            // Handle parsing errors silently
          }
        }
      }
    }
  }
  return false;
}
```

**Note:** Requires `import 'package:intl/intl.dart';` (already imported in constant.dart)

---

### 2. lib/lang/app_en.dart

**Location:** After line with `'Item Added In a cart': 'Item Added In a cart',`

**Add this translation:**

```dart
'Restaurant is currently closed. You cannot place an order at this time.': 'Restaurant is currently closed. You cannot place an order at this time.',
```

---

### 3. lib/lang/app_es.dart

**Location:** After line with `"Reorder": "Reordenar",`

**Add this translation:**

```dart
"Restaurant is currently closed. You cannot place an order at this time.": "El restaurante está cerrado actualmente. No puedes realizar un pedido en este momento.",
```

---

### 4. lib/lang/app_ar.dart

**Location:** After line with `"Reorder": "جدولة",`

**Add this translation:**

```dart
"Restaurant is currently closed. You cannot place an order at this time.": "المطعم مغلق حالياً. لا يمكنك تقديم طلب في هذا الوقت.",
```

---

### 5. lib/app/order_list_screen/order_screen.dart

**Location:** Inside the `onTap` callback of the Reorder button (around line 500-512)

**Change FROM:**

```dart
onTap: () {
  for (var element in orderModel.products!) {
    controller.addToCart(cartProductModel: element);
    ShowToastDialog.showToast("Item Added In a cart".tr);
  }
},
```

**Change TO:**

```dart
onTap: () {
  // Check if restaurant is currently open
  if (!Constant.isVendorOpen(orderModel.vendor)) {
    ShowToastDialog.showToast(
        "Restaurant is currently closed. You cannot place an order at this time."
            .tr);
    return;
  }
  for (var element in orderModel.products!) {
    controller.addToCart(cartProductModel: element);
    ShowToastDialog.showToast("Item Added In a cart".tr);
  }
},
```

---

### 6. lib/app/order_list_screen/order_details_screen.dart

**Location:** Inside the `onPress` callback of the Reorder RoundedButtonFill (around line 2057-2072)

**Change FROM:**

```dart
onPress: () async {
  for (var element in controller.orderModel.value.products!) {
    controller.addToCart(cartProductModel: element);
    ShowToastDialog.showToast("Item Added In a cart".tr);
  }
},
```

**Change TO:**

```dart
onPress: () async {
  // Check if restaurant is currently open
  if (!Constant.isVendorOpen(controller.orderModel.value.vendor)) {
    ShowToastDialog.showToast(
        "Restaurant is currently closed. You cannot place an order at this time."
            .tr);
    return;
  }
  for (var element in controller.orderModel.value.products!) {
    controller.addToCart(cartProductModel: element);
    ShowToastDialog.showToast("Item Added In a cart".tr);
  }
},
```

---

### 7. lib/controllers/cart_controller.dart

**Location:** At the beginning of `placeOrder()` function (around line 299)

**Change FROM:**

```dart
placeOrder() async {
  if (selectedPaymentMethod.value == PaymentGateway.wallet.name) {
    // ... rest of the code
  }
}
```

**Change TO:**

```dart
placeOrder() async {
  // Check if restaurant is currently open before placing order
  if (!Constant.isVendorOpen(vendorModel.value)) {
    ShowToastDialog.showToast(
        "Restaurant is currently closed. You cannot place an order at this time."
            .tr);
    return;
  }

  if (selectedPaymentMethod.value == PaymentGateway.wallet.name) {
    // ... rest of the code
  }
}
```

---

## 🧪 Testing Checklist

- [ ] Set restaurant working hours to closed time
- [ ] Try to reorder from Order History screen → Should show toast and block
- [ ] Try to reorder from Order Details screen → Should show toast and block
- [ ] Try to place order from Cart screen → Should show toast and block
- [ ] Verify toast message displays correctly
- [ ] Test with restaurant open → Should work normally

---

## 📝 Notes

1. The helper function `Constant.isVendorOpen()` uses the same logic as `RestaurantDetailsController.statusCheck()` for consistency.

2. The toast message uses `ShowToastDialog.showToast()` which is the standard toast used throughout the app (uses `flutter_easyloading` package).

3. The restaurant details screen already hides the "Add" button when closed (existing implementation at line 1661-1663), so new item additions are already blocked.

4. Add translations to any additional language files your project uses.

---

## 👨‍💻 Author

Implementation completed by AI Assistant  
Report generated on: January 9, 2026
