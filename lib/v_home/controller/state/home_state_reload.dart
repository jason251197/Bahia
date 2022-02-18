part of '../index.dart';

class ReloadState {
  static ReloadState _instance;

  ///[_reloadState] will manage the Request Events

  BehaviorSubject<bool> _reloadState;

  ReloadState._() {
    _reloadState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  Stream<bool> get getEvents => _reloadState.stream;

  bool get getValue => _reloadState?.value ?? false;

  void update(bool data) => data is bool ? _reloadState.add(data) : null;

  get clean => _reloadState.add(null);

  get reload {
    final value = getValue;
    update(!value);
  }

  factory ReloadState() => _getInstance();

  static ReloadState _getInstance() {
    if (_instance == null) {
      _instance = ReloadState._();
    }
    return _instance;
  }
}
