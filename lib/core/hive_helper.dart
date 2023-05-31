
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static late Box box ;
  // static var box;
  static Future<void> hiveInit() async {
    await Hive.initFlutter();
    
  }

  // static String? boxName;
  static Future<void> openBox({String? boxName}) async {
    box = await Hive.openBox(boxName!);
  }

  static Future<void> setData({
    String? key,
    String? value,
  }) async {
    box.put(key, value);
  }

  static String? getData({
    String? key,
  }) {
    return box.get(key);
  }

  
}
