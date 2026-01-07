import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/widget/geoflutterfire/src/collection/with_converter.dart';

import 'collection/default.dart';
import 'models/point.dart';

class Geoflutterfire {
  Geoflutterfire();

  GeoFireCollectionRef collection({
    required Query<Map<String, dynamic>> collectionRef,
  }) {
    return GeoFireCollectionRef(collectionRef);
  }

  GeoFireCollectionWithConverterRef<T> collectionWithConverter<T>({
    required Query<T> collectionRef,
  }) {
    return GeoFireCollectionWithConverterRef<T>(collectionRef);
  }

  GeoFireCollectionRef customCollection({
    required Query<Map<String, dynamic>> collectionRef,
  }) {
    return GeoFireCollectionRef(collectionRef);
  }

  GeoFirePoint point({required double latitude, required double longitude}) {
    return GeoFirePoint(latitude, longitude);
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

