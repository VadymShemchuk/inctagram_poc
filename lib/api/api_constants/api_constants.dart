import 'package:insta_poc/store/store_consts.dart';
import 'package:insta_poc/store/store_utils.dart';

class ApiConstants {
  static const instagramOAuth = 'https://api.instagram.com/oauth/authorize?';
  static const instagramAsesTokenUrl =
      'https://api.instagram.com/oauth/access_token';
  static const instagramGraphUrl = 'https://graph.instagram.com/';
  static const redirectUri = 'https://www.mysite.com/';
  static const grantTypeValue = 'authorization_code';

  static late String? clientID;
  static late String? appSecret; // = 'ac7b28a26809fe5c1d3450b19c261c4b';
  static late String? userID; // = '17841457395149623';
  static String? longToken;
  static int? expiresInSeconds;
}
