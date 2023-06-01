class CurrentBalanceModel {
  bool? status;
  String? balance;

  CurrentBalanceModel({this.status, this.balance});

  CurrentBalanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['balance'] = balance;
    return data;
  }
}
