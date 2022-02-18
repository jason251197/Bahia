part of '../index.dart';

class CartRepository {
  static const _idty = "cart_repository";
  static void log(value) => Logger.log(_idty, [value]);

  static Future<bool> sendPayment2(OrderModel order) => ApiService.fetch(
        Apis.processOrderClient(OrderModel.getOrder(order)),
        showSuccessDialog: false,
        onSuccessList: (dataList) =>
            CategoriesState().update(List<CategoryModel>.from(
          dataList.map((e) => CategoryModel.fromJson(e)),
        )),
      );

  static Future<HeaderResponseModel> sendPayment(OrderModel order) async {
    HeaderResponseModel headerResponseModel;
    await ApiService.fetch(
      Apis.processOrderClient(OrderModel.getOrder(order)),
      showSuccessDialog: false,
      onSuccessList: (dataList) =>
          CategoriesState().update(List<CategoryModel>.from(
        dataList.map((e) => CategoryModel.fromJson(e)),
      )),
      onSuccess: (res) => res.data is Map && res.data["result"] is Map
          ? headerResponseModel =
              HeaderResponseModel.fromJson(res.data["result"])
          : null,
    );
    return headerResponseModel;
  }

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
          item.value =
              item.avaliableValue != null ? item.avaliableValue : item.value;
          CouponState().update(item);
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
    await ApiService.fetch(
      Apis.saveCouponUser(CouponModel.coupon(coupon)),
      showSuccessDialog: false,
      showLoading: true,
    );
    return headerResponseModel;
  }
}
