class BrandCategoriesModel {
  bool? status;
  BrandsList? brandsList;

  BrandCategoriesModel({this.status, this.brandsList});

  BrandCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    brandsList = json['brands_list'] != null
        ? BrandsList.fromJson(json['brands_list'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (brandsList != null) {
      data['brands_list'] = brandsList!.toJson();
    }
    return data;
  }
}

class BrandsList {
  WomenCat? womenCat;
  WomenCat? menCat;
  WomenCat? kidsCat;
  WomenCat? homeCat;
  WomenCat? cosmeticsCat;
  WomenCat? accessoriesCat;
  WomenCat? shoesCat;
  WomenCat? sweetsCat;

  BrandsList(
      {this.womenCat,
      this.menCat,
      this.kidsCat,
      this.homeCat,
      this.cosmeticsCat,
      this.accessoriesCat,
      this.shoesCat,
      this.sweetsCat});

  BrandsList.fromJson(Map<String, dynamic> json) {
    womenCat = json['women_cat'] != null
        ? WomenCat.fromJson('women_cat', json['women_cat'])
        : null;
    menCat = json['men_cat'] != null
        ? WomenCat.fromJson('men_cat', json['men_cat'])
        : null;
    kidsCat = json['kids_cat'] != null
        ? WomenCat.fromJson('kids_cat', json['kids_cat'])
        : null;
    homeCat = json['home_cat'] != null
        ? WomenCat.fromJson('home_cat', json['home_cat'])
        : null;
    cosmeticsCat = json['cosmetics_cat'] != null
        ? WomenCat.fromJson('cosmetics_cat', json['cosmetics_cat'])
        : null;
    accessoriesCat = json['accessories_cat'] != null
        ? WomenCat.fromJson('accessories_cat', json['accessories_cat'])
        : null;
    shoesCat = json['shoes_cat'] != null
        ? WomenCat.fromJson('shoes_cat', json['shoes_cat'])
        : null;
    sweetsCat = json['sweets_cat'] != null
        ? WomenCat.fromJson('sweets_cat', json['sweets_cat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (womenCat != null) {
      data['women_cat'] = womenCat!.toJson();
    }
    if (menCat != null) {
      data['men_cat'] = menCat!.toJson();
    }
    if (kidsCat != null) {
      data['kids_cat'] = kidsCat!.toJson();
    }
    if (homeCat != null) {
      data['home_cat'] = homeCat!.toJson();
    }
    if (cosmeticsCat != null) {
      data['cosmetics_cat'] = cosmeticsCat!.toJson();
    }
    if (accessoriesCat != null) {
      data['accessories_cat'] = accessoriesCat!.toJson();
    }
    if (shoesCat != null) {
      data['shoes_cat'] = shoesCat!.toJson();
    }
    if (sweetsCat != null) {
      data['sweets_cat'] = sweetsCat!.toJson();
    }
    return data;
  }
}

class WomenCat {
  String? icon;
  String? title;
  String? idCat;
  List<Brands>? brands;

  WomenCat({this.icon, this.title, this.brands, this.idCat});

  WomenCat.fromJson(id, Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    idCat = id;
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['title'] = title;
    data['id'] = idCat;
    if (brands != null) {
      data['brands'] = brands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brands {
  int? id;
  String? brand;
  String? brandStatus;
  String? displayStatus;
  String? brandLogo;
  String? brandName;
  String? brandMobile;
  String? brandService;
  String? brandMethod;
  List<String>? brandCategories;

  Brands(
      {this.id,
      this.brand,
      this.brandStatus,
      this.displayStatus,
      this.brandLogo,
      this.brandName,
      this.brandMobile,
      this.brandService,
      this.brandMethod,
      this.brandCategories});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    brandStatus = json['brand_status'];
    displayStatus = json['display_status'];
    brandLogo = json['brand_logo'];
    brandName = json['brand_name'];
    brandMobile = json['brand_mobile'];
    brandService = json['brand_service'];
    brandMethod = json['brand_method'];
    brandCategories = json['brand_categories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
