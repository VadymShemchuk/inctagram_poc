import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_poc/common/utils/router_util.dart';
import 'package:insta_poc/modules/oauth/oauth_module.dart';
import 'package:insta_poc/modules/root/root_presenter.dart';
import 'package:insta_poc/modules/root/root_view.dart';
import 'package:insta_poc/modules/shop/shop_module.dart';
import 'package:insta_poc/state_managment/basic_states.dart';
import 'package:insta_poc/state_managment/common_events.dart';

class RootModule extends StatelessWidget {
  const RootModule({super.key});

  @override
  Widget build(BuildContext context) => _provider;

  Widget get _provider => BlocProvider(
        create: (context) => RootPresenter(
          context.read(),
          context.read(),
          context.read(),
        )..checkToken(),
        child: BlocConsumer<RootPresenter, BasicState>(
          buildWhen: (_, current) => current is UpdatedState,
          builder: (context, state) => RootView(context),
          listener: (context, event) {
            if (event is OauthEvent) {
              RouterUtil.push(context, const OauthModule());
            } else if (event is ShopEvent) {
              RouterUtil.push(context, const ShopModule());
            }
          },
        ),
      );
}
