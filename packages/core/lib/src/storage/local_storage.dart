abstract class LocalStorage {
  Future<bool> saveString(String key, String value);

  Future<String?> getString(String key);

  Future<bool> remove(String key);
}
