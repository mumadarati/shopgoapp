class CalculateShippingRates {
  bool? status;
  int? shippingRate;

  CalculateShippingRates({this.status, this.shippingRate});

  CalculateShippingRates.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    shippingRate = json['shipping_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['shipping_rate'] = shippingRate;
    return data;
  }
}
