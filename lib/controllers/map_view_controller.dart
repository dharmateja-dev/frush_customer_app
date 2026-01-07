import 'dart:typed_data';

import 'package:customer/app/restaurant_details_screen/restaurant_details_screen.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flutterMap;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as location;

class MapViewController extends GetxController {
  GoogleMapController? mapController;
  BitmapDescriptor? parkingMarker;
  BitmapDescriptor? currentLocationMarker;

  HomeController homeController = Get.find<HomeController>();
  Image? departureOsmIcon; //OSM

  RxList<flutterMap.Marker> osmMarker = <flutterMap.Marker>[].obs;
  final flutterMap.MapController osmMapController = flutterMap.MapController();

  @override
  void onInit() {
    // TODO: implement onInit
    addMarkerSetup();
    super.onInit();
  }

  addMarkerSetup() async {
    if (Constant.selectedMapType == "osm") {
      departureOsmIcon = Image.asset("assets/images/map_selected.png",
          width: 30, height: 30); //OSM

      for (var element in homeController.allNearestRestaurant) {
        osmMarker.add(flutterMap.Marker(
          point: location.LatLng(
              element.latitude ?? 0.0, element.longitude ?? 0.0),
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () {
              Get.to(const RestaurantDetailsScreen(),
                  arguments: {"vendorModel": element});
            },
            child: departureOsmIcon,
          ),
        ));
      }
    } else {
      final Uint8List parking = await Constant()
          .getBytesFromAsset("assets/images/map_selected.png", 20);
      parkingMarker = BitmapDescriptor.bytes(parking);
      for (var element in homeController.allNearestRestaurant) {
        addMarker(
            latitude: element.latitude,
            longitude: element.longitude,
            id: element.id.toString(),
            rotation: 0,
            descriptor: parkingMarker!,
            title: element.title.toString());
      }
    }
  }

  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  addMarker(
      {required double? latitude,
      required double? longitude,
      required String id,
      required BitmapDescriptor descriptor,
      required double? rotation,
      required String title}) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      infoWindow: InfoWindow(
        title: title,
        onTap: () {
          int index = homeController.allNearestRestaurant
              .indexWhere((p0) => p0.id == id);
          Get.to(const RestaurantDetailsScreen(), arguments: {
            "vendorModel": homeController.allNearestRestaurant[index]
          });
        },
      ),
      position: LatLng(latitude ?? 0.0, longitude ?? 0.0),
      rotation: rotation ?? 0.0,
    );
    markers[markerId] = marker;
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

