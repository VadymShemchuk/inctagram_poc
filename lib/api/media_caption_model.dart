extension _Constants on InstagramMediaCaptionModel {
  static const keyId = 'id';
  static const keyCaption = 'caption';
}

class InstagramMediaCaptionModel {
  String id;
  String caption;
  InstagramMediaCaptionModel({
    required this.id,
    required this.caption,
  });

  factory InstagramMediaCaptionModel.fromJson(Map<String, dynamic> json) =>
      InstagramMediaCaptionModel(
        caption: json[_Constants.keyCaption],
        id: json[_Constants.keyId],
      );
}
