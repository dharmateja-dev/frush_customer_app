import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:customer/themes/app_them_data.dart';
import 'package:customer/utils/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class DataPermissionDialog extends StatelessWidget {
  final VoidCallback onContinue;

  const DataPermissionDialog({
    Key? key,
    required this.onContinue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: themeChange.getThem()
              ? AppThemeData.grey900
              : AppThemeData.grey50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppThemeData.primary300.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.security,
                size: 48,
                color: AppThemeData.primary300,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              "Data Access Permissions".tr,
              style: TextStyle(
                color: themeChange.getThem()
                    ? AppThemeData.grey50
                    : AppThemeData.grey900,
                fontSize: 20,
                fontFamily: AppThemeData.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              "To provide you with the best experience, our app needs access to the following:"
                  .tr,
              style: TextStyle(
                color: themeChange.getThem()
                    ? AppThemeData.grey400
                    : AppThemeData.grey600,
                fontSize: 14,
                fontFamily: AppThemeData.regular,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Permission Items
            _buildPermissionItem(
              context: context,
              icon: Icons.location_on,
              title: "Location Access".tr,
              description: "To show nearby restaurants and delivery options".tr,
              themeChange: themeChange,
            ),
            const SizedBox(height: 16),

            _buildPermissionItem(
              context: context,
              icon: Icons.my_location,
              title: "Background Location".tr,
              description: "To track your delivery in real-time".tr,
              themeChange: themeChange,
            ),
            const SizedBox(height: 16),

            _buildPermissionItem(
              context: context,
              icon: Icons.notifications,
              title: "Notifications".tr,
              description: "To keep you updated about your orders".tr,
              themeChange: themeChange,
            ),
            const SizedBox(height: 24),

            // Privacy Note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: themeChange.getThem()
                    ? AppThemeData.grey800.withOpacity(0.5)
                    : AppThemeData.grey100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lock,
                    size: 16,
                    color: AppThemeData.primary300,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Your privacy is important to us. We only use this data to improve your experience."
                          .tr,
                      style: TextStyle(
                        color: themeChange.getThem()
                            ? AppThemeData.grey400
                            : AppThemeData.grey600,
                        fontSize: 12,
                        fontFamily: AppThemeData.regular,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  onContinue();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppThemeData.primary300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Continue".tr,
                  style: const TextStyle(
                    color: AppThemeData.grey50,
                    fontSize: 16,
                    fontFamily: AppThemeData.semiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required DarkThemeProvider themeChange,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppThemeData.primary300.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 24,
            color: AppThemeData.primary300,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: themeChange.getThem()
                      ? AppThemeData.grey50
                      : AppThemeData.grey900,
                  fontSize: 15,
                  fontFamily: AppThemeData.semiBold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: themeChange.getThem()
                      ? AppThemeData.grey400
                      : AppThemeData.grey600,
                  fontSize: 13,
                  fontFamily: AppThemeData.regular,
                ),
              ),
            ],
          ),
        ),
      ],
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

