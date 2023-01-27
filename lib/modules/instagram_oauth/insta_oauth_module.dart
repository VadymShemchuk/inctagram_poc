import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_poc/common/utils/router_util.dart';
import 'package:insta_poc/modules/instagram_oauth/insta_oauth_presenter.dart';
import 'package:insta_poc/modules/instagram_oauth/insta_oauth_view.dart';
import 'package:insta_poc/modules/shop/shop_module.dart';
import 'package:insta_poc/state_managment/basic_states.dart';
import 'package:insta_poc/state_managment/common_events.dart';

class OauthModule extends StatelessWidget {
  const OauthModule({super.key});

  @override
  Widget build(context) => _provider;

  Widget get _provider => BlocProvider(
        create: (context) => OauthPresenter(
          context.read(),
        ),
        child: BlocConsumer<OauthPresenter, BasicState>(
          buildWhen: (_, current) => current is UpdatedState,
          builder: (context, state) => OauthView(context),
          listener: (context, event) {
            if (event is ShopEvent) {
              RouterUtil.push(context, const ShopModule());
            }
          },
        ),
      );
}
