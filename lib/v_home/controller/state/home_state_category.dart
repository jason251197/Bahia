part of '../index.dart';

class CategoriesState {
  static CategoriesState _instance;

  ///[_categoryState] will manage the Request Events

  BehaviorSubject<List<CategoryModel>> _categoryState;

  CategoriesState._() {
    _categoryState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  get getEvents => _categoryState.stream;

  List<CategoryModel> get getValue => _categoryState?.value ?? [];

  String get getFirstCategoryName =>
      (getValue?.isNotEmpty ?? false) ? getValue?.first?.catName : '';

  void update(List<CategoryModel> data) =>
      data is List<CategoryModel> ? _categoryState.add(data) : null;

  get clean {
    _categoryState.add(null);
  }

  factory CategoriesState() => _getInstance();

  static CategoriesState _getInstance() {
    if (_instance == null) {
      _instance = CategoriesState._();
    }
    return _instance;
  }
}
