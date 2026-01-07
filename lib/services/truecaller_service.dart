import 'package:flutter/services.dart';

class TruecallerService {
  static const platform = MethodChannel('');

  static Future<void> login() async {
    try {
      await platform.invokeMethod('loginWithTruecaller');
    } on PlatformException catch (e) {
      print("Failed to start Truecaller: '${e.message}'.");
    }

    platform.setMethodCallHandler((call) async {
      if (call.method == 'onSuccess') {
        final data = Map<String, dynamic>.from(call.arguments);
        print("Logged in: ${data['firstName']} ${data['phoneNumber']}");
      } else if (call.method == 'onFailure') {
        print("Login failed: ${call.arguments}");
      } else if (call.method == 'onVerificationRequired') {
        print("Manual verification required.");
      }
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

