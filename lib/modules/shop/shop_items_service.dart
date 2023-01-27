import 'package:insta_poc/api/media_caption_model.dart';
import 'package:insta_poc/api/media_model.dart';
import 'package:insta_poc/api/tag_model.dart';
import 'package:insta_poc/state_managment/service.dart';

class ShopItemsService extends Service {
  final List<InstagramMediaModel> _shopItems = [];
  final List<InstagramMediaCaptionModel> _shopItemsCaptions = [];
  final List<String> _tags = [];
  final List<String> _captionItems = [];
  final List<TagModel> _tagsNames = [];
  int _itemsLength = 0;
  bool isItemsUploaded = false;

  ShopItemsService() : super();

  void addShopItem(InstagramMediaModel item) {
    _shopItems.add(item);
    _checkItemsUpdated(_shopItems.length);
  }

  void addCaption(String caption) {
    _captionItems.add(caption);
  }

  void _addItemsTags(List<TagModel> tags) {
    _tagsNames.addAll(tags);
  }

  void addShopItemsCaptions(List<InstagramMediaCaptionModel> captions) {
    _shopItemsCaptions.addAll(captions);
    _itemsLength = _shopItemsCaptions.length;
    for (var e in _shopItemsCaptions) {
      _findTag(e.caption);
    }
    List<TagModel> tagsItems = _tags.map((e) => TagModel(tagName: e)).toList();
    _addItemsTags(tagsItems);
  }

  void _findTag(String text) {
    RegExp exp = RegExp(r"\B#\w\w+");
    exp.allMatches(text).forEach((match) {
      if (!_tags.contains(match.group(0))) {
        _tags.add(match.group(0)!);
      }
    });
  }

  void _checkItemsUpdated(int currentLength) {
    if (currentLength < _itemsLength) {
      return;
    } else {
      isItemsUploaded = true;
      updateState();
    }
  }
}

extension Output on ShopItemsService {
  List<InstagramMediaModel> get shopItems => _shopItems;
  List<InstagramMediaCaptionModel> get mediaCaptions => _shopItemsCaptions;
  List<String> get captionsItems => _captionItems;
  List<TagModel> get tagsNames => _tagsNames;
}
