import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class StateManager<BasicState> extends Cubit<BasicState> {
  /// For subscribe to everithing
  List<StreamSubscription> subscriptions = [];

  /// Required just for inheritance
  StateManager(initialState) : super(initialState) {
    subscribe();
  }

  @override
  Future<void> close() {
    _unsubscribe();
    return super.close();
  }

  /// Place for overriding subscriptions
  void subscribe() {}

  /// Remove all listners before close
  void _unsubscribe() {
    for (var element in subscriptions) {
      element.cancel();
    }
  }

  next(BasicState state) {
    emit(state);
  }
}
