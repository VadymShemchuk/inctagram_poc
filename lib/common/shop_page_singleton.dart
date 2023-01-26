import 'dart:async';

class TagsStream {
  TagsStream._();

  static final StreamController<List<String>> _onTagsChangedController =
      StreamController<List<String>>.broadcast();
  static Stream<List<String>> get onTagsAdd => _onTagsChangedController.stream;

  static void tagChanged(List<String> tag) {
    _onTagsChangedController.add(tag);
  }
}
