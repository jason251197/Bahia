import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/service/navigation/navigation_service.dart';
import 'package:appclientes/v_order/controller/index.dart';

class OrderController {

  static void goBack() => NavigationService().pop();

  static OrderList get loadOrders => OrderCache.getOrderList;
  
    static Future/*OrderList*/ loadOrdersAfterPay(String codClient) async {
    final orderList = await OrderRepository.getOrdersByClient(codClient, true);
    await Future.wait([
      OrderCache.setOrderList(orderList),
    ]);
  }
  
  static Future loadOrdersAfterClickOrder() async {
    String codClient = SessionCache.getUser.code;
    //return await loadOrdersAfterPay(codClient);
    return await OrderRepository.getOrdersByClient(codClient, true);
  }

}
