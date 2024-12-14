import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/model/pagination_request.dart';
import 'package:globipay_admin_panel/core/utils/custom_dialog.dart';
import 'package:globipay_admin_panel/core/utils/extensions.dart';
import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/request/promotional/add_promotional_banner_request_entity.dart';
import 'package:globipay_admin_panel/entity/request/promotional_banner_delete/promotional_banner_delete_entity.dart';
import 'package:globipay_admin_panel/entity/response/promotional/add_promotional_banner_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/promotional/promotional_banner_item.dart';
import 'package:globipay_admin_panel/entity/response/promotional/promotional_banner_response_entity.dart';
import 'package:globipay_admin_panel/router/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as Web;
class PromotionalBannerController extends BaseController {
  final AppRepository repository;
  PromotionalBannerController(this.repository);

  // Observable list of banners
  final RxList<PromotionalBannerItem> banners = <PromotionalBannerItem>[].obs;

  // Loading and error states
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Image picker
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchActiveBanners();
  }

  // Fetch active banners

  PromotionalBannerDeleteRequestEntity deleteRequestEntity(String bId) => PromotionalBannerDeleteRequestEntity(
    id: bId
  );

  // Delete banner
   deleteBanner(String bannerId) async {
     final req = deleteRequestEntity(bannerId);
     final repo = repository.requestToRemoveBanner(req);
     callService(repo, onSuccess: (response) {
       showCustomDialog(
         'Promotional Banner deleted successfully',
         positiveButtonText: 'OK',
         positiveButtonAction: () {
           fetchActiveBanners();
         },
       );
     });

  }

  void parseAddPromotionalBannerResponse(
    AddPromotionalBannerResponseEntity response,
  ) {
    if(response.id != null) {
      showCustomDialog(
          'Promotional Banner added successfully',
        positiveButtonText: 'OK',
        positiveButtonAction: () {},
      );
    }
  }
  void parsePromotionalBannerResponse(PromotionalBannerResponseEntity response) {
    banners.clear();
    banners.value = response.sliders ?? [];
  }


  void addBanner({
    required String title,
    required String description,
    required Color backgroundColor,
    required Web.File? imageFile,
    required Uint8List? imageFileBytes,
    required DateTime startDate,
    required DateTime endDate,
    required bool isVisibleToAll,
    required double priority,
    required String destinationUrl,
  }) async{


    final imageUploadPath = await requestToUploadImage(imageFileBytes);
    if(imageUploadPath != null && imageUploadPath.isNotEmpty){

      final req = AddPromotionalBannerRequestEntity(
        title: title,
        subtitle: description,
        createdBy: 'admin',
        sendType: isVisibleToAll ? "ALL" : "SPECIFIC",
        sendTo: null,
        action: destinationUrl,
        fromDate: startDate.toIso8601String(),
        toDate: endDate.toIso8601String(),
        sliderIndex: priority.toInt(),
        picture: imageUploadPath,
        bgColor: backgroundColor.colorToHex(),
      );

      requestToAddPromotionalBanner(req);
    }else{
      showCustomDialog(
        'Could not parse image data',
        positiveButtonText: 'OK',
        positiveButtonAction: () {},
      );
    }
  }



  PaginationRequest promotionBannerRequest = PaginationRequest(
    page: 1,
    limit: 200,
  );

  //Network Call
  void requestToAddPromotionalBanner(AddPromotionalBannerRequestEntity req) {
    final promotionBannerRequest = req;
    final repo =
        repository.requestToAddPromotionalBanner(promotionBannerRequest);
    callService(repo, onSuccess: (AddPromotionalBannerResponseEntity response) {
      parseAddPromotionalBannerResponse(response);
    });
  }

  Future<void> fetchActiveBanners() async {
    final repo = repository.requestForAllPromotionalBanner(promotionBannerRequest);
    callService(repo, onSuccess: (response){
      parsePromotionalBannerResponse(response);
    });

  }

  Future<String?> requestToUploadImage(Uint8List? imageFileBytes) {
    Completer<String> completer = Completer();
    try{
      if(imageFileBytes == null){
        completer.complete("");
        return completer.future;
      }
      final req = byteFieUploadRequest(imageFileBytes, 'promo_banner');
      final repo = repository.requestToByteFileUpload(req);
      callService(
        repo,
        onSuccess: (response) {
          completer.complete(response.url);
        },
      );
    }catch(e){
      appPrint(e);
      completer.complete("");
    }
    return completer.future;

  }




}
