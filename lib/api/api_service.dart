import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shop_go/api/api_base_url.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/controllers/common_controller.dart';
import 'package:shop_go/model/all_brands_model.dart';
import 'package:shop_go/model/brand_categories_model.dart';
import 'package:shop_go/model/calcuate_shipping_rates.dart';
import 'package:shop_go/model/cart_products_model.dart';
import 'package:shop_go/model/category_list_in_home.dart';
import 'package:shop_go/model/current_balance_model.dart';
import 'package:shop_go/model/customer_detail_model.dart';
import 'package:shop_go/model/external_links_model.dart';
import 'package:shop_go/model/get_stories_model.dart';
import 'package:shop_go/model/login_model.dart';
import 'package:shop_go/model/marketing_slider_images_model.dart';
import 'package:shop_go/model/payment_methods.dart';
import 'package:shop_go/model/shipping_countries_model.dart';
import 'package:shop_go/model/shopgo_slider_images_model.dart';
import 'package:shop_go/model/slider_images_model.dart';
import 'package:shop_go/model/transactions_model.dart';
import 'package:shop_go/model/usd_rate_model.dart';
import 'package:shop_go/model/user_wishlist_model.dart';
import 'package:shop_go/model/verify_token_model.dart';
import 'package:shop_go/screens/home_screen.dart';
import 'package:shop_go/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shop_go/screens/payment_webview.dart';

class ApiService {
  final AppUtils _appUtils = AppUtils();
  CommonController commonController = Get.find<CommonController>();
  var box = Hive.box('credentials');

  //1
  Future<UsdRateModel?> getUsdRate() async {
    try {
      var response =
          await http.get(Uri.parse("${BaseUrl.mainUrl}shopgo/v1/usdrate"));

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} usd rate response: ${response.body}");
      }
      if (response.statusCode == 200) {
        UsdRateModel usdRate = UsdRateModel.fromJson(jsonDecode(response.body));
        Common.usdRate = double.parse(usdRate.exUsdTl!);
        debugPrint("Usd Rate : ${Common.usdRate}");
        return usdRate;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //2
  Future<VerifyTokenModel?> verifyToken(String token) async {
    try {
      var body = json.encode({"token": token});

      var response = await http.post(
        Uri.parse("${BaseUrl.authUrl}tokens/verify"),
        body: body,
        headers: {"Content-Type": "application/json"},
      );

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} verify token response: ${response.body}");
      }
      if (response.statusCode == 200) {
        VerifyTokenModel verifyToken =
            VerifyTokenModel.fromJson(jsonDecode(response.body));
        if (verifyToken.status == "active") {
          Common.accessToken.value = token;
        } else {
          Common.accessToken.value = "";
        }
        Get.offAll(() => const HomeScreen());
        return verifyToken;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //3
  Future<GetUserCartModel?> getUserCart() async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };

      var response = await http.get(
          (Uri.parse("${BaseUrl.mainUrl}shopgo/v1/cart")),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} cart response: ${response.body}");
      }
      if (response.statusCode == 200) {
        commonController.userCart.value =
            GetUserCartModel.fromJson(jsonDecode(response.body));

        return commonController.userCart.value;
      }
    } catch (e) {
      if (kDebugMode) {
        print("cart status code: err :$e ");
      }
      log(e.toString());
    }
    return null;
  }

  //4
  Future<int?> addToCartApi(String url, String type) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };
      var response = await http.get(
          Uri.parse(
              "${BaseUrl.mainUrl}shopgo/v1/addproduct/?product_url=$url&product_type=$type"),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} cart response: ${response.body}");
      }
      if (response.statusCode == 200) {
        Get.back();
        _appUtils.showToast("Added to cart successfully");
        return 200;
      } else {
        Get.back();
        _appUtils.showToast("Error, Try Again");
        return response.statusCode;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //5
  Future<LoginDetailModel?> login(
      String username, String password, String origin,
      [bool isGmail = false,
      String uid = '',
      String idToken = '',
      String email = '',
      String displayName = '']) async {
    try {
      var box = Hive.box('credentials');
      var deviceToken = box.get('deviceToken') ?? '';
      var body;
      String url = '';
      if (isGmail) {
        url = "https://shopgobravo.com/wp-json/shopgo/v1/gmail_login";
        body = json.encode({
          "status": "SUCCESS",
          "uid": uid,
          "user_device_token": deviceToken,
          "email": email,
          "username": displayName,
          "first_name": "",
          "last_name": "",
          "url": "",
          "gender": "",
          "about": "",
          "deuimage": "",
          "idToken": idToken,
        });
      } else {
        url = "${BaseUrl.authUrl}login";
        body = json.encode({
          "username": username,
          "password": password,
          "user_device_token": deviceToken
        });
      }
      var response = await http.post(Uri.parse(url),
          body: body, headers: {"Content-Type": "application/json","Accept":"*/*"});

      if (kDebugMode) {
        print(
            "status code: ${response.statusCode} login response: ${response.body}");
      }

      if (response.statusCode == 200) {
        commonController.loginDetails.value =
            LoginDetailModel.fromJson(jsonDecode(response.body));

        box.put('token', commonController.loginDetails.value.accessToken);
        Common.accessToken.value =
            commonController.loginDetails.value.accessToken!;
        box.put("userId", commonController.loginDetails.value.wpUser!.iD);
        if (origin == "start" || origin == "logout") {
          Common.currentIndex.value = 0;
          Get.offAll(() => const HomeScreen());
        } else {
          Get.back();
          Get.back();
          getCustomerDetail(
              commonController.loginDetails.value.wpUser!.iD.toString());
          getUserCart();
          getUserWishlist();
          getCurrentBalance();
          getTransactions();
          if (Common.isFromCurrentIndex.value) {
            Get.offAll(() => const HomeScreen());
          }
        }
        _appUtils.showToast("Login Successfully");
        switch (commonController.loginDetails.value.languageCode) {
          case 'ar':
            Get.updateLocale(const Locale('ar'));
            break;
          case 'he_IL':
            Get.updateLocale(const Locale('he', 'IL'));
            break;
          case 'en_US':
            Get.updateLocale(const Locale('en', 'US'));
            break;
          default:
            Get.updateLocale(const Locale('en', 'US'));
        }

        return commonController.loginDetails.value;
      } else if (response.statusCode == 500) {
        Get.back();
        _appUtils.showToast("Invalid Email or Password");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //6
  Future<int?> registerUser(String username, email, password, confirmPassword,
      phone, firstName, lastName, language) async {
    try {
      var box = Hive.box('credentials');
      var deviceToken = box.get('deviceToken') ?? '';
      var body = json.encode({
        "user_email": email,
        "user_pass1": password,
        "user_pass2": confirmPassword,
        "user_phone": phone,
        "user_username": username,
        "user_first_name": firstName,
        "user_last_name": lastName,
        "user_language": language,
        "user_device_token": deviceToken
      });

      var response = await http.post(Uri.parse("${BaseUrl.authUrl}register"),
          body: body, headers: {"Content-Type": "application/json"});

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} user response: ${response.body}");
      }

      if (response.statusCode == 200) {
        Get.back();
        _appUtils.showToast("User Register Successfully");
        Common.tabController!.index = 0;
        return 200;
      } else if (response.statusCode == 401) {
        Get.back();
        _appUtils.showToast("Username or Email is already in use");
        return 401;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //7
  Future<int?> logout() async {
    try {
      Map<String, String> headers = {
        "Authorization": "Bearer ${Common.accessToken.value}"
      };

      var response = await http.post(
        Uri.parse("${BaseUrl.authUrl}tokens/logout"),
        headers: headers,
      );

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} logout response: ${response.body}");
      }

      if (response.statusCode == 200) {
        box.delete("token");
        box.delete("userId");
        bool rememberPassword = box.get("remember_password");
        if (!rememberPassword) {
          box.delete("remember_password");
          box.delete("password");
        }
        box.delete("deviceToken");

        Common.accessToken.value = "";
        Get.back();
        Get.offAll(() => const LoginScreen(
              origin: "logout",
            ));
        _appUtils.showToast("Logout Successfully");
        return 200;
      } else if (response.statusCode == 400) {
        Get.back();
        _appUtils.showToast("You are not logged in");
        return 400;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future resetPassword(String email) async {
    try {
      Map<String, String> headers = {};
      var response = await http.post(
        Uri.parse("${BaseUrl.authUrl}password/reset"),
        body: {'email': email.toString()},
        headers: headers,
      );
      if (kDebugMode) {
        print(
            "status code: ${response.statusCode} resetPassword response: ${response.body}");
      }
      if (response.statusCode == 200) {
        bool result = jsonDecode(response.body)[0]['result'];
        if (result) {
          Get.back();
          _appUtils.showToast("Email has been sent");
        } else {
          Get.back();
          _appUtils.showToast("Wrong email");
        }
      } else if (response.statusCode == 400) {
        Get.back();
        _appUtils.showToast("Error");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //8
  Future<SliderImagesModel?> sliderImagesApi() async {
    try {
      var response =
          await http.get(Uri.parse("${BaseUrl.v2Url}get_slider_images"));

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} images response: ${response.body}");
      }

      if (response.statusCode == 200) {
        commonController.sliderImages.value =
            SliderImagesModel.fromJson(jsonDecode(response.body));

        return commonController.sliderImages.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //9
  getCategoriesApis() async {
    try {
      var response =
          await http.get(Uri.parse("${BaseUrl.mainUrl}shopgo/v1/categories"));

      // if (kDebugMode) {
      //   print("\nstatus code: ${response.statusCode} categories response: ${response.body}");
      // }

      if (response.statusCode == 200) {
        commonController.brandCategories.value =
            BrandCategoriesModel.fromJson(jsonDecode(response.body));
        var categories = commonController.brandCategories.value.brandsList!;
        Common.categoriesData.clear();
        Common.categoriesData.add({
          "icon": categories.womenCat!.icon,
          "id": categories.womenCat!.idCat,
          "title": categories.womenCat!.title
        });
        Common.categoriesData.add({
          "icon": categories.menCat!.icon,
          "id": categories.menCat!.idCat,
          "title": categories.menCat!.title
        });
        Common.categoriesData.add({
          "icon": categories.kidsCat!.icon,
          "id": categories.kidsCat!.idCat,
          "title": categories.kidsCat!.title
        });
        Common.categoriesData.add({
          "icon": categories.homeCat!.icon,
          "id": categories.homeCat!.idCat,
          "title": categories.homeCat!.title
        });
        Common.categoriesData.add({
          "icon": categories.cosmeticsCat!.icon,
          "id": categories.cosmeticsCat!.idCat,
          "title": categories.cosmeticsCat!.title
        });
        Common.categoriesData.add({
          "icon": categories.accessoriesCat!.icon,
          "id": categories.accessoriesCat!.idCat,
          "title": categories.accessoriesCat!.title
        });
        Common.categoriesData.add({
          "icon": categories.shoesCat!.icon,
          "id": categories.shoesCat!.idCat,
          "title": categories.shoesCat!.title
        });
        Common.categoriesData.add({
          "icon": categories.sweetsCat!.icon,
          "id": categories.sweetsCat!.idCat,
          "title": categories.sweetsCat!.title
        });
        commonController.categoriesDataCommonController.value =
            CategoryListInHome.fromJson({'categories': Common.categoriesData});
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //10
  Future<List<BrandModel>?> getAllBrands() async {
    try {
      var response = await http
          .get(Uri.parse("${BaseUrl.mainUrl}shopgo/v1/brands_actions"));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        AllBrandsModel brandsListApi = AllBrandsModel.fromJson(data);
        commonController.allBrands.value = brandsListApi;
        return commonController.allBrands.value.brandsList;
      }
    } catch (e) {
      debugPrint('error $e');
    }
    return null;
  }

  //11
  Future<CustomerDetailModel?> getCustomerDetail(String customerId) async {
    try {
      var response = await http.get(Uri.parse(
          "${BaseUrl.baseUrl}customers/$customerId?consumer_key=${Common.consumerKey}&consumer_secret=${Common.consumerSecret}"));

      if (kDebugMode) {
        print(
            "\n ---------- status code: ${response.statusCode} customer response: ${response.body}");
      }

      if (response.statusCode == 200) {
        commonController.customerDetail.value =
            CustomerDetailModel.fromJson(jsonDecode(response.body));

        return commonController.customerDetail.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //12
  Future<GetStoriesModel?> getStoriesApi() async {
    try {
      var response =
          await http.get(Uri.parse("${BaseUrl.mainUrl}shopgo/v1/get_stories"));

      //  if (kDebugMode) {
      //    print("\nstatus code: ${response.statusCode} stories response: ${response.body}");
      //  }

      if (response.statusCode == 200) {
        commonController.storiesResponse.value =
            GetStoriesModel.fromJson(jsonDecode(response.body));

        return commonController.storiesResponse.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //13
  Future<int?> changePasswordApi(
      String customerId, String password, String newPassword) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };

      var formData = {
        'user_id': customerId,
        'password': password,
        'new_password': newPassword,
      };

      if (kDebugMode) {
        print("formData: $formData  ");
        print("formData: ${Common.accessToken.value}");
      }
      var response = await http.post(
          Uri.parse("${BaseUrl.v2Url}change_password"),
          body: formData,
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} password response: ${response.body}");
      }

      if (response.statusCode == 200) {
        Get.back();
        _appUtils.showToast("Password changed successfully");
        Get.back();
        return 200;
      } else {
        Get.back();
        _appUtils.showSnakeBar("Error", "Error Try Again");
        return 400;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //14
  Future<int?> updateCustomerProfile(String customerId, String firstName,
      String lastName, String email) async {
    try {
      var body = json.encode(
          {"first_name": firstName, "last_name": lastName, "email": email});

      var response = await http.post(
          Uri.parse(
              "${BaseUrl.baseUrl}customers/$customerId?consumer_key=${Common.consumerKey}&consumer_secret=${Common.consumerSecret}"),
          body: body,
          headers: {"Content-Type": "application/json"});

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} update customer: ${response.body}");
      }

      if (response.statusCode == 200) {
        Get.back();
        _appUtils.showToast("Profile Updated Successfully");
        Get.back();
        return 200;
      } else {
        Get.back();
        _appUtils.showSnakeBar("Error", "Error Try Again");
        return 400;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //15
  Future<PaymentMethodsModel?> getPaymentMethods() async {
    try {
      var response = await http.get(Uri.parse(
          "${BaseUrl.baseUrl}payment_gateways?consumer_key=${Common.consumerKey}&consumer_secret=${Common.consumerSecret}"));

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} payment methods: ${response.body}");
      }

      if (response.statusCode == 200) {
        commonController.paymentMethods.value =
            PaymentMethodsModel.fromJson(jsonDecode(response.body));

        return commonController.paymentMethods.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //16
  Future<int?> addToWishlistApi(String url) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };

      var response = await http.post(
          Uri.parse(
              "${BaseUrl.mainUrl}shopgo/v1/add_to_wishlist/?product_url=$url&product_type=yu_go"),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} wishlist response: ${response.body}");
      }
      if (response.statusCode == 200) {
        Get.back();
        _appUtils.showToast("Added to wishlist successfully");
        return 200;
      } else {
        Get.back();
        _appUtils.showToast("Error, Try Again");
        return response.statusCode;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //17
  Future<UserWishlistModel?> getUserWishlist() async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };

      var response = await http.get(
          Uri.parse("${BaseUrl.mainUrl}shopgo/v1/wishlist"),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} wishlist response: ${response.body}");
      }
      if (response.statusCode == 200) {
        commonController.userWishlist.value =
            UserWishlistModel.fromJson(jsonDecode(response.body));

        return commonController.userWishlist.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //18
  Future<int?> deleteWishlist(String productId) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };

      var response = await http.delete(
          Uri.parse(
              "${BaseUrl.mainUrl}shopgo/v1/delete_from_wishlist/?product_id=$productId"),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} delete wishlist response: ${response.body}");
      }
      if (response.statusCode == 200) {
        Get.back();
        _appUtils.showToast("Product deleted from wishlist");
        getUserWishlist();

        return 200;
      } else {
        Get.back();
        _appUtils.showToast("Error,Try Again");
        return response.statusCode;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //19
  Future<int?> addToCartFromWishlist(
      String productId, String customerId) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };

      var response = await http.post(
          Uri.parse(
              "${BaseUrl.mainUrl}shopgo/v1/wishlist_add_to_cart/?product_id=$productId&customer_id=$customerId"),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} add to cart from wishlist response: ${response.body}");
      }
      if (response.statusCode == 200) {
        Get.back();
        _appUtils.showToast("Added to cart successfully");
        getUserWishlist();

        return 200;
      } else {
        Get.back();
        _appUtils.showToast("Error,Try Again");
        return response.statusCode;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //20
  Future<TransactionsModel?> getTransactions() async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };

      var response = await http.get(
          Uri.parse("${BaseUrl.mainUrl}shopgo/v1/transactions"),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} transactions response: ${response.body}");
      }
      if (response.statusCode == 200) {
        commonController.transactions.value =
            TransactionsModel.fromJson(jsonDecode(response.body));

        return commonController.transactions.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //21
  Future<CurrentBalanceModel?> getCurrentBalance() async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };

      var response = await http.get(
          Uri.parse("${BaseUrl.mainUrl}shopgo/v1/balance"),
          headers: headers);

      // if (kDebugMode) {
      //   print("\nstatus code: ${response.statusCode} current balance response: ${response.body}");
      // }
      if (response.statusCode == 200) {
        commonController.currentBalance.value =
            CurrentBalanceModel.fromJson(jsonDecode(response.body));

        return commonController.currentBalance.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //22
  Future<ShopGoSliderImagesModel?> getShopGoSliderImages() async {
    try {
      var response = await http
          .get(Uri.parse("${BaseUrl.mainUrl}shopgo/v1/shopgo_slider_images"));

      // if (kDebugMode) {
      //   print("\nstatus code: ${response.statusCode} shop go slider images: ${response.body}");
      // }
      if (response.statusCode == 200) {
        commonController.shopGoSliderImages.value =
            ShopGoSliderImagesModel.fromJson(jsonDecode(response.body));

        return commonController.shopGoSliderImages.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //23
  Future<MarketingSliderImagesModel?> marketingSliderImages() async {
    try {
      var response = await http.get(
          Uri.parse("${BaseUrl.mainUrl}shopgo/v1/marketing_slider_images"));

      // if (kDebugMode) {
      //   print("\nstatus code: ${response.statusCode} marketing slider images: ${response.body}");
      // }
      if (response.statusCode == 200) {
        commonController.marketingSliderImages.value =
            MarketingSliderImagesModel.fromJson(jsonDecode(response.body));

        return commonController.marketingSliderImages.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //24
  Future<ExternalLinksModel?> getExternalLinks() async {
    try {
      var response =
          await http.get(Uri.parse("${BaseUrl.mainUrl}shopgo/v1/links"));

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} external links: ${response.body}");
      }
      if (response.statusCode == 200) {
        commonController.externalLinks.value =
            ExternalLinksModel.fromJson(jsonDecode(response.body));

        return commonController.externalLinks.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //25
  Future<int?> deleteCartProducts(String productId) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };
      var response = await http.delete(
          Uri.parse(
              "${BaseUrl.mainUrl}shopgo/v1/remove_product?product_id=$productId"),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} external links: ${response.body}");
      }
      if (response.statusCode == 200) {
        await getUserCart();
        Get.back();
        _appUtils.showToast("Product deleted from cart");
        return 200;
      } else {
        Get.back();
        _appUtils.showToast("Error, try Again");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //26
  Future<int?> addNewAddress(body) async {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ' '${Common.accessToken.value}'
      };
      var response = await http.put(
          Uri.parse(//TODO BaseUrl.mainUrl = (( dev.shopgobravo.com ))
              "https://shopgobravo.com/wc-api/v3/customers/${Common.userId.value}?consumer_key=${Common.consumerKey}&consumer_secret=${Common.consumerSecret}"),
          headers: headers,
          body: body);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} add address response: ${response.body}");
      }
      if (response.statusCode == 200) {
        Get.back();
        _appUtils.showToast("Address saved successfully");
        Get.back();
        getCustomerDetail(Common.userId.value);
        return 200;
      } else {
        Get.back();
        _appUtils.showToast("Error, try again");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //27
  Future<ShippingCountriesModel?> getShippingCountries() async {
    try {
      var response = await http.get(
        Uri.parse('${BaseUrl.mainUrl}shopgo/v1/shipping_countries_list'),
      );

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} shipping countries response: ${response.body}");
      }
      if (response.statusCode == 200) {
        commonController.shippingCountries.value =
            ShippingCountriesModel.fromJson(jsonDecode(response.body));
        return commonController.shippingCountries.value;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //28
  Future<int> calculateShippingRates(
      {required String units,
      required String weight,
      required String width,
      required String length,
      required String height}) async {
    try {
      var response = await http.get(
        Uri.parse(
            '${BaseUrl.mainUrl}shopgo/v1/shipping_calc?units=$units&weight=$weight&width=$width&length=$length&height=$height'),
        // '${BaseUrl.mainUrl}shopgo/v1/shipping_calc?units=kg-cm&weight=2&width=20&length=25&height=5t'),
      );

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} shipping countries response: ${response.body}");
      }
      if (response.statusCode == 200) {
        commonController.calculateShippingRates.value =
            CalculateShippingRates.fromJson(jsonDecode(response.body));
        return commonController.calculateShippingRates.value.shippingRate ?? 0;
      }
    } catch (e) {
      log(e.toString());
    }
    return 0;
  }

  //29
  placeOrder() async {
    _appUtils.showLoadingDialog();
    List lineItem = [];
    commonController.userCart.value.productsInCart?.forEach((element) {
      lineItem.add(
          {"product_id": "${element.productId}", "quantity": "${element.qty}"});
    });
    var orderDetails = {
      'customer_id': commonController.customerDetail.value.id,
      'payment_method': 'cod',
      "payment_method_title": "Direct Bank Transfer",
      "set_paid": false,
      "billing": commonController.customerDetail.value.billing?.toJson(),
      "shipping": commonController.customerDetail.value.shipping == null
          ? commonController.customerDetail.value.shipping?.toJson()
          : commonController.customerDetail.value.billing?.toJson(),
      "line_items": lineItem
    };
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
        'Content-Type': 'application/json'
      };
      var response = await http.post(
          Uri.parse("${BaseUrl.mainUrl}shopgo/v1/create"),
          body: json.encode(orderDetails),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode} placeOrder response: ${response.body}");
      }
      if (response.statusCode == 201) {
        dynamic bodyResponse = jsonDecode(response.body);
        String orderId = bodyResponse['id'].toString();
        await getPaymentUrl(orderId);
      } else {
        _appUtils.showSnakeBar("Error", "Error Try Again");
        return 400;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  getPaymentUrl(String orderId) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer ' '${Common.accessToken.value}',
      };
      var response = await http.post(
          Uri.parse("${BaseUrl.mainUrl}shopgo/v1/payment_paytr"),
          body: json.encode({"order_id": orderId}),
          headers: headers);

      if (kDebugMode) {
        print(
            "\nstatus code: ${response.statusCode}  response: ${response.body}");
      }

      if (response.statusCode == 200) {
        dynamic bodyResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("body response: $bodyResponse");
        }
        String iframeSrc = bodyResponse['iframe_src'];
        if (orderId.isNotEmpty) {
          Get.back();
          Get.to(() => PaymentWebView(iframeSrc: iframeSrc));
        } else {
          _appUtils.showSnakeBar("Error", "Error Try Again");
          return 400;
        }
      } else {
        _appUtils.showSnakeBar("Error", "Error Try Again");
        return 400;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
