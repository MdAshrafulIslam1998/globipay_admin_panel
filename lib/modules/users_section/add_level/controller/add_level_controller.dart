import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globipay_admin_panel/core/base/base_controller.dart';
import 'package:globipay_admin_panel/core/data/local/repository/token_repository.dart';
import 'package:globipay_admin_panel/core/di/injector.dart';
import 'package:globipay_admin_panel/core/utils/custom_dialog.dart';
import 'package:globipay_admin_panel/data/repository/app_repository.dart';
import 'package:globipay_admin_panel/entity/request/level/add_level_request_entity.dart';
import 'package:globipay_admin_panel/entity/response/level/level_item_response_entity.dart';
import 'package:globipay_admin_panel/entity/response/level/level_response_entity.dart';


class AddLevelController extends BaseController {
  // Dependencies
  final TokenRepository tokenRepository = Injector.resolve<TokenRepository>();

  final AppRepository appRepository;

  AddLevelController(this.appRepository);
  // Observable list to track levels
  RxList<LevelItemResponseEntity> levels = <LevelItemResponseEntity>[].obs;

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  // Text controllers for form fields
  final TextEditingController levelNameController = TextEditingController();
  final TextEditingController levelValueController = TextEditingController();
  final TextEditingController minThreshController = TextEditingController();
  final TextEditingController maxThreshController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Fetch existing levels when controller initializes
    fetchLevels();
  }


  parseLevelResponse(LevelResponseEntity response) {
     levels.value = response.levels ?? [];
  }


  void addLevel() {

    if(formKey.currentState!.validate()){
      requestToAddLevel();
    }
  }

  // Validate and submit new level

  AddLevelRequestEntity generateLevelRequest(String sId) {
    return AddLevelRequestEntity(
      levelName: levelNameController.text,
      levelValue: int.parse(levelValueController.text),
      minThresh: double.parse(minThreshController.text),
      maxThresh: double.parse(maxThreshController.text),
      createdBy: sId, // Use actual user ID
    );
  }

  AddLevelRequestEntity generateEditLevelRequest({
    required String sId,
    required String levelName,
    required int levelValue,
    required double minThresh,
    required double maxThresh,

  }) {
    return AddLevelRequestEntity(
      levelName: levelName,
      levelValue: levelValue,
      minThresh: minThresh,
      maxThresh: maxThresh,
      createdBy: sId,
    );
  }


  levelRemove(LevelItemResponseEntity model){
    askForConfirmation(
        message: 'Do you want to remove this level?',
        onPositiveAction: () async {
          requestToRemoveLevel(model);
    },
    );

  }


  void requestToRemoveLevel(LevelItemResponseEntity level){
    final repo = appRepository.requestToRemoveLevel(level.levid.toString());
    callService(repo, onSuccess: (response) {
      showSnackBar(message: 'Level removed successfully', status: SnackBarStatus.SUCCESS);
      fetchLevels();
    });
  }


  void requestToAddLevel()async{
    final sId = await tokenRepository.getStuffId();
    final req = generateLevelRequest(sId);
    final repo = appRepository.requestToAddLevel(req);
    callService(repo, onSuccess: (response) {
      showSnackBar(message: 'Level added successfully', status: SnackBarStatus.SUCCESS);
      _clearForm();
      fetchLevels();

    });
  }

  void levelEdit(String id, String name, String value, String min, String max) async{
    int lValue = int.tryParse(value ) ?? 0;
    double lMin = double.tryParse(min, ) ?? 0.0;
    double lMax = double.tryParse(max, ) ?? 0.0;

    final sId = await tokenRepository.getStuffId();


    final req = generateEditLevelRequest(
        sId: sId,
        levelName: name,
        levelValue: lValue,
        minThresh: lMin,
        maxThresh: lMax
    );

    final repo = appRepository.requestToEditLevel(req, id);
    callService(repo, onSuccess: (response) {
      showSnackBar(message: 'Level updated successfully', status: SnackBarStatus.SUCCESS);
      fetchLevels();
    });

  }


  // Fetch existing levels from API
  Future<void> fetchLevels() async {
    final repo = appRepository.requestForAllLevel();
    callService(repo, onSuccess: (LevelResponseEntity response) {
      parseLevelResponse(response);
    });
  }

  // Clear form fields
  void _clearForm() {
    levelNameController.clear();
    levelValueController.clear();
    minThreshController.clear();
    maxThreshController.clear();
  }

  @override
  void onClose() {
    // Dispose controllers to prevent memory leaks
    levelNameController.dispose();
    levelValueController.dispose();
    minThreshController.dispose();
    maxThreshController.dispose();
    super.onClose();
  }



}