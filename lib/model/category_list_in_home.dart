class CategoryListInHome {
  List<Map>? categoriesList;

  CategoryListInHome({this.categoriesList});

  CategoryListInHome.fromJson(Map json) {
    categoriesList = json['categories'];
  }

  Map toJson() {
    final Map data = {};
    data['categories'] = categoriesList;

    return data;
  }
}