import 'package:appclientes/shared/components/app_button_switch/switch_option.dart';
import 'package:rxdart/rxdart.dart';

class OrderTypeState {
  static OrderTypeState _instance;
  bool typePickupImmediately = false;
  int cardIndex = 0;

  ///[_orderTypeState] will manage the Request Events

  BehaviorSubject<ORDER_TYPE> _orderTypeState;

  OrderTypeState._() {
    _orderTypeState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  Stream<ORDER_TYPE> get getEvents => _orderTypeState.stream;

  ORDER_TYPE get getValue => _orderTypeState?.value ?? ORDER_TYPE.DELIVERY;

  void update(ORDER_TYPE data) => _orderTypeState.add(data);

  get clean {
    _orderTypeState.add(null);
  }

  factory OrderTypeState() => _getInstance();

  static OrderTypeState _getInstance() {
    if (_instance == null) {
      _instance = OrderTypeState._();
    }
    return _instance;
  }
  
  void setTypePickupImmediately(bool type) {
    typePickupImmediately = type;
  }

  bool get getTypePickupImmediately => typePickupImmediately;
  
  void setCardIndex(int index) {
    cardIndex = index;
  }

  num getCardIndex() {
    if (cardIndex==null){
      return 0;
    }
    return cardIndex;
  }
}
