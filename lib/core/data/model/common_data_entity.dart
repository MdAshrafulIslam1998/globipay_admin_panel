/**
 * Created by Abdullah on 15/12/24.
 */

class CommonDataEntity{
   String? key;
   String? value;
   dynamic extra;

  CommonDataEntity({
     this.key,
     this.value,
     this.extra,
  });

  factory CommonDataEntity.fromJson(Map<String, dynamic> json) {
    return CommonDataEntity(
      key: json['key'],
      value: json['value'],
      extra: json['extra'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'extra': extra,
    };
  }

}