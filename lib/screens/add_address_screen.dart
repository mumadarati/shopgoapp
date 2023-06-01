import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shop_go/api/api_service.dart';
import 'package:shop_go/app_utils/app_utils.dart';
import 'package:shop_go/app_utils/color_utils.dart';
import 'package:shop_go/app_utils/common.dart';
import 'package:shop_go/app_utils/text_utils.dart';
import 'package:shop_go/controllers/common_controller.dart';

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final AppUtils _appUtils = AppUtils();
  final TextUtils _textUtils = TextUtils();
  TextEditingController addressTitleController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = {};
  double? lat, lng;
  RxInt defaultAddress = 1.obs;
  String postalCode = '';
  String country = '';
  String? countryDropdownvalue;
  CommonController commonController = Get.find<CommonController>();

  @override
  void initState() {
    super.initState();
    ApiService().getShippingCountries();
    countryDropdownvalue = 'Israel';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.whiteColor,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: ColorUtils.blackColor,
            onPressed: () => Get.back()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: _textUtils.bold18(
                  "add_address".tr, ColorUtils.purpleColor, TextAlign.center),
            ),
            const SizedBox(height: 30),

            _textUtils.bold14(
                "address_title".tr, ColorUtils.blackColor, TextAlign.start),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: TextFormField(
                controller: addressTitleController,
                keyboardType: TextInputType.text,
                decoration: _appUtils.inputDecorationWithLabel(
                    'officeOrhome'.tr, '', ColorUtils.whiteColor),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _textUtils.bold14(
                          "Country".tr, ColorUtils.blackColor, TextAlign.start),
                      Obx(() => commonController.shippingCountries.value.to !=
                              null
                          ? Container(
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: ColorUtils.greyColor)),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: TextUtils().normal14("Country",
                                    ColorUtils.greyColor, TextAlign.start),
                                value: countryDropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                underline: const SizedBox(),
                                // Array list of items
                                items: ['Israel'].map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    countryDropdownvalue = value;
                                  });
                                },
                                // After selecting the desired option,it will
                                // change button value to selected value
                              ),
                            )
                          : Center(
                              child: CupertinoActivityIndicator(
                                  color: ColorUtils.purpleColor))),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _textUtils.bold14(
                          "city".tr, ColorUtils.blackColor, TextAlign.start),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: cityController,
                          keyboardType: TextInputType.text,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z\\s]")),
                          ],
                          decoration: _appUtils.inputDecorationWithLabel(
                            'Tel Aviv',
                            '',
                            ColorUtils.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _textUtils.bold14(
                          "state".tr, ColorUtils.blackColor, TextAlign.start),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: stateController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z\\s]")),
                          ],
                          keyboardType: TextInputType.text,
                          decoration: _appUtils.inputDecorationWithLabel(
                              'Tel Aviv District', '', ColorUtils.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _textUtils.bold14("Postal Code".tr, ColorUtils.blackColor,
                          TextAlign.start),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: postalcodeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          onChanged: (value) => {postalCode = value},
                          decoration: _appUtils.inputDecorationWithLabel(
                              '00000 or 0000000', '', ColorUtils.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _textUtils.bold14(
                '${"address".tr} 1', ColorUtils.blackColor, TextAlign.start),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                controller: addressController,
                keyboardType: TextInputType.text,
                decoration: _appUtils.inputDecorationWithLabel(
                    '', '', ColorUtils.whiteColor),
              ),
            ),
            const SizedBox(height: 15),
            _textUtils.bold14(
                '${"address".tr} 2', ColorUtils.blackColor, TextAlign.start),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                controller: address2Controller,
                keyboardType: TextInputType.text,
                decoration: _appUtils.inputDecorationWithLabel(
                    '', '', ColorUtils.whiteColor),
              ),
            ),
            const SizedBox(height: 15),
            _textUtils.bold14(
                "phone_number".tr, ColorUtils.blackColor, TextAlign.start),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                maxLength: 10,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: ColorUtils.hintColor,
                      height: 1.5,
                      fontFamily: Common.fontFamily,
                      fontWeight: FontWeight.w500),
                  hintText: '5XX XXXXXXX',
                  labelStyle: TextStyle(
                      fontSize: 14,
                      color: ColorUtils.hintColor,
                      height: 1,
                      fontFamily: Common.fontFamily,
                      fontWeight: FontWeight.w500),
                  labelText: 'phone_number'.tr,
                  floatingLabelStyle: TextStyle(color: ColorUtils.purpleColor),
                  filled: true,
                  alignLabelWithHint: true,
                  fillColor: ColorUtils.whiteColor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: ColorUtils.lightPurpleColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: ColorUtils.purpleColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: ColorUtils.lightPurpleColor)),
                  prefixIcon: SizedBox(
                    width: 80,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SvgPicture.asset('assets/images/phone.svg',
                              height: 20,
                              width: 20,
                              color: ColorUtils.purpleColor),
                        ),
                        const Text('+972 ')
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Container(
            //   width: double.infinity,
            //   decoration: _appUtils.boxDecoration(ColorUtils.whiteColor, ColorUtils.whiteColor,),
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   child: Image.asset("assets/images/map_image.png",fit: BoxFit.cover,width: double.infinity,height: 300),
            // ),
            SizedBox(
              height: 200,
              width: size.width,
              child: GoogleMap(
                compassEnabled: false,
                mapToolbarEnabled: false,
                onMapCreated: onMapCreated,
                initialCameraPosition:
                    const CameraPosition(target: LatLng(0.0, 0.0), zoom: 17),
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: markers,
                onTap: (LatLng pos) {
                  setState(() {
                    lat = pos.latitude;
                    lng = pos.longitude;
                    markers.add(Marker(
                      markerId: const MarkerId("newLocation"),
                      position: pos,
                    ));
                  });
                },
              ),
            ),
            // const SizedBox(height: 20),
            // InkWell(
            //   onTap: () {
            //     getUserCurrentLocation();
            //   },
            //   child: Container(
            //     height: 50,
            //     width: Get.size.width,
            //     decoration: _appUtils.boxDecoration(
            //         ColorUtils.purpleColor, ColorUtils.purpleColor),
            //     margin: const EdgeInsets.only(top: 30, bottom: 10),
            //     alignment: Alignment.center,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.location_on,
            //           color: ColorUtils.whiteColor,
            //           size: 20,
            //         ),
            //         const SizedBox(
            //           width: 7,
            //         ),
            //         _textUtils.medium14('use_current_location'.tr,
            //             ColorUtils.whiteColor, TextAlign.center),
            //       ],
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                if (countryDropdownvalue == null) {
                  _appUtils.showToast("Country".tr);
                } else if (cityController.text.trim().isEmpty) {
                  _appUtils.showToast("enter_city".tr);
                } else if (stateController.text.trim().isEmpty) {
                  _appUtils.showToast("enter_state".tr);
                } else if (!(postalcodeController.text.length == 5) &&
                    !(postalcodeController.text.length == 7)) {
                  _appUtils.showToast("enter_PostalCode".tr);
                } else if (addressController.text.trim().isEmpty) {
                  _appUtils.showToast("Address 1 can not be left blank".tr);
                } else if ((phoneController.text.startsWith('0') &&
                        phoneController.text.length != 10) ||
                    (!phoneController.text.startsWith('0') &&
                        phoneController.text.length != 9)) {
                  _appUtils.showToast("enter_phone_number".tr);
                } else {
                  saveAddressData();
                }
              },
              child: Container(
                height: 50,
                width: Get.size.width,
                decoration: _appUtils.boxDecoration(
                    ColorUtils.purpleColor, ColorUtils.purpleColor),
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: _textUtils.medium14(
                    "Add new address", ColorUtils.whiteColor, TextAlign.center),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void getUserCurrentLocation() async {
    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      try {
        await Geolocator.getCurrentPosition().then((value) async {
          try {
            var address = await Geocoder.local
                .findAddressesFromCoordinates(
                    Coordinates(value.latitude, value.longitude))
                .onError((error, stackTrace) {
              Fluttertoast.showToast(
                  msg: error.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  fontSize: 16.0);
              return [];
            });
            print(
                ' ${address.first.addressLine}, ${address.first.locality}, ${address.first.postalCode}');
            final GoogleMapController controller = await mapController.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(value.latitude, value.longitude),
                    zoom: 17)));
            markers.add(Marker(
                markerId: const MarkerId("newLocation"),
                position: LatLng(value.latitude, value.longitude)));
            lat = value.latitude;
            lng = value.longitude;
            cityController.text = address.first.locality!;
            addressController.text = address.first.addressLine!;
            postalCode = address.first.postalCode!;
            country = address.first.countryName!;
            setState(() {});
          } catch (e) {
            _appUtils.showToast(e.toString());
          }
        }).onError((error, stackTrace) {
          Fluttertoast.showToast(
              msg: error.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              fontSize: 16.0);
          return null;
        });
      } catch (e) {
        _appUtils.showToast(e.toString());
      }
    } else {
      _appUtils.showToast(
          'You need to allow location permission in order to continue');
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController.complete(controller);
    });
  }

  saveAddressData() async {
    var customer = commonController.customerDetail.value;
    var body = json.encode({
      "customer": {
        "first_name": customer.firstName,
        "billing_address": {
          "first_name": customer.firstName,
          "last_name": customer.lastName,
          "company": addressTitleController.text,
          "country": countryDropdownvalue.toString(),
          "city": cityController.text,
          "state": stateController.text,
          "postcode": postalCode,
          "address_1": addressController.text,
          "address_2": address2Controller.text,
          "phone": phoneController.text,
          "email": customer.email
        },
        "shipping_address": {
          "first_name": customer.firstName,
          "last_name": customer.lastName,
          "company": addressTitleController.text,
          "country": countryDropdownvalue.toString(),
          "city": cityController.text,
          "state": stateController.text,
          "postcode": postalCode,
          "address_1": addressController.text,
          "address_2": stateController.text,
          "email": customer.email,
          "phone": phoneController.text
        }
      }
    });
    print("body$body");
    _appUtils.showLoadingDialog();
    ApiService().addNewAddress(body);
  }
}
