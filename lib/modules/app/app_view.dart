import 'package:flutter/material.dart';
import 'package:insta_poc/modules/app/app_constants.dart';
import 'package:insta_poc/modules/app/app_presenter.dart';
import 'package:insta_poc/modules/app/app_utils.dart';
import 'package:insta_poc/modules/shop/shop_module.dart';
import 'package:insta_poc/state_managment/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends View {
  const AppView(super.context, {super.key});

  @override
  Widget build(context) => app;
}

extension on AppView {
  AppPresenter get presenter => context.read();
  get app {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.name,
      theme: AppUtils.makeTheme(),
      home: const ShopModule(),
      builder: (_, rootView) {
        return Stack(
          children: [
            rootView!,
            overlay,
          ],
        );
      },
    );
  }

  get overlay {
    if (presenter.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const IgnorePointer();
    }
  }
}
