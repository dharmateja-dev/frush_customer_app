import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  String? id;
  double? rating;
  List<dynamic>? photos;
  String? comment;
  String? orderId;
  String? customerId;
  String? vendorId;
  String? productId;
  String? driverId;
  String? uname;
  String? profile;
  Map<String, dynamic>? reviewAttributes;
  Timestamp? createdAt;

  RatingModel({
    this.id,
    this.comment,
    this.photos,
    this.rating,
    this.orderId,
    this.vendorId,
    this.productId,
    this.driverId,
    this.customerId,
    this.uname,
    this.createdAt,
    this.reviewAttributes,
    this.profile,
  });

  factory RatingModel.fromJson(Map<String, dynamic> parsedJson) {
    return RatingModel(
        comment: parsedJson['comment'] ?? '',
        photos: parsedJson['photos'] ?? [],
        rating: double.parse(parsedJson['rating'].toString()),
        id: parsedJson['Id'] ?? '',
        orderId: parsedJson['orderid'] ?? '',
        vendorId: parsedJson['VendorId'] ?? '',
        productId: parsedJson['productId'] ?? '',
        driverId: parsedJson['driverId'] ?? '',
        customerId: parsedJson['CustomerId'] ?? '',
        uname: parsedJson['uname'] ?? '',
        reviewAttributes: parsedJson['reviewAttributes'] ?? {},
        createdAt: parsedJson['createdAt'] ?? Timestamp.now(),
        profile: parsedJson['profile'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'photos': photos,
      'rating': rating,
      'Id': id,
      'orderid': orderId,
      'VendorId': vendorId,
      'productId': productId,
      'driverId': driverId,
      'CustomerId': customerId,
      'uname': uname,
      'profile': profile,
      'reviewAttributes': reviewAttributes ?? {},
      'createdAt': createdAt
    };
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

