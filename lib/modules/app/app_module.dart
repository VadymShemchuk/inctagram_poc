import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_poc/api/instagram_api_service.dart';
import 'package:insta_poc/common/utils/router_util.dart';
import 'package:insta_poc/modules/app/app_presenter.dart';
import 'package:insta_poc/modules/app/app_view.dart';
import 'package:insta_poc/modules/instagram_oauth/insta_oauth_module.dart';
import 'package:insta_poc/modules/shop/shop_items_service.dart';
import 'package:insta_poc/state_managment/basic_states.dart';
import 'package:insta_poc/state_managment/common_events.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(context) => _provider;

  Widget get _provider => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ShopItemsService(),
          ),
          BlocProvider(
            create: (context) => InstagramApiService(
              context.read(),
            ),
          ),
          BlocProvider(
            create: (context) => AppPresenter(
              context.read(),
            )..checkToken(),
          ),
        ],
        child: BlocConsumer<AppPresenter, BasicState>(
          buildWhen: (_, current) => current is UpdatedState,
          builder: (context, state) => AppView(context),
          listener: (context, event) {
            if (event is OauthEvent) {
              RouterUtil.push(context, const OauthModule());
            } else if (event is UploadMediasEvent) {
              print('777 upload');
            }
          },
        ),
      );
}
