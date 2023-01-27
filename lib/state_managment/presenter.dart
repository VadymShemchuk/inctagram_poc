// For managing one full-screene view state
import 'package:insta_poc/state_managment/basic_states.dart';
import 'package:insta_poc/state_managment/common_events.dart';
import 'package:insta_poc/state_managment/state_manager.dart';

// For managing one full-screene view state
class Presenter extends StateManager<BasicState> {
  String? _lastError;
  Presenter() : super(UpdatedState());

  void updateState() => next(UpdatedState());

  // error

  void setError(String value) {
    _lastError = value;
    next(ErrorEvent());
  }

  bool get isError => _lastError != null;

  String? get error => _lastError;
}
