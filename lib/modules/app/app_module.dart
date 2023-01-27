import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_poc/api/instagram_api_service.dart';
import 'package:insta_poc/modules/app/app_presenter.dart';
import 'package:insta_poc/modules/app/app_view.dart';
import 'package:insta_poc/modules/app/loading_service.dart';
import 'package:insta_poc/modules/shop/shop_items_service.dart';
import 'package:insta_poc/state_managment/basic_states.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(context) => _provider;

  Widget get _provider => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoaderServise()),
          BlocProvider(create: (_) => ShopItemsService()),
          BlocProvider(
            create: (context) => InstagramApiService(context.read()),
          ),
          BlocProvider(
            create: (context) => AppPresenter(context.read()),
          ),
        ],
        child: BlocBuilder<AppPresenter, BasicState>(
          buildWhen: (_, current) => current is UpdatedState,
          builder: (context, state) => AppView(context),
        ),
      );
}
