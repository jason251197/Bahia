part of '../index.dart';

class FavouriteState {
  static FavouriteState _instance;

  BehaviorSubject<FavouriteModel> _favouriteState;

  FavouriteState._() {
    _favouriteState = BehaviorSubject();
  }

  get getEvents => _favouriteState.stream;

  FavouriteModel get getValue => _favouriteState?.value ?? null;

  String get getId => (getValue ?? false) ? getValue?.id : '';

  void update(FavouriteModel data) =>
      data is FavouriteModel ? _favouriteState.value = data : null;

  get clean {
    _favouriteState = null;
  }

  factory FavouriteState() => _getInstance();

  static FavouriteState _getInstance() {
    if (_instance == null) {
      _instance = FavouriteState._();
    }
    return _instance;
  }
}
