import 'package:insta_poc/api/media_model.dart';
import 'package:insta_poc/api/tag_model.dart';
import 'package:insta_poc/modules/shop/shop_items_service.dart';
import 'package:insta_poc/state_managment/presenter.dart';

class ShopPresenter extends Presenter {
  final ShopItemsService _itemsService;
  ShopPresenter(this._itemsService) : super();
}

extension Output on ShopPresenter {
  List<InstagramMediaModel> get shopItems => _itemsService.shopItems;
  List<String> get captionItems => _itemsService.captionsItems;
  List<TagModel> get tags => _itemsService.tagsNames;
}
