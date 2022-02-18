part of '../index.dart';

class FilterState {
  static FilterState _instance;

  ///[_categoryState] will manage the Request Events

  BehaviorSubject<FilterModel> _categoryState;
  int _pageState;
  bool _canLoad;

  BehaviorSubject<bool> _isLoading;
  BehaviorSubject<bool> _preLoading;

  FilterState._() {
    _categoryState = BehaviorSubject();
    _pageState = 1;
    _canLoad = true;
    _isLoading = BehaviorSubject.seeded(false);
    _preLoading = BehaviorSubject.seeded(false);
  }

  /// REQUEST STREAM METHODS
  Stream<FilterModel> get getEvents => _categoryState.stream;

  FilterModel get getValue => _categoryState?.value ?? FilterModel();

  void update(FilterModel data) =>
      data is FilterModel ? _categoryState.add(data) : null;

  void updateCategory(String categoryCode) {
    if (categoryCode is String) {
      final value = getValue;
      value.catCode = categoryCode;
      update(value);
    }
  }

  /// REQUEST STREAM METHODS
  int get getPage => _pageState ?? 1;

  get nextPage => _pageState++;

  /// REQUEST STREAM METHODS
  bool get canLoad => _canLoad ?? true;

  void setCanLoad(bool load) => _canLoad = load;

  get cantLoad => _canLoad = false;

  bool get isLoading => _isLoading.value ?? false;

  Stream<bool> get isLoadingEvents => _isLoading.stream;

  get setLoading => _isLoading.add(true);
  get setLoaded => _isLoading.add(false);

  bool get isPreLoading => _preLoading.value ?? false;
  Stream<bool> get preLoadingEvents => _preLoading.stream;

  get setPreLoading => _preLoading.add(true);
  get cancelPreLoading => _preLoading.add(false);

  get clean => _categoryState.add(null);

  get reset {
    _canLoad = true;
    _pageState = 1;
    _isLoading.add(false);
    _preLoading.add(false);
  }

  get reload {
    reset;
    final temp = getValue;
    update(temp);
  }

  factory FilterState() => _getInstance();

  static FilterState _getInstance() {
    if (_instance == null) {
      _instance = FilterState._();
    }
    return _instance;
  }
}
