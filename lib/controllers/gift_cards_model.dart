import 'package:cloud_firestore/cloud_firestore.dart';

class GiftCardsModel {
  Timestamp? createdAt;
  String? image;
  String? expiryDay;
  String? id;
  String? message;
  String? title;
  bool? isEnable;

  GiftCardsModel({this.createdAt, this.image, this.expiryDay, this.id, this.message, this.title, this.isEnable});

  GiftCardsModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    image = json['image'];
    expiryDay = json['expiryDay'];
    id = json['id'];
    message = json['message'];
    title = json['title'];
    isEnable = json['isEnable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['image'] = image;
    data['expiryDay'] = expiryDay;
    data['id'] = id;
    data['message'] = message;
    data['title'] = title;
    data['isEnable'] = isEnable;
    return data;
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

