import 'package:appclientes/packages/address_card/address_card.dart';
import 'package:rxdart/subjects.dart';

class AddressState {
  static AddressState _instance;

  ///[_addressState] will manage the Request Events

  BehaviorSubject<AddressModel> _addressState;
  BehaviorSubject<bool> _onUpdateState;
  AddressState._() {
    _addressState = BehaviorSubject();
    _onUpdateState = BehaviorSubject();
  }

  /// REQUEST STREAM METHODS
  get getEvents => _addressState.stream;

  String get getAddress =>
      _addressState?.value?.shortAddress ?? "Seleccione una Dirección";

  AddressModel get getValue => _addressState?.value;

  void update(AddressModel data) => _addressState.add(data);

  get clean {
    _addressState.add(null);
  }

  /// REQUEST STREAM METHODS
  Stream get onUpdateEvents => _onUpdateState.stream;
  bool get getUpdates => _onUpdateState?.value ?? false;
  void get rebuild => _onUpdateState.add(!getUpdates);

  factory AddressState() => _getInstance();

  static AddressState _getInstance() {
    if (_instance == null) {
      _instance = AddressState._();
    }
    return _instance;
  }
}
