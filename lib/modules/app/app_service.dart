import 'package:insta_poc/state_managment/service.dart';

extension _Consts on AppService {
  static const isAppFirtsOpenedDefaultValue = true;
  static const isOnboardingFinished = false;
}

class AppService extends Service {
  var _isFirstOpening = true;
  var _isOnboardingDone = false;

  AppService() : super();
}

extension Output on AppService {
  bool get isFirstTime => _isFirstOpening;
  bool get isOnboardingDone => _isOnboardingDone;
}

extension Input on AppService {
  void setFirstOpening() {
    if (_isFirstOpening == false) return;
    _isFirstOpening = false;
    _store();
  }

  void setOnboardingDone() {
    _isOnboardingDone = true;
    _store();
  }
}

extension _Storing on AppService {
  void _store() async {}

  void get _restore async {
    setLoaderOn();
    // _isFirstOpening = await StoreUtils.getBool(StoreBoolId.isAppFirtsOpened) ??
    //     _Consts.isAppFirtsOpenedDefaultValue;
    // _isOnboardingDone =
    //     await StoreUtils.getBool(StoreBoolId.isOnboardingFinished) ??
    //         _Consts.isOnboardingFinished;
    setLoaderOff();
  }
}
