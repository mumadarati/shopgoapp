class PaymentMethodsModel {
  final List<PaymentMethods>? paymentMethods;

  PaymentMethodsModel({
    this.paymentMethods,
  });
  factory PaymentMethodsModel.fromJson(List<dynamic> parsedJson) {

    List<PaymentMethods> payments = <PaymentMethods>[];

    payments = parsedJson.map((i)=>PaymentMethods.fromJson(i)).toList();

    return PaymentMethodsModel(
      paymentMethods: payments,
    );
  }
}
class PaymentMethods{
  final String? id;
  final String? title;
  final String? description;

  PaymentMethods({
    this.id,
    this.title,
    this.description
  }) ;

  factory PaymentMethods.fromJson(Map<String, dynamic> json){
    return PaymentMethods(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
    );
  }

}
