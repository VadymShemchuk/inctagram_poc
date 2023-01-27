import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insta_poc/api/api_constants/api_constants.dart';
import 'package:insta_poc/api/api_constants/api_keys.dart';
import 'package:insta_poc/api/media_caption_model.dart';
import 'package:insta_poc/modules/shop/shop_items_service.dart';
import 'package:insta_poc/state_managment/service.dart';
import 'package:insta_poc/store/store_consts.dart';
import 'package:insta_poc/store/store_utils.dart';

import 'media_model.dart';

class _Keys {
  /// [scopeKey] choose what kind of data you're wishing to get.
  /// [responseTypeKey] I recommend only 'code', I try on DEV MODE with token, it wasn't working.
  static const String scopeKey = 'user_profile,user_media';
  static const String responseTypeKey = 'code';
}

class InstagramApiService extends Service {
  final ShopItemsService _itemsService;

  InstagramApiService(this._itemsService) : super();

  /// [oauthUrl] simply the url used to communicate with Instagram API at the beginning.
  String? shortAccessToken;
  String? authorizationCode;
  String oauthUrl = '';

  void getOauthUrl() {
    oauthUrl =
        '${ApiConstants.instagramOAuth}${ApiKey.clientIDKey}=${ApiConstants.clientID}&'
        '${ApiKey.redirectUriKey}=${ApiConstants.redirectUri}&${ApiKey.scopeKey}='
        '${_Keys.scopeKey}&${ApiKey.responseTypeKey}=${_Keys.responseTypeKey}';
  }

  /// Presets your required fields on each call api.
  /// Please refers to https://developers.facebook.com/docs/instagram-basic-display-api/reference .
  List<String> userFields = ['id', 'username'];
  List<String> mediasListFields = ['id', 'caption'];
  List<String> mediaFields = [
    'id',
    'media_type',
    'media_url',
    'username',
    'timestamp'
  ];

  void getAuthorizationCode(String url) {
    /// Parsing the code from string url.
    authorizationCode = url
        .replaceAll('${ApiConstants.redirectUri}?code=', '')
        .replaceAll('#_', '');
  }

  Future<bool> getTokenAndUserID() async {
    final http.Response response =
        await http.post(Uri.parse(ApiConstants.instagramAsesTokenUrl), body: {
      ApiKey.clientIDKey: ApiConstants.clientID, //'579319840358175'
      ApiKey.redirectUriKey: ApiConstants.redirectUri,
      ApiKey.clientSecretKey: ApiConstants.appSecret,
      ApiKey.codeKey: authorizationCode,
      ApiKey.grantTypeKey: ApiConstants.grantTypeValue
    });
    shortAccessToken = json.decode(response.body)[ApiKey.accesTokenKey];
    ApiConstants.userID ??=
        json.decode(response.body)[ApiKey.userIdKey].toString();
    return (shortAccessToken != null) ? true : false;
  }

  Future<Map<String, dynamic>> getMediaDetails(
      String mediaID, String token) async {
    final String fields = mediaFields.join(',');
    final http.Response responseMediaSingle = await http.get(Uri.parse(
        '${ApiConstants.instagramGraphUrl}$mediaID?fields=$fields&access_token=$token'));
    return json.decode(responseMediaSingle.body);
  }

  void getAllMedias() async {
    String token = '';
    if (ApiConstants.longToken != null) {
      token = ApiConstants.longToken!;
    } else if (shortAccessToken != null) {
      token = shortAccessToken!;
    }
    try {
      final String fields = mediasListFields.join(',');
      final http.Response responseMedia = await http.get(Uri.parse(
          'https://graph.instagram.com/${ApiConstants.userID}/media?fields=$fields&access_token=$token'));
      Map<String, dynamic> instagramData = json.decode(responseMedia.body);
      List<dynamic> values = instagramData['data'];
      List<InstagramMediaCaptionModel> captions = values
          .map((e) =>
              InstagramMediaCaptionModel.fromJson((e as Map<String, dynamic>)))
          .toList();
      _itemsService.addShopItemsCaptions(captions);
      _getMediaItems(values, token);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void _getMediaItems(List<dynamic> values, String token) {
    for (var e in values) {
      (e as Map<String, dynamic>).forEach((key, value) async {
        if (key == 'id') {
          Map<String, dynamic> json = await getMediaDetails(value, token);
          InstagramMediaModel mediaItem =
              InstagramMediaModel.fromJson(json, getMediaCaption(value));
          _itemsService.addShopItem(mediaItem);
        }
      });
    }
  }

  Future<bool> exchangeShortToLongToken() async {
    final http.Response response = await http.get(Uri.parse(
        'https://graph.instagram.com/access_token?grant_type=ig_exchange_token&client_secret=${ApiConstants.appSecret}&access_token=$shortAccessToken'));
    Map<String, dynamic> result = json.decode(response.body);
    final String? longToken = result['access_token'];
    final int? expiresTime = result['expires_in'];
    if (longToken != null) {
      ApiConstants.longToken = longToken;
      ApiConstants.expiresInSeconds = expiresTime;
      saveToken(longToken);
      saveExpiresTime(expiresTime);
    }

    return (longToken != null && expiresTime != null) ? true : false;
  }

  Future<bool> refreshLongToken() async {
    final http.Response response = await http.get(Uri.parse(
        'https://graph.instagram.com/refresh_access_token?grant_type=ig_refresh_token&access_token=${ApiConstants.longToken}'));
    Map<String, dynamic> result = json.decode(response.body);
    final String? longToken = result['access_token'];
    final int? expiresTime = result['expires_in'];
    if (longToken != null) {
      ApiConstants.longToken = longToken;
      ApiConstants.expiresInSeconds = expiresTime;
      saveToken(longToken);
      saveExpiresTime(expiresTime);
    }
    return (longToken != null && expiresTime != null) ? true : false;
  }

  void saveToken(String token) {
    StoreUtils.setString(StoreStringId.longToken, token);
  }

  void saveExpiresTime(int? expiresTime) {
    String datetime = DateTime.now().toString();
    StoreUtils.setInt(StoreIntId.expiresInSeconds, expiresTime);
    StoreUtils.setString(StoreStringId.dateTokenProvided, datetime);
  }

  Future<bool> getLongToken() async {
    ApiConstants.longToken =
        await StoreUtils.getString(StoreStringId.longToken);
    return ApiConstants.longToken != null ? true : false;
  }

  String getMediaCaption(String id) {
    String caption = '';
    for (var model in _itemsService.mediaCaptions) {
      if (model.id == id) {
        caption = model.caption;
      }
    }
    _itemsService.addCaption(caption);
    return caption;
  }
}
