class SliderImagesModel {
  int? code;
  String? message;
  List<String>? data;

  SliderImagesModel({this.code, this.message, this.data});

  SliderImagesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}
