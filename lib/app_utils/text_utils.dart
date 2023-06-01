import 'package:flutter/material.dart';
import 'package:shop_go/app_utils/common.dart';

class TextUtils {
  String fontFamily = Common.fontFamily;

  Text normal8(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 8, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium8(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 8, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold8(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 8, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold8(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 8, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal9(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 9, fontWeight: FontWeight.normal, fontFamily: fontFamily),
    );
  }

  Text medium9(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 9, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold9(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 9, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold9(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 9, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal10(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 10, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium10(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 10, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold10(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 10, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold10(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal11(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 11, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium11(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 11, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold11(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 11, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold11(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal12(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 12, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium12(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold12(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 12, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold12(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal13(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 13, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium13(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold13(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 13, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold13(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal14(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 14, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium14(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold14(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold14(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: color==null?TextStyle(height: height, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: fontFamily):TextStyle(color: color, height: height, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal15(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 15, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium15(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 15, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold15(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 15, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold15(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal16(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 16, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium16(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold16(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold16(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal17(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 17, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium17(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 17, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold17(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 17, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold17(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 17, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal18(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 18, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium18(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 18, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold18(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold18(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal19(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 19, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium19(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 19, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold19(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 19, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold19(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 19, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal20(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 20, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium20(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 20, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold20(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold20(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal21(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 21, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium21(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 21, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold21(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 21, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold21(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 21, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal22(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 22, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium22(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 22, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold22(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold22(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal23(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 23, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium23(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 23, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold23(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 23, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold23(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 23, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal24(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 24, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium24(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 24, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold24(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 24, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold24(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal25(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 25, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium25(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 25, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold25(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 25, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold25(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 25, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal26(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 26, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium26(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 26, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold26(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 26, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold26(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 26, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal27(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 27, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium27(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 27, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold27(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 27, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold27(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 27, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal28(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 28, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium28(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 28, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold28(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 28, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold28(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal29(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 29, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium29(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 29, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold29(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 29, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold29(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 29, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text normal30(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 30, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium30(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 30, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold30(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 30, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold30(text, color, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }

  Text boldDynamic(text, color, align, size, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: size, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }
}
