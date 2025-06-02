import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocalStorageHelper {
  static const _boxName = 'settings';
  static const _isActiveKey = 'isActive';

  /// Initialize Hive (should be called from main and background handler)
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.openBox(_boxName);
  }

  /// Set store isActive flag
  static Future<void> setStoreActive(bool isActive) async {
    final box = Hive.box(_boxName);
    await box.put(_isActiveKey, isActive);
  }

  /// Get store isActive flag
  static bool getStoreActive() {
    final box = Hive.box(_boxName);
    return box.get(_isActiveKey, defaultValue: false);
  }
}
