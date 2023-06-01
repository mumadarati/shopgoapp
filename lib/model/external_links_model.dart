
class ExternalLinksModel {
  bool? status;
  Links? links;

  ExternalLinksModel({this.status, this.links});

  ExternalLinksModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (links != null) {
      data['links'] = links!.toJson();
    }
    return data;
  }
}

class Links {
  String? bannedProducts;
  String? privacy;
  String? terms;
  String? wego;
  String? yugo;
  String? howItWorks;
  String? whatIsShopgo;

  Links(
      {this.bannedProducts,
        this.privacy,
        this.terms,
        this.wego,
        this.yugo,
        this.howItWorks,
        this.whatIsShopgo});

  Links.fromJson(Map<String, dynamic> json) {
    bannedProducts = json['banned_products'];
    privacy = json['privacy'];
    terms = json['terms'];
    wego = json['wego'];
    yugo = json['yugo'];
    howItWorks = json['how_it_works'];
    whatIsShopgo = json['what_is_shopgo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banned_products'] = bannedProducts;
    data['privacy'] = privacy;
    data['terms'] = terms;
    data['wego'] = wego;
    data['yugo'] = yugo;
    data['how_it_works'] = howItWorks;
    data['what_is_shopgo'] = whatIsShopgo;
    return data;
  }
}
