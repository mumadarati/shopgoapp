class UserWishlistModel {
  bool? status;
  List<Wishlist>? wishlist;

  UserWishlistModel({this.status, this.wishlist});

  UserWishlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(Wishlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (wishlist != null) {
      data['wishlist'] = wishlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wishlist {
  String? productId;
  String? productName;
  String? productRegularPrice;
  String? productSalePrice;
  String? productUrl;
  String? productBrand;
  String? productType;
  String? productUnitWeigth;
  String? productUnitWidth;
  String? productUnitHeigth;
  String? productUnitLength;
  String? thumbnail;
  int? qty;
  ProductMeta? productMeta;

  Wishlist(
      {this.productId,
        this.productName,
        this.productRegularPrice,
        this.productSalePrice,
        this.productUrl,
        this.productBrand,
        this.productType,
        this.productUnitWeigth,
        this.productUnitWidth,
        this.productUnitHeigth,
        this.productUnitLength,
        this.thumbnail,
        this.qty,
        this.productMeta});

  Wishlist.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productRegularPrice = json['product_regular_price'];
    productSalePrice = json['product_sale_price'];
    productUrl = json['product_url'];
    productBrand = json['product_brand'];
    productType = json['product_type'];
    productUnitWeigth = json['product_unit_weigth'];
    productUnitWidth = json['product_unit_width'];
    productUnitHeigth = json['product_unit_heigth'];
    productUnitLength = json['product_unit_length'];
    thumbnail = json['thumbnail'];
    qty = json['qty'];
    productMeta = json['product_meta'] != null
        ? ProductMeta.fromJson(json['product_meta'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['product_regular_price'] = productRegularPrice;
    data['product_sale_price'] = productSalePrice;
    data['product_url'] = productUrl;
    data['product_brand'] = productBrand;
    data['product_type'] = productType;
    data['product_unit_weigth'] = productUnitWeigth;
    data['product_unit_width'] = productUnitWidth;
    data['product_unit_heigth'] = productUnitHeigth;
    data['product_unit_length'] = productUnitLength;
    data['thumbnail'] = thumbnail;
    data['qty'] = qty;
    if (productMeta != null) {
      data['product_meta'] = productMeta!.toJson();
    }
    return data;
  }
}

class ProductMeta {
  String? productCustomer;
  String? sProductUrl;
  String? productSite;
  String? siteLogo;
  String? productImage;
  String? productName;
  String? productSize;
  String? productColor;
  String? sStock;
  String? productPriceTl;
  String? productPriceUsd;
  String? sPrice;
  String? usdRate;
  String? productNote;
  String? sSku;
  String? sStockStatus;
  String? sRegularPrice;
  String? productType;
  String? sThumbnailId;
  String? sProductAttributes;
  String? sProductShopgoStatus;
  String? shWeight;
  String? shLength;
  String? shWidth;
  String? shHeight;
  String? sWeight;
  String? sLength;
  String? sWidth;
  String? sHeight;
  String? sProductShopgoStatusNote;
  String? productCategories0;
  String? productCategories1;
  String? productCategories2;
  String? sShopManager;

  ProductMeta(
      {this.productCustomer,
        this.sProductUrl,
        this.productSite,
        this.siteLogo,
        this.productImage,
        this.productName,
        this.productSize,
        this.productColor,
        this.sStock,
        this.productPriceTl,
        this.productPriceUsd,
        this.sPrice,
        this.usdRate,
        this.productNote,
        this.sSku,
        this.sStockStatus,
        this.sRegularPrice,
        this.productType,
        this.sThumbnailId,
        this.sProductAttributes,
        this.sProductShopgoStatus,
        this.shWeight,
        this.shLength,
        this.shWidth,
        this.shHeight,
        this.sWeight,
        this.sLength,
        this.sWidth,
        this.sHeight,
        this.sProductShopgoStatusNote,
        this.productCategories0,
        this.productCategories1,
        this.productCategories2,
        this.sShopManager});

  ProductMeta.fromJson(Map<String, dynamic> json) {
    productCustomer = json['product_customer'];
    sProductUrl = json['_product_url'];
    productSite = json['product_site'];
    siteLogo = json['site_logo'];
    productImage = json['product_image'];
    productName = json['product_name'];
    productSize = json['product_size'];
    productColor = json['product_color'];
    sStock = json['_stock'];
    productPriceTl = json['product_price_tl'];
    productPriceUsd = json['product_price_usd'];
    sPrice = json['_price'];
    usdRate = json['usd_rate'];
    productNote = json['product_note'];
    sSku = json['_sku'];
    sStockStatus = json['_stock_status'];
    sRegularPrice = json['_regular_price'];
    productType = json['productType'];
    sThumbnailId = json['_thumbnail_id'];
    sProductAttributes = json['_product_attributes'];
    sProductShopgoStatus = json['_product_shopgo_status'];
    shWeight = json['sh_weight'];
    shLength = json['sh_length'];
    shWidth = json['sh_width'];
    shHeight = json['sh_height'];
    sWeight = json['_weight'];
    sLength = json['_length'];
    sWidth = json['_width'];
    sHeight = json['_height'];
    sProductShopgoStatusNote = json['_product_shopgo_status_note'];
    productCategories0 = json['product_categories_0'];
    productCategories1 = json['product_categories_1'];
    productCategories2 = json['product_categories_2'];
    sShopManager = json['_shop_manager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_customer'] = productCustomer;
    data['_product_url'] = sProductUrl;
    data['product_site'] = productSite;
    data['site_logo'] = siteLogo;
    data['product_image'] = productImage;
    data['product_name'] = productName;
    data['product_size'] = productSize;
    data['product_color'] = productColor;
    data['_stock'] = sStock;
    data['product_price_tl'] = productPriceTl;
    data['product_price_usd'] = productPriceUsd;
    data['_price'] = sPrice;
    data['usd_rate'] = usdRate;
    data['product_note'] = productNote;
    data['_sku'] = sSku;
    data['_stock_status'] = sStockStatus;
    data['_regular_price'] = sRegularPrice;
    data['productType'] = productType;
    data['_thumbnail_id'] = sThumbnailId;
    data['_product_attributes'] = sProductAttributes;
    data['_product_shopgo_status'] = sProductShopgoStatus;
    data['sh_weight'] = shWeight;
    data['sh_length'] = shLength;
    data['sh_width'] = shWidth;
    data['sh_height'] = shHeight;
    data['_weight'] = sWeight;
    data['_length'] = sLength;
    data['_width'] = sWidth;
    data['_height'] = sHeight;
    data['_product_shopgo_status_note'] = sProductShopgoStatusNote;
    data['product_categories_0'] = productCategories0;
    data['product_categories_1'] = productCategories1;
    data['product_categories_2'] = productCategories2;
    data['_shop_manager'] = sShopManager;
    return data;
  }
}
