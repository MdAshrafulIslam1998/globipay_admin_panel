class LevelModel {
  String? levelName;
  int? levelValue;
  double? minThresh;
  double? maxThresh;
  String? createdBy;
  DateTime? date;

  LevelModel({
    this.levelName,
    this.levelValue,
    this.minThresh,
    this.maxThresh,
    this.createdBy,
    this.date,
  });

  // From JSON constructor
  LevelModel.fromJson(Map<String, dynamic> json) {
    levelName = json['level_name'];
    levelValue = json['level_value'];
    minThresh = json['min_thresh']?.toDouble();
    maxThresh = json['max_thresh']?.toDouble();
    createdBy = json['created_by'];
    date = json['date'] != null ? DateTime.parse(json['date']) : null;
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level_name'] = levelName;
    data['level_value'] = levelValue;
    data['min_thresh'] = minThresh;
    data['max_thresh'] = maxThresh;
    data['created_by'] = createdBy;
    return data;
  }
}