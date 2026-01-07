import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/widget/geoflutterfire/src/models/distance_doc_snapshot.dart';
import 'package:customer/widget/geoflutterfire/src/models/point.dart';
import 'package:flutter/cupertino.dart';

import 'base.dart';

class GeoFireCollectionRef extends BaseGeoFireCollectionRef<Map<String, dynamic>> {
  GeoFireCollectionRef(super.collectionReference);

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> within({
    required GeoFirePoint center,
    required double radius,
    required String field,
    bool? strictMode,
  }) {
    return protectedWithin(
      center: center,
      radius: radius,
      field: field,
      geopointFrom: (snapData) => geopointFromMap(
        field: field,
        snapData: snapData,
      ),
      strictMode: strictMode,
    );
  }

  Stream<List<DistanceDocSnapshot<Map<String, dynamic>>>> withinWithDistance({
    required GeoFirePoint center,
    required double radius,
    required String field,
    bool? strictMode,
  }) {
    return protectedWithinWithDistance(
      center: center,
      radius: radius,
      field: field,
      geopointFrom: (snapData) => geopointFromMap(
        field: field,
        snapData: snapData,
      ),
      strictMode: strictMode,
    );
  }

  @visibleForTesting
  static GeoPoint? geopointFromMap({
    required String field,
    required Map<String, dynamic> snapData,
  }) {
    // split and fetch geoPoint from the nested Map
    final fieldList = field.split('.');
    Map<dynamic, dynamic>? geoPointField = snapData[fieldList[0]];
    if (fieldList.length > 1) {
      for (int i = 1; i < fieldList.length; i++) {
        geoPointField = geoPointField?[fieldList[i]];
      }
    }
    return geoPointField?['geopoint'] as GeoPoint?;
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

