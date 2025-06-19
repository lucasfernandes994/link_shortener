import 'package:core/src/storage/local_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: LocalStorage)
class LocalStorageImpl implements LocalStorage {
  @override
  Future<bool> saveString(String key, String value) async {
    final _preferences = await SharedPreferences.getInstance();
    return await _preferences.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    final _preferences = await SharedPreferences.getInstance();
    return await _preferences.getString(key);
  }

  @override
  Future<bool> remove(String key) async {
    final _preferences = await SharedPreferences.getInstance();
    return await _preferences.remove(key);
  }
}
