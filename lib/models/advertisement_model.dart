import 'package:cloud_firestore/cloud_firestore.dart';

class AdvertisementModel {
  String? coverImage;
  Timestamp? createdAt;
  String? description;
  Timestamp? endDate;
  String? id;
  bool? paymentStatus;
  String? priority;
  String? profileImage;
  bool? showRating;
  bool? showReview;
  Timestamp? startDate;
  String? status;
  String? title;
  String? type;
  String? vendorId;
  String? video;
  dynamic isPaused;
  Timestamp? updatedAt;
  String? canceledNote;
  String? pauseNote;

  AdvertisementModel({
    this.coverImage,
    this.createdAt,
    this.description,
    this.endDate,
    this.id,
    this.paymentStatus,
    this.priority,
    this.profileImage,
    this.showRating,
    this.showReview,
    this.startDate,
    this.status,
    this.title,
    this.type,
    this.vendorId,
    this.video,
    this.isPaused,
    this.updatedAt,
    this.canceledNote,
    this.pauseNote,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementModel(
        coverImage: json['coverImage'],
        createdAt: json['createdAt'],
        description: json['description'],
        endDate: json['endDate'],
        id: json['id'],
        paymentStatus: json['paymentStatus'],
        priority: json['priority'],
        profileImage: json['profileImage'],
        showRating: json['showRating'],
        showReview: json['showReview'],
        startDate: json['startDate'],
        status: json['status'],
        title: json['title'],
        type: json['type'],
        vendorId: json['vendorId'],
        video: json['video'],
        isPaused: json['isPaused'],
        updatedAt: json['updatedAt'],
        canceledNote: json['canceledNote'],
        pauseNote: json['pauseNote']);
  }

  Map<String, dynamic> toJson() {
    return {
      'coverImage': coverImage,
      'createdAt': createdAt,
      'description': description,
      'endDate': endDate,
      'id': id,
      'paymentStatus': paymentStatus,
      'priority': priority,
      'profileImage': profileImage,
      'showRating': showRating,
      'showReview': showReview,
      'startDate': startDate,
      'status': status,
      'title': title,
      'type': type,
      'vendorId': vendorId,
      'video': video,
      'isPaused': isPaused,
      'updatedAt': updatedAt,
      'canceledNote': canceledNote,
      'pauseNote': pauseNote,
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

