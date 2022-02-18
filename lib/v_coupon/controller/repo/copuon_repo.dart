import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/service/api/model/header_response.dart';
import 'package:appclientes/service/dialog/dialog_service.dart';
import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/v_coupon/controller/model/coupon_model.dart';
import 'package:appclientes/v_coupon/controller/model/coupon_validate_model.dart';
import 'package:appclientes/v_coupon/controller/model/coupons_users_model.dart';
import 'package:appclientes/v_coupon/controller/state/coupon_state.dart';

class CouponRepository {
  static const _idty = "coupon_repository";
  static void log(value) => Logger.log(_idty, [value]);

  static Future<HeaderResponseModel> validateCoupon(CouponModel coupon) async {
    HeaderResponseModel headerResponseModel;
    await ApiService.fetch(
      Apis.validateCoupon(CouponModel.coupon(coupon)),
      showSuccessDialog: false,
      showLoading: true,
      onSuccess: (res) {
        if (!res.data["result"]["status"]) {
          DialogService.simpleDialog(res.data["result"]["description"]);
        } else {
          DialogService.simpleDialog("Cupon asignado correctamente");
          CouponValidateModel item =
              CouponValidateModel.fromJson(res.data["entity"]["data"]);
          coupon.avaliableValue =
              item.avaliableValue != null ? item.avaliableValue : item.value;
          coupon.idCouponDiscount = item.id;
          registerCouponUser(coupon);
        }
      },
    );
    return headerResponseModel;
  }

  static Future<HeaderResponseModel> registerCouponUser(
      CouponModel coupon) async {
    HeaderResponseModel headerResponseModel;
    await ApiService.fetch(Apis.saveCouponUser(CouponModel.coupon(coupon)),
        showSuccessDialog: false,
        showLoading: true,
        onSuccess: (data) => listCoupons(coupon));
    return headerResponseModel;
  }

  static Future<HeaderResponseModel> listCoupons(CouponModel coupon) async {
    HeaderResponseModel headerResponseModel;
    await ApiService.fetch(
      Apis.listCouponUser(CouponModel.coupon(coupon)),
      showSuccessDialog: false,
      showLoading: true,
      onSuccessList: (dataList) => CouponState().update(
        List<CouponsUsers>.from(dataList.map((e) => CouponsUsers.fromJson(e))),
      ),
    );
    return headerResponseModel;
  }
}
