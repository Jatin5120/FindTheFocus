import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';

class StorageController extends GetxController {
  final GetStorage _storage = GetStorage();

  static const String _isNewUserKey = 'isNewUser';
  static const String _isUserLoggedInKey = 'isUserLoggedIn';
  static const String _workTimeKey = 'workTime';

  @override
  void onInit() {
    super.onInit();
    isUserLoggedIn = _storage.read<bool>(_isUserLoggedInKey) ?? false;
    isNewUser = _storage.read<bool>(_isNewUserKey) ?? true;
    workTime = _storage.read<int>(_workTimeKey) ?? kInitialWorkMinutes;
  }

  final RxBool _isUserLoggedIn = false.obs;
  final RxBool _isNewUser = true.obs;
  final RxInt _workTime = 0.obs;

  int get workTime => _workTime.value;
  set workTime(int workTime) => _workTime.value = workTime;

  bool get isUserLoggedIn => _isUserLoggedIn.value;
  set isUserLoggedIn(bool isUserLoggedIn) =>
      _isUserLoggedIn.value = isUserLoggedIn;

  bool get isNewUser => _isNewUser.value;
  set isNewUser(bool isNewUser) => _isNewUser.value = isNewUser;

  writeUserLoggedIn(bool value) => _storage.write(_isUserLoggedInKey, value);

  writeNewUser(bool value) => _storage.write(_isNewUserKey, value);

  writeWorkTime(int value) => _storage.write(_workTimeKey, value);
}
