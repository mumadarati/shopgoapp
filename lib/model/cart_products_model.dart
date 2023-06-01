class GetUserCartModel {
  bool? status;
  List<ProductsInCart>? productsInCart;
  List<ProductsPending>? productsPending;
  UserCartSession? userCartSession;

  GetUserCartModel(
      {this.status,
      this.productsInCart,
      this.productsPending,
      this.userCartSession});

  GetUserCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products_in_cart'] != null) {
      productsInCart = <ProductsInCart>[];
      json['products_in_cart'].forEach((v) {
        productsInCart!.add(ProductsInCart.fromJson(v));
      });
    }
    if (json['products_pending'] != null) {
      productsPending = <ProductsPending>[];
      json['products_pending'].forEach((v) {
        productsPending!.add(ProductsPending.fromJson(v));
      });
    }
    userCartSession = json['user_cart_session'] != null
        ? UserCartSession.fromJson(json['user_cart_session'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (productsInCart != null) {
      data['products_in_cart'] =
          productsInCart!.map((v) => v.toJson()).toList();
    }
    if (productsPending != null) {
      data['products_pending'] =
          productsPending!.map((v) => v.toJson()).toList();
    }
    if (userCartSession != null) {
      data['user_cart_session'] = userCartSession!.toJson();
    }
    return data;
  }
}

class ProductsInCart {
  int? productId;
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
  String? lineSubtotal;
  String? lineTotal;
  ProductMeta? productMeta;

  ProductsInCart(
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
      this.lineSubtotal,
      this.lineTotal,
      this.productMeta});

  ProductsInCart.fromJson(Map<String, dynamic> json) {
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
    lineSubtotal = json['line_subtotal'];
    lineTotal = json['line_total'];
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
    data['line_subtotal'] = lineSubtotal;
    data['line_total'] = lineTotal;
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
  String? sEditLock;
  String? sEditLast;
  String? sWpPageTemplate;
  String? sCustomMetaboxProductOptions;
  String? productQty;
  String? productTotal;
  String? totalSales;
  String? sTaxStatus;
  String? sTaxClass;
  String? sManageStock;
  String? sBackorders;
  String? sSoldIndividually;
  String? sVirtual;
  String? sDownloadable;
  String? sDownloadLimit;
  String? sDownloadExpiry;
  String? sWcAverageRating;
  String? sWcReviewCount;
  String? sProductVersion;

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
      this.sShopManager,
      this.sEditLock,
      this.sEditLast,
      this.sWpPageTemplate,
      this.sCustomMetaboxProductOptions,
      this.productQty,
      this.productTotal,
      this.totalSales,
      this.sTaxStatus,
      this.sTaxClass,
      this.sManageStock,
      this.sBackorders,
      this.sSoldIndividually,
      this.sVirtual,
      this.sDownloadable,
      this.sDownloadLimit,
      this.sDownloadExpiry,
      this.sWcAverageRating,
      this.sWcReviewCount,
      this.sProductVersion});

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
    sEditLock = json['_edit_lock'];
    sEditLast = json['_edit_last'];
    sWpPageTemplate = json['_wp_page_template'];
    sCustomMetaboxProductOptions = json['_custom_metabox_product_options'];
    productQty = json['product_qty'];
    productTotal = json['product_total'];
    totalSales = json['total_sales'];
    sTaxStatus = json['_tax_status'];
    sTaxClass = json['_tax_class'];
    sManageStock = json['_manage_stock'];
    sBackorders = json['_backorders'];
    sSoldIndividually = json['_sold_individually'];
    sVirtual = json['_virtual'];
    sDownloadable = json['_downloadable'];
    sDownloadLimit = json['_download_limit'];
    sDownloadExpiry = json['_download_expiry'];
    sWcAverageRating = json['_wc_average_rating'];
    sWcReviewCount = json['_wc_review_count'];
    sProductVersion = json['_product_version'];
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
    data['_edit_lock'] = sEditLock;
    data['_edit_last'] = sEditLast;
    data['_wp_page_template'] = sWpPageTemplate;
    data['_custom_metabox_product_options'] = sCustomMetaboxProductOptions;
    data['product_qty'] = productQty;
    data['product_total'] = productTotal;
    data['total_sales'] = totalSales;
    data['_tax_status'] = sTaxStatus;
    data['_tax_class'] = sTaxClass;
    data['_manage_stock'] = sManageStock;
    data['_backorders'] = sBackorders;
    data['_sold_individually'] = sSoldIndividually;
    data['_virtual'] = sVirtual;
    data['_downloadable'] = sDownloadable;
    data['_download_limit'] = sDownloadLimit;
    data['_download_expiry'] = sDownloadExpiry;
    data['_wc_average_rating'] = sWcAverageRating;
    data['_wc_review_count'] = sWcReviewCount;
    data['_product_version'] = sProductVersion;
    return data;
  }
}

class ProductsPending {
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

  ProductsPending(
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

  ProductsPending.fromJson(Map<String, dynamic> json) {
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

// class ProductMeta {
//   String? productCustomer;
//   String? sProductUrl;
//   String? productSite;
//   String? siteLogo;
//   String? productImage;
//   String? productName;
//   String? productSize;
//   String? productColor;
//   String? sStock;
//   String? productPriceTl;
//   String? productPriceUsd;
//   String? sPrice;
//   String? usdRate;
//   String? productNote;
//   String? sSku;
//   String? sStockStatus;
//   String? sRegularPrice;
//   String? productType;
//   String? sThumbnailId;
//   String? sProductAttributes;
//   String? sProductShopgoStatus;
//   String? shWeight;
//   String? shLength;
//   String? shWidth;
//   String? shHeight;
//   String? sWeight;
//   String? sLength;
//   String? sWidth;
//   String? sHeight;
//   String? sProductShopgoStatusNote;
//   String? productCategories0;
//   String? productCategories1;
//   String? productCategories2;
//   String? sShopManager;
//
//   ProductMeta(
//       {this.productCustomer,
//         this.sProductUrl,
//         this.productSite,
//         this.siteLogo,
//         this.productImage,
//         this.productName,
//         this.productSize,
//         this.productColor,
//         this.sStock,
//         this.productPriceTl,
//         this.productPriceUsd,
//         this.sPrice,
//         this.usdRate,
//         this.productNote,
//         this.sSku,
//         this.sStockStatus,
//         this.sRegularPrice,
//         this.productType,
//         this.sThumbnailId,
//         this.sProductAttributes,
//         this.sProductShopgoStatus,
//         this.shWeight,
//         this.shLength,
//         this.shWidth,
//         this.shHeight,
//         this.sWeight,
//         this.sLength,
//         this.sWidth,
//         this.sHeight,
//         this.sProductShopgoStatusNote,
//         this.productCategories0,
//         this.productCategories1,
//         this.productCategories2,
//         this.sShopManager});
//
//   ProductMeta.fromJson(Map<String, dynamic> json) {
//     productCustomer = json['product_customer'];
//     sProductUrl = json['_product_url'];
//     productSite = json['product_site'];
//     siteLogo = json['site_logo'];
//     productImage = json['product_image'];
//     productName = json['product_name'];
//     productSize = json['product_size'];
//     productColor = json['product_color'];
//     sStock = json['_stock'];
//     productPriceTl = json['product_price_tl'];
//     productPriceUsd = json['product_price_usd'];
//     sPrice = json['_price'];
//     usdRate = json['usd_rate'];
//     productNote = json['product_note'];
//     sSku = json['_sku'];
//     sStockStatus = json['_stock_status'];
//     sRegularPrice = json['_regular_price'];
//     productType = json['productType'];
//     sThumbnailId = json['_thumbnail_id'];
//     sProductAttributes = json['_product_attributes'];
//     sProductShopgoStatus = json['_product_shopgo_status'];
//     shWeight = json['sh_weight'];
//     shLength = json['sh_length'];
//     shWidth = json['sh_width'];
//     shHeight = json['sh_height'];
//     sWeight = json['_weight'];
//     sLength = json['_length'];
//     sWidth = json['_width'];
//     sHeight = json['_height'];
//     sProductShopgoStatusNote = json['_product_shopgo_status_note'];
//     productCategories0 = json['product_categories_0'];
//     productCategories1 = json['product_categories_1'];
//     productCategories2 = json['product_categories_2'];
//     sShopManager = json['_shop_manager'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['product_customer'] = productCustomer;
//     data['_product_url'] = sProductUrl;
//     data['product_site'] = productSite;
//     data['site_logo'] = siteLogo;
//     data['product_image'] = productImage;
//     data['product_name'] = productName;
//     data['product_size'] = productSize;
//     data['product_color'] = productColor;
//     data['_stock'] = sStock;
//     data['product_price_tl'] = productPriceTl;
//     data['product_price_usd'] = productPriceUsd;
//     data['_price'] = sPrice;
//     data['usd_rate'] = usdRate;
//     data['product_note'] = productNote;
//     data['_sku'] = sSku;
//     data['_stock_status'] = sStockStatus;
//     data['_regular_price'] = sRegularPrice;
//     data['productType'] = productType;
//     data['_thumbnail_id'] = sThumbnailId;
//     data['_product_attributes'] = sProductAttributes;
//     data['_product_shopgo_status'] = sProductShopgoStatus;
//     data['sh_weight'] = shWeight;
//     data['sh_length'] = shLength;
//     data['sh_width'] = shWidth;
//     data['sh_height'] = shHeight;
//     data['_weight'] = sWeight;
//     data['_length'] = sLength;
//     data['_width'] = sWidth;
//     data['_height'] = sHeight;
//     data['_product_shopgo_status_note'] = sProductShopgoStatusNote;
//     data['product_categories_0'] = productCategories0;
//     data['product_categories_1'] = productCategories1;
//     data['product_categories_2'] = productCategories2;
//     data['_shop_manager'] = sShopManager;
//     return data;
//   }
// }
class UserCartSession {
  CartTotals? cartTotals;

  UserCartSession({this.cartTotals});

  UserCartSession.fromJson(Map<String, dynamic> json) {
    cartTotals = json['cart_totals'] != null
        ? CartTotals.fromJson(json['cart_totals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartTotals != null) {
      data['cart_totals'] = cartTotals?.toJson();
    }
    return data;
  }
}

class CartTotals {
  late String subtotal;
  late int subtotalTax;
  late String shippingTotal;
  late int shippingTax;
  late int discountTotal;
  late int discountTax;
  late String cartContentsTotal;
  late int cartContentsTax;
  late String feeTotal;
  late int feeTax;
  late String total;
  late int totalTax;
  late String qualityControl;
  late String serviceFees;

  CartTotals({
    required this.subtotal,
    required this.subtotalTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.discountTotal,
    required this.discountTax,
    required this.cartContentsTotal,
    required this.cartContentsTax,
    required this.feeTotal,
    required this.feeTax,
    required this.total,
    required this.totalTax,
    required this.qualityControl,
    required this.serviceFees,
  });
  CartTotals.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'] ?? '';
    subtotalTax = json['subtotal_tax'] ?? 0;
    shippingTotal = json['shipping_total'] ?? '';
    shippingTax = json['shipping_tax'] ?? 0;
    discountTotal = json['discount_total'] ?? 0;
    discountTax = json['discount_tax'] ?? 0;
    cartContentsTotal = json['cart_contents_total'] ?? '';
    cartContentsTax = json['cart_contents_tax'] ?? 0;
    feeTotal = json['fee_total'] ?? '';
    feeTax = json['fee_tax'] ?? 0;
    total = json['total'] ?? '';
    totalTax = json['total_tax'] ?? 0;
    qualityControl = json['quality_control'] ?? '0';
    serviceFees = json['service_fees'] ?? '0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = subtotal;
    data['subtotal_tax'] = subtotalTax;
    data['shipping_total'] = shippingTotal;
    data['shipping_tax'] = shippingTax;
    data['discount_total'] = discountTotal;
    data['discount_tax'] = discountTax;
    data['cart_contents_total'] = cartContentsTotal;
    data['cart_contents_tax'] = cartContentsTax;
    data['fee_total'] = feeTotal;
    data['fee_tax'] = feeTax;
    data['total'] = total;
    data['total_tax'] = totalTax;
    data['quality_control'] = qualityControl;
    data['service_fees'] = serviceFees;
    return data;
  }
}
