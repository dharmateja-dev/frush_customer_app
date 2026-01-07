class BannerModel {
  int? setOrder;
  String? photo;
  String? title;
  bool? isPublish;
  String? redirect_type;
  String? redirect_id;

  BannerModel({this.setOrder, this.photo, this.title, this.redirect_type, this.redirect_id, this.isPublish});

  BannerModel.fromJson(Map<String, dynamic> json) {
    setOrder = json['set_order'];
    photo = json['photo'];
    title = json['title'];
    isPublish = json['is_publish'];
    redirect_type = json['redirect_type'];
    redirect_id = json['redirect_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['set_order'] = setOrder;
    data['photo'] = photo;
    data['title'] = title;
    data['is_publish'] = isPublish;
    data['redirect_type'] = redirect_type;
    data['redirect_id'] = redirect_id;
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

