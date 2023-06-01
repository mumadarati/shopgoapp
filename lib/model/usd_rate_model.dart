class UsdRateModel {
  bool? status;
  String? exUsdTl;

  UsdRateModel({this.status, this.exUsdTl});

  UsdRateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    exUsdTl = json['ex_usd_tl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['ex_usd_tl'] = exUsdTl;
    return data;
  }
}
