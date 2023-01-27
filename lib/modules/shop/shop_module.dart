import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_poc/modules/shop/shop_presenter.dart';
import 'package:insta_poc/modules/shop/shop_view.dart';
import 'package:insta_poc/state_managment/basic_states.dart';

class ShopModule extends StatelessWidget {
  const ShopModule({super.key});

  @override
  Widget build(BuildContext context) => _provider;

  Widget get _provider => BlocProvider(
        create: (context) => ShopPresenter(
          context.read(),
        ),
        child: BlocConsumer<ShopPresenter, BasicState>(
          buildWhen: (_, current) => current is UpdatedState,
          builder: (context, state) => ShopView(
            presenter: context.read(),
          ),
          listener: ((context, event) {
            // if (event is TreeEvent) {
            //   RouterUtil.push(
            //     context,
            //     const TreeModule(),
            //   );
            // }
          }),
        ),
      );
}
