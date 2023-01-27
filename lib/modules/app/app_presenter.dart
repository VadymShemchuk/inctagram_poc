import 'package:insta_poc/modules/app/loading_service.dart';
import 'package:insta_poc/state_managment/presenter.dart';

class AppPresenter extends Presenter {
  final LoaderServise _loaderServise;
  AppPresenter(
    this._loaderServise,
  );
}

extension Output on AppPresenter {
  get isLoading => _loaderServise.isLoading;
}
