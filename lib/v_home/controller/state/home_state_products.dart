part of '../index.dart';

class ProductState {
  static ProductState _instance;

  ///[_productsState] will manage the Request Events

  BehaviorSubject<List<ProductModel>> _productsState;

  ProductState._() {
    _productsState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  get getEvents => _productsState.stream;

  List<ProductModel> get getValue => _productsState?.value ?? [];

  void addMore(List<ProductModel> data) =>
      data is List<ProductModel> ? update([...getValue, ...data]) : null;

  void update(List<ProductModel> data) =>
      data is List<ProductModel> ? _productsState.add(data) : null;
  get clean {
    _productsState.add(null);
  }

  get currency => getValue.isEmpty ? null : getValue?.first?.currency;

  factory ProductState() => _getInstance();

  static ProductState _getInstance() {
    if (_instance == null) {
      _instance = ProductState._();
    }
    return _instance;
  }
}
