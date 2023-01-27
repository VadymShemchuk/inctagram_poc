import 'package:insta_poc/state_managment/service.dart';

class LoaderServise extends Service {
  LoaderServise() : super();
  void show() {
    setLoaderOn();
  }

  void hide() {
    setLoaderOff();
  }
}
