import 'package:flutter/material.dart';
import 'package:insta_poc/state_managment/view.dart';

class RootView extends View {
  const RootView(super.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Please wait!'),
      ),
    );
  }
}
