class FavouriteItemModel {
  String? storeId;
  String? userId;
  String? productId;

  FavouriteItemModel({this.storeId, this.userId, this.productId});

  factory FavouriteItemModel.fromJson(Map<String, dynamic> parsedJson) {
    return FavouriteItemModel(storeId: parsedJson["store_id"] ?? "", userId: parsedJson["user_id"] ?? "", productId: parsedJson["product_id"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"store_id": storeId, "user_id": userId, "product_id": productId};
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

