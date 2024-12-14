/**
 * Created by Abdullah on 14/12/24.
 */


class PromotionalBannerDeleteRequestEntity {
  String? id;

  PromotionalBannerDeleteRequestEntity({
    this.id,
  });

  PromotionalBannerDeleteRequestEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }

}
