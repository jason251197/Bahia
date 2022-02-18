class CouponsUsers {
  int id;
  String code;
  num value;
  int amount;
  int amountUsed;
  bool state;
  bool delete;
  int idCouponClient;
  int idClient;
  num avaliableValue;
  String dateEnd;

  CouponsUsers(
      {this.id,
      this.code,
      this.value,
      this.amount,
      this.amountUsed,
      this.state,
      this.delete,
      this.idCouponClient,
      this.idClient,
      this.avaliableValue,
      this.dateEnd});

  CouponsUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    value = json['value'];
    amount = json['amount'];
    amountUsed = json['amount_used'];
    state = json['state'];
    delete = json['delete'];
    idCouponClient = json['id_coupon_client'];
    idClient = json['id_client'];
    avaliableValue = json['avaliable_value'];
    dateEnd = json['date_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['value'] = this.value;
    data['amount'] = this.amount;
    data['amount_used'] = this.amountUsed;
    data['state'] = this.state;
    data['delete'] = this.delete;
    data['id_coupon_client'] = this.idCouponClient;
    data['id_client'] = this.idClient;
    data['avaliable_value'] = this.avaliableValue;
    data['date_end'] = this.dateEnd;
    return data;
  }
}
