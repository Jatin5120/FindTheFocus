import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final GetStorage _storage = GetStorage();

  static const String _isNewUserKey = 'isNewUser';
  static const String _isUserLoggedInKey = 'isUserLoggedIn';

  @override
  void onInit() {
    super.onInit();
    isUserLoggedIn = _storage.read<bool>(_isUserLoggedInKey) ?? false;
    isNewUser = _storage.read<bool>(_isNewUserKey) ?? true;
  }

  final RxBool _isUserLoggedIn = false.obs;
  final RxBool _isNewUser = true.obs;

  bool get isUserLoggedIn => _isUserLoggedIn.value;
  set isUserLoggedIn(bool isUserLoggedIn) =>
      _isUserLoggedIn.value = isUserLoggedIn;

  bool get isNewUser => _isNewUser.value;
  set isNewUser(bool isNewUser) => _isNewUser.value = isNewUser;

  writeUserLoggedIn(bool value) => _storage.write(_isUserLoggedInKey, value);

  writeNewUser(bool value) => _storage.write(_isNewUserKey, value);
}
