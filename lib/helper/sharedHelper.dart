
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._();

  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static final id = SharedPrefValue<int>('id', prefs);
  static final userId = SharedPrefValue<String>('user_id', prefs);
  static final isLoggedIn = SharedPrefValue<bool>('is_logged_in', prefs);
  static final email = SharedPrefValue<String>('email', prefs);
  static final firstName = SharedPrefValue<String>('first_name', prefs);
  static final lastName = SharedPrefValue<String>('last_name', prefs);
  static final phone = SharedPrefValue<String>('phone', prefs);
  static final accessToken = SharedPrefValue<String>('access_token', prefs);
  static final refreshToken = SharedPrefValue<String>('refresh_token', prefs);
  static final verificationPending = SharedPrefValue<bool>('verification_pending', prefs);
  static final verificationPhone = SharedPrefValue<bool>('verification_hone', prefs);


  static void clear() {
    prefs.clear();
  }
}

class SharedPrefValue<T> {
  final String key;
  final SharedPreferences prefs;

  SharedPrefValue(this.key, this.prefs);

  ///Sets a value to the key provided in constructor
  void set(T value) {
    switch (T) {
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      case bool:
        prefs.setBool(key, value as bool);
        break;
    }
  }

  ///Returns the value from Shared Preferences if present,
  ///and returns null otherwise
  T? getSafe() {
    return prefs.get(key) as T?;
  }

  ///Returns the value from Shared Preferences if present,
  ///and returns a default provided in arguments otherwise
  T getOrDefault(T def) {
    return getSafe() ?? def;
  }

  ///Returns value from Shared Preferences if present,
  ///and returns a default value otherwise.
  ///Default values for different data types:
  ///int -> -1,
  ///String -> "",
  ///bool -> false,
  T get() {
    return getSafe() ?? _getDefaultValues();
  }

  T _getDefaultValues() {
    switch (T) {
      case int:
        return -1 as T;
      case String:
        return "" as T;
      case bool:
        return false as T;
      default:
        throw Exception('Unrecognized Type T');
    }
  }

  ///Removes value from Shared Preferences
  void clear() {
    prefs.remove(key);
  }
}
