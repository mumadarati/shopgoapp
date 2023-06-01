class AllBrandsModel {
  bool? status;
  List<BrandModel>? brandsList;

  AllBrandsModel({this.status, this.brandsList});

  AllBrandsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['brands_list'] != null) {
      brandsList = [];
      json['brands_list'].forEach((v) {
        if (v['brand'] != "gucci") {
          brandsList!.add(BrandModel.fromJson(v));
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (brandsList != null) {
      data['brands_list'] = brandsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandModel {
  String? price;
  String? hide;
  String? costume;
  int? id;
  String? brand;
  String? brandStatus;
  String? displayStatus;
  String? brandName;
  String? brandLogo;
  String? brandMobile;
  String? brandService;
  String? brandMethod;
  List? brandCategories;

  BrandModel({
     this.price,
     this.hide,
     this.costume,
     this.id,
     this.brand,
     this.brandCategories,
     this.brandLogo,
     this.brandMethod,
     this.brandMobile,
     this.brandName,
     this.brandService,
     this.brandStatus,
     this.displayStatus,
  });

  BrandModel.fromJson(Map<String, dynamic> json)
      : price = json['price'] ?? '',
        hide = json['hide'] ?? '',
        costume = json['costume'] ?? '',
        id = json['id'] ?? 0,
        brand = json['brand'] ?? '',
        brandStatus = json['brand_status'] ?? '',
        displayStatus = json['display_status'] ?? [],
        brandLogo = json['brand_logo'] ?? '',
        brandName = json['brand_name'] ?? '',
        brandMobile = json['brand_mobile'] ?? '',
        brandService = json['brand_service'] ?? '',
        brandMethod = json['brand_method'] ?? '',
        brandCategories = json['brand_categories'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['hide'] = hide;
    data['costume'] = costume;
    data['id'] = id;
    data['brand'] = brand;
    data['brand_status'] = brandStatus;
    data['display_status'] = displayStatus;
    data['brand_logo'] = brandLogo;
    data['brand_name'] = brandName;
    data['brand_mobile'] = brandMobile;
    data['brand_service'] = brandService;
    data['brand_method'] = brandMethod;
    data['brand_categories'] = brandCategories;
    return data;
  }
}
