import 'package:hive/hive.dart';

/**
 * Created by Abdullah on 13/10/24.
 */

class AppStorage {
  final boxName;
  late final Box _box;
  AppStorage(this.boxName){
    init();
  }

  Future<void> init() async {
    _box = await Hive.openBox(boxName);
  }

  close() {
    _box.close();
  }

  read({key}) async {
    // final box = await Hive.openBox(boxName);

    return _box.get(key) ?? "";
  }

  Future<Map<dynamic, dynamic>> readAll({key}) async {
    // var box = await Hive.openBox(boxName);

    return _box.toMap();
  }

  Future<Map<String, dynamic>> readAllLanguage({key}) async {
    // var box = await Hive.openBox(boxName);

    return _box.toMap().cast<String, dynamic>();
  }

  write({key, value}) async {
    // final box = await Hive.openBox(boxName);
    _box.put(key, value);
  }

  saveAll(Map<String, dynamic> values) async {
    // var box = await Hive.openBox(boxName);
    await _box.putAll(values);
  }

  saveAndReplace(Map<String, dynamic> values) async {
    // var box = await Hive.openBox(boxName);
    await _box.clear();
    await _box.putAll(values);
  }

  delete({key}) async {
    //  _box = await Hive.openBox(boxName);

    _box.delete(key);
  }

  clearAll() async {
    // var box = await Hive.openBox(boxName);
    await _box.clear();
  }
}