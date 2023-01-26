extension _Constants on InstagramMediaModel {
  static const keyId = 'id';
  static const keyType = 'media_type';
  static const keyUrl = 'media_url';
  static const keyUsername = 'username';
  static const keyTimestamp = 'timestamp';
}

class InstagramMediaModel {
  String id;
  String type;
  String url;
  String username;
  String timestamp;
  String caption;
  bool isHaveTag;
  InstagramMediaModel({
    required this.caption,
    required this.id,
    required this.type,
    required this.url,
    required this.username,
    required this.timestamp,
    this.isHaveTag = false,
  });

  factory InstagramMediaModel.fromJson(
          Map<String, dynamic> json, String caption) =>
      InstagramMediaModel(
        caption: caption,
        id: json[_Constants.keyId],
        type: json[_Constants.keyType],
        url: json[_Constants.keyUrl],
        username: json[_Constants.keyUsername],
        timestamp: json[_Constants.keyTimestamp].toString(),
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      _Constants.keyId: id,
      _Constants.keyType: type,
      _Constants.keyUrl: url,
      _Constants.keyUsername: username,
      _Constants.keyTimestamp: DateTime.now(),
    };
  }
}
