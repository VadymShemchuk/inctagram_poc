import 'package:insta_poc/api/instagram_api_service.dart';
import 'package:insta_poc/state_managment/common_events.dart';
import 'package:insta_poc/state_managment/presenter.dart';

class AppPresenter extends Presenter {
  final InstagramApiService _instagramApiService;
  AppPresenter(this._instagramApiService) : super();

  void checkToken() async {
    await _instagramApiService.restore();
    if (_instagramApiService.checkLongToken()) {
      next(UploadMediasEvent());
    } else {
      next(OauthEvent());
    }
  }
}

extension Output on AppPresenter {
  get isLoading => _instagramApiService.isLoading;
}
