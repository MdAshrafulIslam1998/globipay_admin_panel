import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/pending_profile/pending_profile.dart';
import 'package:globipay_admin_panel/modules/pending_profile/pending_profile_response.dart';

class PendingProfileController extends BaseController {
  Rx<ProfileData?> profileData = Rx<ProfileData?>(null);

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }


  void loadProfileData() {
    // Mock API response for testing
    var mockResponse = {
      "responseCode": "S100000",
      "responseMessage": "User profile fetched successfully",
      "data": {
        "email": "jhn@example.com",
        "full_name": "John Doe",
        "phone": "1234567890",
        "dob": "1990-01-01",
        "gender": "MALE",
        "address": "123 Main St",
        "level": 12,
        "status": "REJECTED",
        "selfie_path":
            "https://www.shutterstock.com/image-vector/man-character-face-avatar-glasses-600nw-542759665.jpg",
        "front_id_path":
            "https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_640.png",
        "back_id_path":
            "https://5.imimg.com/data5/UF/GX/GLADMIN-63025529/adhar-card-service-500x500.png"
      }
    };

    // Parse the mock response
    profileData.value = PendingProfileResponse.fromJson(mockResponse).data;
  }

  void onApprove() {
    print('Approve button clicked!');
    // Additionally call your actual API call to approve profile
  }

  void onPending() {
    print('Pending button clicked!');
    // Additionally call your actual API call to set profile to pending
  }

  void onRemove() {
    print('Delete button clicked!');
    // Additionally call your actual API call to delete profile
    // Consider adding confirmation dialog before deletion
  }
}
