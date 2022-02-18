part of './../index.dart';

class CouponState {
  static CouponState _instance;

  ///[_couponState] will manage the Request Events

  BehaviorSubject<CouponValidateModel> _couponState;

  CouponState._() {
    _couponState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  Stream<CouponValidateModel> get getEvents => _couponState.stream;

  CouponValidateModel get getValue =>
      _couponState?.value ?? CouponValidateModel();

  void update(CouponValidateModel data) => _couponState.add(data);

  get clean {
    _couponState.add(new CouponValidateModel());
  }

  factory CouponState() => _getInstance();

  static CouponState _getInstance() {
    if (_instance == null) {
      _instance = CouponState._();
    }
    return _instance;
  }
}
