import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insta_poc/api/api_constants/api_constants.dart';
import 'package:insta_poc/api/instagram_api_service.dart';
import 'package:insta_poc/modules/app/loading_service.dart';
import 'package:insta_poc/state_managment/common_events.dart';
import 'package:insta_poc/state_managment/presenter.dart';

class OauthPresenter extends Presenter {
  final InstagramApiService _instagramApiService;
  final LoaderServise _loaderServise;
  final _flutterWebviewPlugin = FlutterWebviewPlugin();
  OauthPresenter(this._instagramApiService, this._loaderServise) : super() {
    _launchWebview();
    _onPluginSubscription();
  }

  void _launchWebview() {
    _flutterWebviewPlugin.launch(_instagramApiService.oauthUrl);
  }

  void _onPluginSubscription() {
    _flutterWebviewPlugin.onUrlChanged.listen((url) async {
      _loaderServise.show();
      if (url.contains(ApiConstants.redirectUri)) {
        _instagramApiService.getAuthorizationCode(url);
        _instagramApiService.getTokenAndUserID().then((isDone) {
          if (isDone) {
            _instagramApiService.getAllMedias();
            _flutterWebviewPlugin.close();
            _instagramApiService.exchangeShortToLongToken();
            _loaderServise.hide();
            next(ShopEvent());
          }
        });
      }
    });
  }
}

extension Output on OauthPresenter {
  get oauthUrl => _instagramApiService.oauthUrl;
}
