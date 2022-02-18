import 'package:appclientes/shared/helpers/converter.dart';
import 'package:appclientes/v_coupon/controller/state/coupon_state.dart';
import 'package:flutter/material.dart';
import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/helpers/form_controller.dart';
import 'package:appclientes/v_coupon/controller/repo/copuon_repo.dart';
import 'package:appclientes/v_coupon/controller/model/coupon_model.dart';

class CouponHistory extends StatefulWidget {
  const CouponHistory({Key key}) : super(key: key);

  @override
  _CouponHistoryState createState() => _CouponHistoryState();
}

class _CouponHistoryState extends State<CouponHistory> {
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    getCoupons();
  }

  static String toCOP(num value) =>
      AppConverter.numToMoney(value, AppConverter.USD, " ");

  getCoupons() async {
    UserModel user = SessionCache.getUser;
    await CouponRepository.listCoupons(CouponModel(codeCliente: user.code));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInset.horizontal(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    focusNode: myFocusNode,
                    controller: FormController.codeCouponController,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 7.0, right: 5.0, top: 15.0, bottom: 12.0),
                      isDense: true,
                      labelText: 'Código del Cupón',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontFamily: FontFamily.REGULAR_ASSISTANT,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Buttons.yellow("Validar", fontSize: 12, onClick: () {
                  final codeClient = SessionCache.getUser.code;
                  CouponModel coupon = new CouponModel(
                      codeCoupon: FormController.codeCouponController.text,
                      codeCliente: codeClient);
                  CouponRepository.validateCoupon(coupon);
                  FormController.clean();
                })
              ],
            ),
          ),
          SizedBox(height: 20),
          StreamBuilder(
            stream: CouponState().getEvents,
            builder: (c, v) {
              final value = CouponState().getValue;
              return AppCard(
                buildOpen: true,
                title: "Cupones Validados",
                paddingH: 0,
                child: value.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: value.length,
                        itemBuilder: (_, index) {
                          return Container(
                            child: ListTile(
                              title: Text('Código: ${value[index].code}'),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      'Saldo: ${toCOP(value[index].value != null ? value[index].avaliableValue : value[index].value)}'),
                                  Text("Vigencia: ${value[index].dateEnd}")
                                ],
                              ),
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.money_rounded,
                                    color: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(child: Texts.grayBold("No hay cupones validados")),
              );
            },
          ),
        ],
      ),
    );
  }
}
