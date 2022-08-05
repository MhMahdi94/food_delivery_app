// ignore_for_file: prefer_collection_literals

class ProductModel {
  int? totalSize;
  int? typeId;
  int? offset;
  List<Products>? products;

  ProductModel({this.totalSize, this.typeId, this.offset, this.products});

  ProductModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    typeId = json['type_id'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_size'] = totalSize;
    data['type_id'] = typeId;
    data['offset'] = offset;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  Products(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stars'] = stars;
    data['img'] = img;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type_id'] = typeId;
    return data;
  }
}
