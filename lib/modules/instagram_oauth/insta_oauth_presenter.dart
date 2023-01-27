import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insta_poc/api/api_constants/api_constants.dart';
import 'package:insta_poc/api/instagram_api_service.dart';
import 'package:insta_poc/state_managment/common_events.dart';
import 'package:insta_poc/state_managment/presenter.dart';

class OauthPresenter extends Presenter {
  final InstagramApiService _instagramApiService;
  final _flutterWebviewPlugin = FlutterWebviewPlugin();
  OauthPresenter(this._instagramApiService) : super() {
    _launchWebview();
    _onPluginSubscription();
  }

  void _launchWebview() {
    _flutterWebviewPlugin.launch(_instagramApiService.oauthUrl);
  }

  void _onPluginSubscription() {
    _flutterWebviewPlugin.onUrlChanged.listen((url) async {
      _instagramApiService.setLoaderOn();
      if (url.contains(ApiConstants.redirectUri)) {
        _instagramApiService.getAuthorizationCode(url);
        _instagramApiService.getTokenAndUserID().then((isDone) {
          if (isDone) {
            _instagramApiService.getAllMedias().then((_) {
              _flutterWebviewPlugin.close();
              _instagramApiService.exchangeShortToLongToken();
              next(ShopEvent());
            });
          }
        });
      }
    });
  }
}

extension Output on OauthPresenter {
  get oauthUrl => _instagramApiService.oauthUrl;
}
