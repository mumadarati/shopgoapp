import 'package:get/get.dart';
import 'package:shop_go/model/all_brands_model.dart';
import 'package:shop_go/model/brand_categories_model.dart';
import 'package:shop_go/model/calcuate_shipping_rates.dart';
import 'package:shop_go/model/cart_products_model.dart';
import 'package:shop_go/model/categories_model.dart';
import 'package:shop_go/model/category_list_in_home.dart';
import 'package:shop_go/model/current_balance_model.dart';
import 'package:shop_go/model/customer_detail_model.dart';
import 'package:shop_go/model/customer_model.dart';
import 'package:shop_go/model/external_links_model.dart';
import 'package:shop_go/model/get_stories_model.dart';
import 'package:shop_go/model/login_model.dart';
import 'package:shop_go/model/marketing_slider_images_model.dart';
import 'package:shop_go/model/payment_methods.dart';
import 'package:shop_go/model/shipping_countries_model.dart';
import 'package:shop_go/model/shopgo_slider_images_model.dart';
import 'package:shop_go/model/slider_images_model.dart';
import 'package:shop_go/model/transactions_model.dart';
import 'package:shop_go/model/user_wishlist_model.dart';

class CommonController extends GetxController {
  Rx<CreateCustomerModel> customers = CreateCustomerModel().obs;
  Rx<SliderImagesModel> sliderImages = SliderImagesModel().obs;
  Rx<AllBrandsModel> allBrands = AllBrandsModel().obs;
  Rx<CustomerDetailModel> customerDetail = CustomerDetailModel().obs;
  Rx<CategoriesList> categoriesList = CategoriesList().obs;
  Rx<PaymentMethodsModel> paymentMethods = PaymentMethodsModel().obs;
  Rx<GetUserCartModel> userCart = GetUserCartModel().obs;
  Rx<GetStoriesModel> storiesResponse = GetStoriesModel().obs;
  Rx<BrandCategoriesModel> brandCategories = BrandCategoriesModel().obs;
  Rx<LoginDetailModel> loginDetails = LoginDetailModel().obs;
  Rx<UserWishlistModel> userWishlist = UserWishlistModel().obs;
  Rx<TransactionsModel> transactions = TransactionsModel().obs;
  Rx<CurrentBalanceModel> currentBalance = CurrentBalanceModel().obs;
  Rx<ShopGoSliderImagesModel> shopGoSliderImages =
      ShopGoSliderImagesModel().obs;
  Rx<MarketingSliderImagesModel> marketingSliderImages =
      MarketingSliderImagesModel().obs;
  Rx<ExternalLinksModel> externalLinks = ExternalLinksModel().obs;
  Rx<ShippingCountriesModel> shippingCountries = ShippingCountriesModel().obs;
  Rx<CalculateShippingRates> calculateShippingRates =
      CalculateShippingRates().obs;
  RxBool isBrandClicked = RxBool(false);
  RxString brandClickedUrl = RxString('');
  Rx<BrandModel> clickedBrand = BrandModel().obs;
  Rx<CategoryListInHome> categoriesDataCommonController =
      CategoryListInHome().obs;
}
