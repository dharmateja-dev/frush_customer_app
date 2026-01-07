import 'package:customer/themes/app_them_data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectedItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  Decoration? decoration;
  double itemSize;
  bool isSelected;

  SelectedItemWidget({
    super.key,
    this.decoration,
    this.itemSize = 12.0,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        height: 18,
        width: 18,
        decoration: decoration ??
            BoxDecoration(
              color: isSelected ? AppThemeData.primary300 : Colors.transparent,
              border: Border.all(color: AppThemeData.primary300),
              shape: BoxShape.circle,
            ),
        child: isSelected
            ? Icon(Icons.check, color: Colors.black, size: itemSize)
            : const Offstage(),
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

