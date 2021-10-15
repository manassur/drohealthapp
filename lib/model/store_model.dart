class StoreModel {
  bool? error;
  List<Categories>? categories;
  List<Products>? products;

  StoreModel({this.error, this.categories, this.products});

  StoreModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? name;
  String? image;

  Categories({this.id, this.name, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Products {
  String? id;
  String? productId;
  String? title;
  String? name;
  String? type;
  String? mg;
  String? price;
  String? packSize;
  String? dispensation;
  String? constituents;
  String? description;
  String? soldBy;
  bool? isPrescriptionRequired;
  String? categoryId;
  String? image;
  int? quantity=0;

  Products(
      {this.id,
        this.productId,
        this.title,
        this.name,
        this.type,
        this.mg,
        this.price,
        this.packSize,
        this.dispensation,
        this.constituents,
        this.description,
        this.soldBy,
        this.isPrescriptionRequired,
        this.categoryId,
        this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    name = json['name'];
    type = json['type'];
    mg = json['mg'];
    price = json['price'];
    packSize = json['pack_size'];
    dispensation = json['dispensation'];
    constituents = json['constituents'];
    description = json['description'];
    soldBy = json['sold_by'];
    isPrescriptionRequired = json['is_prescription_required'];
    categoryId = json['category_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['name'] = this.name;
    data['type'] = this.type;
    data['mg'] = this.mg;
    data['price'] = this.price;
    data['pack_size'] = this.packSize;
    data['dispensation'] = this.dispensation;
    data['constituents'] = this.constituents;
    data['description'] = this.description;
    data['sold_by'] = this.soldBy;
    data['is_prescription_required'] = this.isPrescriptionRequired;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    return data;
  }
}
