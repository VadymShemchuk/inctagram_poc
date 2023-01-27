import 'package:flutter/widgets.dart';

/// For full-screen scens view
/// Make it absolutly stuped and pull all logic to presenter
class View extends StatelessWidget {
  final BuildContext context;
  // For excluding extra work with context providing for building ui components

  const View(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
