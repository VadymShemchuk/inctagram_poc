import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

import 'package:insta_poc/api/media_caption_model.dart';
import 'package:insta_poc/api/tag_model.dart';

import 'media_model.dart';

class _Keys {
  /// [scopeKey] choose what kind of data you're wishing to get.
  /// [responseTypeKey] I recommend only 'code', I try on DEV MODE with token, it wasn't working.
  static const String scopeKey = 'user_profile,user_media';
  static const String responseTypeKey = 'code';
}

class ApiConstants {
  /// [clientID], [appSecret], [redirectUri] from facebook developer basic display panel.
  static const String clientID = '579319840358175';
  static const String appSecret = 'ac7b28a26809fe5c1d3450b19c261c4b';
  static const String redirectUri = 'https://www.mysite.com/';
  static const String userID = '17841457395149623';
  static const String longToken =
      'IGQVJXUlRBNU9fODh6N2xWdlRrZAWF3d2h4eDViNUJHaDZAhYVJQOUtGb0h3bEZAwbmJIN3JYUTl0MnpORmdDS3VMdXpSQUN2WDM0V1NVN0ZAvRzV5NHRnTlVjTW1oQVExRTZAWYVBLT2dR';
  static const int expiresInSeconds = 5179048;
}

class InstagramApi {
  /// [url] simply the url used to communicate with Instagram API at the beginning.
  static String? accessToken;
  // static String? userID;
  static String? authorizationCode;
  static const String graphuri = 'https://graph.instagram.com';
  static const String url =
      'https://api.instagram.com/oauth/authorize?client_id=${ApiConstants.clientID}&redirect_uri=${ApiConstants.redirectUri}&scope=${_Keys.scopeKey}&response_type=${_Keys.responseTypeKey}';
  Map<String, dynamic> mediasList = {};
  static List<InstagramMediaCaptionModel> mediaCaptions = [];
  static List<InstagramMediaModel> mediasResults = [];
  List<String> tags = [];
  static List<TagModel> tagsModels = [];

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
    /// Request token.
    /// Set token.
    /// Returning status request as bool.
    final http.Response response = await http
        .post(Uri.parse("https://api.instagram.com/oauth/access_token"), body: {
      "client_id": ApiConstants.clientID,
      "redirect_uri": ApiConstants.redirectUri,
      "client_secret": ApiConstants.appSecret,
      "code": authorizationCode,
      "grant_type": "authorization_code"
    });
    accessToken = json.decode(response.body)['access_token'];
    // userID = json.decode(response.body)['user_id'].toString();
    print('777 token $accessToken');
    // print('777 userID $userID');
    return (accessToken != null) ? true : false; //&& userID != null
  }

  Future<Map<String, dynamic>> getMediaDetails(String mediaID) async {
    /// Parse according fieldsList.
    /// Request complete media informations.
    /// Returning the response as Map<String, dynamic>
    final String fields = mediaFields.join(',');
    final http.Response responseMediaSingle = await http.get(Uri.parse(
        'https://graph.instagram.com/$mediaID?fields=$fields&access_token=${ApiConstants.longToken}'));
    return json.decode(responseMediaSingle.body);
  }

  Future<List<InstagramMediaModel>> getAllMedias() async {
    /// Parse according fieldsList.
    /// Request instagram user medias list.
    /// Request for each media id the details.
    /// Set all medias as list Object.
    /// Returning the List<InstaMedia>.
    final String fields = mediasListFields.join(',');
    final http.Response responseMedia = await http.get(Uri.parse(
        'https://graph.instagram.com/${ApiConstants.userID}/media?fields=$fields&access_token=${ApiConstants.longToken}'));
    mediasList = json.decode(responseMedia.body);
    List<dynamic> values = mediasList['data'];
    mediaCaptions = values
        .map((e) =>
            InstagramMediaCaptionModel.fromJson((e as Map<String, dynamic>)))
        .toList();
    for (var e in mediaCaptions) {
      findTag(e.caption);
    }
    tagsModels = tags.map((e) => TagModel(tagName: e)).toList();

    for (var e in values) {
      (e as Map<String, dynamic>).forEach((key, value) async {
        if (key == 'id') {
          Map<String, dynamic> json = await getMediaDetails(value);
          InstagramMediaModel instaMedia =
              InstagramMediaModel.fromJson(json, getMediaCaption(value));
          mediasResults.add(instaMedia);
        }
      });
    }
    await Future.delayed(const Duration(seconds: 1), () {});
    return mediasResults;
  }

  Future<bool> exchangeShortToLongToken() async {
    final http.Response response = await http.get(Uri.parse(
        'https://graph.instagram.com/access_token?grant_type=ig_exchange_token&client_secret=${ApiConstants.appSecret}&access_token=$accessToken'));
    Map<String, dynamic> result = json.decode(response.body);
    final String? longToken = result['access_token'];
    final int? expiresInSeconds = result['expires_in'];
    return (longToken != null && expiresInSeconds != null) ? true : false;
  }

  Future<bool> refreshLongToken() async {
    final http.Response response = await http.get(Uri.parse(
        'https://graph.instagram.com/refresh_access_token?grant_type=ig_refresh_token&access_token=${ApiConstants.longToken}'));
    Map<String, dynamic> result = json.decode(response.body);
    final String? longToken = result['access_token'];
    final int? expiresInSeconds = result['expires_in'];
    return (longToken != null && expiresInSeconds != null) ? true : false;
  }

  void saveToken() {}

  // Future<Token> getToken() async {
  //   Stream<String> onCode = await _server();
  //   String url =
  //       "https://api.instagram.com/oauth/authorize?client_id=${ApiConstants.clientID}&redirect_uri=${ApiConstants.redirectUri}&response_type=code";
  //   final flutterWebviewPlugin = FlutterWebviewPlugin();
  //   flutterWebviewPlugin.launch(url);
  //   final String code = await onCode.first;
  //   final http.Response response = await http
  //       .post(Uri.parse("https://api.instagram.com/oauth/access_token"), body: {
  //     "client_id": ApiConstants.clientID,
  //     "redirect_uri": ApiConstants.redirectUri,
  //     "client_secret": ApiConstants.appSecret,
  //     "code": code,
  //     "grant_type": "authorization_code"
  //   });
  //   flutterWebviewPlugin.close();
  //   return Token.fromJson(jsonDecode(response.body));
  // }

  // Future<Stream<String>> _server() async {
  //   final StreamController<String> onCode = StreamController();
  //   HttpServer server =
  //       await HttpServer.bind(InternetAddress.loopbackIPv4, 8585);
  //   server.listen((HttpRequest request) async {
  //     final String code = request.uri.queryParameters["code"]!;
  //     request.response
  //       ..statusCode = 200
  //       ..headers.set("Content-Type", ContentType.html.mimeType)
  //       ..write("<html><h1>You can now close this window</h1></html>");
  //     await request.response.close();
  //     await server.close(force: true);
  //     onCode.add(code);
  //     await onCode.close();
  //   });
  //   return onCode.stream;
  // }

  String getMediaCaption(String id) {
    String caption = '';
    for (var model in mediaCaptions) {
      if (model.id == id) {
        caption = model.caption;
      }
    }
    return caption;
  }

  void findTag(String text) {
    RegExp exp = RegExp(r"\B#\w\w+");
    exp.allMatches(text).forEach((match) {
      if (!tags.contains(match.group(0))) {
        tags.add(match.group(0)!);
      }
    });
  }
}

class Token {
  String access;
  String id;
  String username;
  String fullName;
  String profilePicture;
  Token({
    required this.access,
    required this.id,
    required this.username,
    required this.fullName,
    required this.profilePicture,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      access: json['access_token'],
      id: json['user']['id'],
      username: json['user']['username'],
      fullName: json['user']['full_name'],
      profilePicture: json['user']['profile_picture'],
    );
  }
}
