// For managing reuseble in multiple screens busines logic
import 'package:insta_poc/state_managment/basic_states.dart';
import 'package:insta_poc/state_managment/state_manager.dart';

class Service extends StateManager<BasicState> {
  bool _isRefreshing = false;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _isEmpty = false;
  bool _isAllContentLoaded = false;
  bool _isConnection = true;
  String? _lastItemDateString;
  String? _lastError;

  Service() : super(UpdatedState());

  void updateState() => next(UpdatedState());

  // for get newer content

  void setRefreshing(bool isOn) {
    _isRefreshing = isOn;
    updateState();
  }

  bool get isRefreshing => _isRefreshing;

  // Inital loading

  // Loader

  void setLoaderOn() {
    _isLoading = true;
    updateState();
  }

  void setLoaderOff() {
    _isLoading = true;
    updateState();
  }

  bool get isLoading => _isLoading;

  // Loading more (infinit scroll)

  void setLoadingMore(bool isOn) {
    _isLoadingMore = isOn;
    updateState();
  }

  bool get isLoadingMore => _isLoadingMore;

  // for reload all content

  void reset() {
    _isRefreshing = false;
    _isLoading = false;
    _isEmpty = false;
    _isAllContentLoaded = false;
    _lastItemDateString = null;
    _lastError = null;
    _isLoading = false;
    updateState();
  }

  // if no content available

  void setEmpty(bool isOn) {
    _isEmpty = isOn;
    updateState();
  }

  bool get isEmpty => _isEmpty;

  // if all content succesfuly loaded

  void setAllLoaded(bool isOn) {
    _isAllContentLoaded = isOn;
    updateState();
  }

  bool get isAllContentLoaded => _isAllContentLoaded;

  // Inital connection

  void setConnection(bool isOn) {
    _isConnection = isOn;
    updateState();
  }

  bool get isConnection => _isConnection;

  // err

  void setError(String value) {
    _lastError = value;
    updateState();
  }

  bool get isError => _lastError != null;
  String get error => _lastError ?? '';
  void removeError() => _lastError = null;

  void setLastItemDateString(String? value) {
    _lastItemDateString = value;
    updateState();
  }

  String? get lastItemDateString => _lastItemDateString;
}
