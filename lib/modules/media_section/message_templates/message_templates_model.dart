import 'package:globipay_admin_panel/entity/response/category/category_item_entity.dart';

/**
 * Created by Abdullah on 14/12/24.
 */

class MessageTemplatesModel {
  final String id;
  final String title;
  final String description;
  final CategoryItemEntity category;


  MessageTemplatesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
  });

}