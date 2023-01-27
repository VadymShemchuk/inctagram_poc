import 'package:insta_poc/api/api_constants/api_constants.dart';
import 'package:insta_poc/api/instagram_api_service.dart';
import 'package:insta_poc/modules/app/loading_service.dart';
import 'package:insta_poc/modules/shop/shop_items_service.dart';
import 'package:insta_poc/state_managment/common_events.dart';
import 'package:insta_poc/state_managment/presenter.dart';
import 'package:insta_poc/store/store_consts.dart';
import 'package:insta_poc/store/store_utils.dart';

class RootPresenter extends Presenter {
  final InstagramApiService _instagramApiService;
  final LoaderServise _loaderServise;
  final ShopItemsService _itemsService;
  RootPresenter(
    this._instagramApiService,
    this._loaderServise,
    this._itemsService,
  ) : super();

  @override
  void subscribe() {
    _itemsService.stream.listen((_) {
      if (_itemsService.isItemsUploaded) {
        _loaderServise.hide();
        next(ShopEvent());
      }
    });
    super.subscribe();
  }

  void checkToken() async {
    await _restore();
    if (_checkLongToken()) {
      _instagramApiService.getOauthUrl();
      _loaderServise.show();
      _instagramApiService.getAllMedias();
    } else {
      _instagramApiService.getOauthUrl();
      next(OauthEvent());
    }
  }

  void loadItemsFromInstagramApi() {}

  bool _checkLongToken() {
    if (ApiConstants.longToken == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> _restore() async {
    ApiConstants.clientID = await StoreUtils.getString(StoreStringId.clientId);
    ApiConstants.appSecret =
        await StoreUtils.getString(StoreStringId.appSecret);
    ApiConstants.userID = await StoreUtils.getString(StoreStringId.userID);
    ApiConstants.longToken =
        await StoreUtils.getString(StoreStringId.longToken);
    ApiConstants.expiresInSeconds =
        await StoreUtils.getInt(StoreIntId.expiresInSeconds);
  }
}
