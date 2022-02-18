import 'package:appclientes/v_coupon/controller/model/coupons_users_model.dart';
import 'package:rxdart/rxdart.dart';

class CouponState {
  static CouponState _instance;

  ///[_couponState] will manage the Request Events

  BehaviorSubject<List<CouponsUsers>> _couponState;

  CouponState._() {
    _couponState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  Stream<List<CouponsUsers>> get getEvents => _couponState.stream;

  List<CouponsUsers> get getValue => _couponState?.value ?? <CouponsUsers>[];

  void update(List<CouponsUsers> data) => _couponState.add(data);

  get clean {
    _couponState.add(<CouponsUsers>[]);
  }

  factory CouponState() => _getInstance();

  static CouponState _getInstance() {
    if (_instance == null) {
      _instance = CouponState._();
    }
    return _instance;
  }
}
