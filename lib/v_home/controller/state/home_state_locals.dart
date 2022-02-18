part of '../index.dart';

class LocalsState {
  static LocalsState _instance;

  ///[_localsState] will manage the Request Events

  BehaviorSubject<List<LocalModel>> _localsState;

  LocalsState._() {
    _localsState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  get getEvents => _localsState.stream;

  List<LocalModel> get getValue => _localsState?.value ?? [];

  void addMore(List<LocalModel> data) =>
      data is List<LocalModel> ? update([...getValue, ...data]) : null;

  void update(List<LocalModel> data) =>
      data is List<LocalModel> ? _localsState.add(data) : null;
  get clean {
    _localsState.add(null);
  }

  get currency => getValue.isEmpty ? null : getValue?.first?.currency;

  factory LocalsState() => _getInstance();

  static LocalsState _getInstance() {
    if (_instance == null) {
      _instance = LocalsState._();
    }
    return _instance;
  }
}
