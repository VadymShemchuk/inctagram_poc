import 'package:flutter/material.dart';

class RouterUtil {
  static push(
    BuildContext context,
    Widget widget,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  static void pushReplacement(
    BuildContext context,
    Widget widget,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  static void close(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }
}
