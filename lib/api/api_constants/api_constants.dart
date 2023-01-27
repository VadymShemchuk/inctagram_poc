class ApiConstants {
  static const instagramOAuth = 'https://api.instagram.com/oauth/authorize?';
  static const instagramAsesTokenUrl =
      'https://api.instagram.com/oauth/access_token';
  static const instagramGraphUrl = 'https://graph.instagram.com/';
  static const redirectUri = 'https://www.mysite.com/';
  static const grantTypeValue = 'authorization_code';

  static String? clientID;
  static String? appSecret;
  static String? userID;
  static String? longToken;
  static int? expiresInSeconds;
}
