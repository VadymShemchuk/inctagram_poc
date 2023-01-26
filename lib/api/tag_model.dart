class TagModel {
  final String tagName;
  bool isTagChecked;

  TagModel({
    required this.tagName,
    this.isTagChecked = false,
  });

  factory TagModel.fromJson(String tag) => TagModel(tagName: tag);
}
