class LoginDetailModel {
  WpUser? wpUser;
  String? accessToken;
  int? expiresIn;
  String? refreshToken;
  String? languageCode;

  LoginDetailModel(
      {this.wpUser, this.accessToken, this.expiresIn, this.refreshToken});

  LoginDetailModel.fromJson(Map<String, dynamic> json) {
    wpUser =
    json['wp_user'] != null ? WpUser.fromJson(json['wp_user']) : null;
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    languageCode = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wpUser != null) {
      data['wp_user'] = wpUser!.toJson();
    }
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['refresh_token'] = refreshToken;
    data['language'] = languageCode;
    return data;
  }
}

class WpUser {
  Data? data;
  int? iD;
  Caps? caps;
  String? capKey;
  List<String>? roles;
  Allcaps? allcaps;
  Null? filter;

  WpUser(
      {this.data,
        this.iD,
        this.caps,
        this.capKey,
        this.roles,
        this.allcaps,
        this.filter});

  WpUser.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    iD = json['ID'];
    caps = json['caps'] != null ? Caps.fromJson(json['caps']) : null;
    capKey = json['cap_key'];
    roles = json['roles'].cast<String>();
    allcaps =
    json['allcaps'] != null ? Allcaps.fromJson(json['allcaps']) : null;
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['ID'] = iD;
    if (caps != null) {
      data['caps'] = caps!.toJson();
    }
    data['cap_key'] = capKey;
    data['roles'] = roles;
    if (allcaps != null) {
      data['allcaps'] = allcaps!.toJson();
    }
    data['filter'] = filter;
    return data;
  }
}

class Data {
  String? iD;
  String? userLogin;
  String? userNicename;
  String? userEmail;
  String? userUrl;
  String? userRegistered;
  String? userActivationKey;
  String? userStatus;
  String? displayName;

  Data(
      {this.iD,
        this.userLogin,
        this.userNicename,
        this.userEmail,
        this.userUrl,
        this.userRegistered,
        this.userActivationKey,
        this.userStatus,
        this.displayName});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userLogin = json['user_login'];
    userNicename = json['user_nicename'];
    userEmail = json['user_email'];
    userUrl = json['user_url'];
    userRegistered = json['user_registered'];
    userActivationKey = json['user_activation_key'];
    userStatus = json['user_status'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['user_login'] = userLogin;
    data['user_nicename'] = userNicename;
    data['user_email'] = userEmail;
    data['user_url'] = userUrl;
    data['user_registered'] = userRegistered;
    data['user_activation_key'] = userActivationKey;
    data['user_status'] = userStatus;
    data['display_name'] = displayName;
    return data;
  }
}

class Caps {
  bool? customer;

  Caps({this.customer});

  Caps.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer'] = customer;
    return data;
  }
}

class Allcaps {
  bool? read;
  bool? frmViewForms;
  bool? frmViewReports;
  bool? frmEditDisplays;
  bool? frmDeleteEntries;
  bool? customer;

  Allcaps(
      {this.read,
        this.frmViewForms,
        this.frmViewReports,
        this.frmEditDisplays,
        this.frmDeleteEntries,
        this.customer});

  Allcaps.fromJson(Map<String, dynamic> json) {
    read = json['read'];
    frmViewForms = json['frm_view_forms'];
    frmViewReports = json['frm_view_reports'];
    frmEditDisplays = json['frm_edit_displays'];
    frmDeleteEntries = json['frm_delete_entries'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['read'] = read;
    data['frm_view_forms'] = frmViewForms;
    data['frm_view_reports'] = frmViewReports;
    data['frm_edit_displays'] = frmEditDisplays;
    data['frm_delete_entries'] = frmDeleteEntries;
    data['customer'] = customer;
    return data;
  }
}
