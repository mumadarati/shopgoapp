class ShippingCountriesModel {
  bool? status;
  List<String>? from;
  List<String>? to;

  ShippingCountriesModel({this.status, this.from, this.to});

  ShippingCountriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    from = json['from'].cast<String>();
    to = json['to'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}
