class CouponValidateModel {
  int id;
  int idCouponClient;
  int idClient;
  num avaliableValue;
  String code;
  num value = 0;
  int amount;
  int amountUsed;
  bool state;
  bool delete;
  num avaliable = 0;

  CouponValidateModel(
      {this.code,
      this.id,
      this.idCouponClient,
      this.avaliableValue,
      this.idClient,
      this.value,
      this.amount,
      this.amountUsed,
      this.state,
      this.delete});

  CouponValidateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCouponClient = json['id_coupon_client'];
    avaliableValue = json['avaliable_value'];
    idClient = json['id_client'];
    code = json['code'];
    value = json['value'];
    amount = json['amount'];
    amountUsed = json['amount_used'];
    state = json['state'];
    delete = json['delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_coupon_client'] = this.idCouponClient;
    data['avaliable_value'] = this.avaliableValue;
    data['id_client'] = this.idClient;
    data['code'] = this.code;
    data['value'] = this.value;
    data['amount'] = this.amount;
    data['amount_used'] = this.amountUsed;
    data['state'] = this.state;
    data['delete'] = this.delete;
    return data;
  }
}
