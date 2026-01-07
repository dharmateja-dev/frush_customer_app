import 'package:customer/themes/app_them_data.dart';
import 'package:customer/themes/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoundedButtonFill extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final double? fontSizes;
  final double? radius;
  final Color? color;
  final Color? textColor;
  final Widget? icon;
  final bool? isRight;
  final bool? isEnabled;
  final Function()? onPress;

  const RoundedButtonFill(
      {super.key,
      this.isEnabled = true,
      required this.title,
      this.height,
      required this.onPress,
      this.width,
      this.color,
      this.icon,
      this.fontSizes,
      this.textColor,
      this.isRight,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled == true
          ? () {
              FocusManager.instance.primaryFocus?.unfocus();
              onPress!();
            }
          : () {},
      child: Container(
        width: Responsive.width(width ?? 100, context),
        height: Responsive.height(height ?? 6, context),
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 200),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (isRight == false) ? Padding(padding: const EdgeInsets.only(right: 5), child: icon) : const SizedBox(),
            Text(
              title.tr.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppThemeData.semiBold,
                color: textColor ?? AppThemeData.grey800,
                fontSize: fontSizes ?? 16,
              ),
            ),
            (isRight == true) ? Padding(padding: const EdgeInsets.only(left: 5), child: icon) : const SizedBox(),
          ],
        ),
      ),
    );
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

