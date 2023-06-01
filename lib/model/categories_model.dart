class CategoriesList {
  final List<Categories>? categories;

  CategoriesList({
    this.categories,
  });

  factory CategoriesList.fromJson(List<dynamic> parsedJson) {

    List<Categories> photos = <Categories>[];

    photos = parsedJson.map((i)=>Categories.fromJson(i)).toList();

    return CategoriesList(
      categories: photos,
    );
  }
}

class Categories{
  final String? id;
  final String? name;
  final String? image;

  Categories({
    this.id,
    this.name,
    this.image
  }) ;

  factory Categories.fromJson(Map<String, dynamic> json){
    return Categories(
      id: json['id'].toString(),
      name: json['name'],
      image: json['image'],
    );
  }

}
