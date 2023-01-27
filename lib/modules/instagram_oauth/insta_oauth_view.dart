import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insta_poc/modules/instagram_oauth/insta_oauth_presenter.dart';
import 'package:insta_poc/state_managment/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _Constants {
  static const Map<String, String> heder = {
    'accept':
        'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'user-agent':
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36',
    'upgrade-insecure-requests': '1',
    'accept-encoding': 'gzip, deflate, br',
    'accept-language': 'en-US,en;q=0.9,en;q=0.8'
  };
}

class OauthView extends View {
  const OauthView(super.context, {super.key});

  OauthPresenter get presenter => context.read();

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      resizeToAvoidBottomInset: true,
      url: presenter.oauthUrl,
      headers: _Constants.heder,
    );
  }
}
