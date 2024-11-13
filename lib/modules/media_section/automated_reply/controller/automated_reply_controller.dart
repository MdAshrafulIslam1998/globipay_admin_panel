import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/modules/media_section/automated_reply/category.dart';
import 'package:globipay_admin_panel/modules/media_section/automated_reply/category_response.dart';

class AutomatedReplyController extends BaseController {
  var categories = <Category>[].obs;
  var automatedReplies = <int, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Mock API fetch
  void fetchCategories() async {
    print(
        'Fetching categories...'); // Add this line to check if the function is called

    await Future.delayed(Duration(seconds: 1));

    var mockResponse = {
      "responseCode": "S100000",
      "responseMessage": "Categories fetched successfully",
      "data": {
        "categories": [
          {
            "id": 1,
            "name": "Zelle",
            "image":
                "https://img.icons8.com/?size=512&id=Iirw95F6Nl9c&format=png",
            "created_by": "your_user_id"
          },
          {
            "id": 2,
            "name": "Cash app",
            "image":
                "https://pbs.twimg.com/profile_images/1835765367366422528/Kh5n4dTt_400x400.jpg",
            "created_by": "your_user_id"
          },
          {
            "id": 3,
            "name": "GPay",
            "image":
                "https://static.vecteezy.com/system/resources/previews/013/948/549/non_2x/google-logo-on-transparent-white-background-free-vector.jpg",
            "created_by": "Admin"
          },
          {
            "id": 15,
            "name": "Apple Pay",
            "image":
                "https://cdn.iconscout.com/icon/free/png-512/free-apple-pay-logo-icon-download-in-svg-png-gif-file-formats--payment-method-social-media-pack-design-development-icons-4069416.png?f=webp&w=256",
            "created_by": "your_user_id"
          },
          {
            "id": 15,
            "name": "Apple Pay",
            "image":
                "https://cdn.iconscout.com/icon/free/png-512/free-apple-pay-logo-icon-download-in-svg-png-gif-file-formats--payment-method-social-media-pack-design-development-icons-4069416.png?f=webp&w=256",
            "created_by": "your_user_id"
          }
        ],
        "pagination": {
          "total": 4,
          "total_pages": 1,
          "current_page": 1,
          "limit": 10
        }
      }
    };

    var response = CategoryResponse.fromJson(mockResponse);
    categories.assignAll(response.categories);

    print(
        'Categories fetched: ${categories.length}'); // Add this line to check if categories are populated
  }

  void saveReply(int categoryId, String reply) {
    automatedReplies[categoryId] = reply;
    Get.snackbar(
        'Success', 'Automated reply saved for category ID $categoryId');
  }
}
