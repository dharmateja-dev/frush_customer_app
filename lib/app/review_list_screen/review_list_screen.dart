import 'package:customer/app/chat_screens/full_screen_image_viewer.dart';
import 'package:customer/constant/collection_name.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/controllers/review_list_controller.dart';
import 'package:customer/models/product_model.dart';
import 'package:customer/models/rating_model.dart';
import 'package:customer/models/review_attribute_model.dart';
import 'package:customer/themes/app_them_data.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/utils/dark_theme_provider.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:customer/utils/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:customer/widget/rating_star_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GetX(
        init: ReviewListController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
            appBar: AppBar(
              backgroundColor: themeChange.getThem()
                  ? AppThemeData.surfaceDark
                  : AppThemeData.surface,
              centerTitle: false,
              titleSpacing: 0,
              title: Text(
                "Reviews".tr,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: AppThemeData.medium,
                  fontSize: 16,
                  color: themeChange.getThem()
                      ? AppThemeData.grey50
                      : AppThemeData.grey900,
                ),
              ),
            ),
            body: controller.isLoading.value
                ? Constant.loader()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: ListView.builder(
                      itemCount: controller.ratingList.length,
                      itemBuilder: (context, index) {
                        RatingModel ratingModel = controller.ratingList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: ShapeDecoration(
                              color: themeChange.getThem()
                                  ? AppThemeData.grey900
                                  : AppThemeData.grey50,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1,
                                    color: themeChange.getThem()
                                        ? AppThemeData.grey700
                                        : AppThemeData.grey200),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ratingModel.uname.toString(),
                                    style: TextStyle(
                                        color: themeChange.getThem()
                                            ? AppThemeData.grey50
                                            : AppThemeData.grey900,
                                        fontSize: 18,
                                        fontFamily: AppThemeData.semiBold),
                                  ),
                                  Visibility(
                                    visible: ratingModel.productId != null,
                                    child: FutureBuilder(
                                        future: FireStoreUtils.fireStore
                                            .collection(
                                                CollectionName.vendorProducts)
                                            .doc(ratingModel.productId
                                                ?.split('~')
                                                .first)
                                            .get(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Text('');
                                          } else {
                                            if (snapshot.hasError) {
                                              return const Text('');
                                            } else if (snapshot.data == null) {
                                              return const Text('');
                                            } else if (snapshot.data != null) {
                                              ProductModel model =
                                                  ProductModel.fromJson(
                                                      snapshot.data!.data()!);
                                              return Text(
                                                '${'Rate for'.tr} - ${model.name ?? ''}',
                                                style: TextStyle(
                                                    color: themeChange.getThem()
                                                        ? AppThemeData.grey50
                                                        : AppThemeData.grey900,
                                                    fontSize: 14,
                                                    fontFamily:
                                                        AppThemeData.semiBold),
                                              );
                                            } else {
                                              return const Text('');
                                            }
                                          }
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RatingDisplayWidget(
                                    rating: ratingModel.rating ?? 0.0,
                                    itemCount: 5,
                                    itemSize: 18,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Visibility(
                                    visible: ratingModel.comment != '' &&
                                        ratingModel.comment != null,
                                    child: Text(
                                      ratingModel.comment.toString(),
                                      style: TextStyle(
                                          color: themeChange.getThem()
                                              ? AppThemeData.grey50
                                              : AppThemeData.grey900,
                                          fontSize: 16,
                                          fontFamily: AppThemeData.medium),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Visibility(
                                    visible:
                                        ratingModel.reviewAttributes != null,
                                    child: ListView.builder(
                                      itemCount:
                                          ratingModel.reviewAttributes!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        String key = ratingModel
                                            .reviewAttributes!.keys
                                            .elementAt(index);
                                        dynamic value =
                                            ratingModel.reviewAttributes![key];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: Row(
                                            children: [
                                              FutureBuilder(
                                                  future: FireStoreUtils
                                                      .fireStore
                                                      .collection(CollectionName
                                                          .reviewAttributes)
                                                      .doc(key)
                                                      .get(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const Text('');
                                                    } else {
                                                      if (snapshot.hasError) {
                                                        return const Text('');
                                                      } else if (snapshot
                                                              .data ==
                                                          null) {
                                                        return const Text('');
                                                      } else {
                                                        ReviewAttributeModel
                                                            model =
                                                            ReviewAttributeModel
                                                                .fromJson(snapshot
                                                                    .data!
                                                                    .data()!);
                                                        return Expanded(
                                                          child: Text(
                                                            model.title
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: themeChange
                                                                      .getThem()
                                                                  ? AppThemeData
                                                                      .grey50
                                                                  : AppThemeData
                                                                      .grey900,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  AppThemeData
                                                                      .semiBold,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                  }),
                                              RatingDisplayWidget(
                                                rating: value == null
                                                    ? 0.0
                                                    : value ?? 0.0,
                                                itemCount: 5,
                                                itemSize: 15,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  if (ratingModel.photos?.isNotEmpty == true)
                                    SizedBox(
                                      height: Responsive.height(9, context),
                                      child: ListView.builder(
                                        itemCount: ratingModel.photos?.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(FullScreenImageViewer(
                                                  imageUrl: ratingModel
                                                      .photos?[index]));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: NetworkImageWidget(
                                                  imageUrl: ratingModel
                                                      .photos?[index],
                                                  height: Responsive.height(
                                                      9, context),
                                                  width: Responsive.height(
                                                      8, context),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    Constant.timestampToDateTime(
                                        ratingModel.createdAt!),
                                    style: TextStyle(
                                        color: themeChange.getThem()
                                            ? AppThemeData.grey300
                                            : AppThemeData.grey600,
                                        fontSize: 14,
                                        fontFamily: AppThemeData.medium),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          );
        });
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
