import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/tag.dart';
import 'package:grocery_app/services/networking.dart';
import 'package:grocery_app/woo/config.dart';

class Product {
  int id;
  String name;
  String description;
  String shortDescription;
  String sku;
  String slug;
  String price;
  String regularPrice;
  String salePrice;
  String stockStatus;
  String permaLink;
  bool onSale;
  List<String> images = [];
  List<Cat> categories = [];
  List<Tag> tags;
  Product(
      {this.id,
      this.name,
      this.description,
      this.shortDescription,
      this.sku,
      this.slug,
      this.price,
      this.regularPrice,
      this.salePrice,
      this.stockStatus,
      this.permaLink,
      this.onSale,
      this.images,
      this.categories,
      this.tags});

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    shortDescription = json["short_description"];
    slug = json["slug"];
    onSale = json["on_sale"];
    sku = json["sku"];
    permaLink = json["permalink"];
    price = json["price"];
    regularPrice = json["regular_price"];
    salePrice = json["sale_price"];
    stockStatus = json["stock_status"];

    if (json["categories"] != null) {
      json["categories"].forEach((v) {
        categories.add(new Cat(id: v["id"], name: v["name"], slug: v["slug"]));
      });
    }
    if (json["tags"] != null) {
      json["tags"].forEach((t) {
        tags.add(new Tag(id: t["id"], name: t["name"], slug: t["slug"]));
      });
    }
    if (json["images"] != null) {
      json["images"].forEach((i) {
        images.add(i["src"]);
      });
    }
  }

  Future<dynamic> getProducts(String tag, int page, int perPage) async {
    var res = await ApiBaseHelper().get2(
        "https://yourgrocer.ae/wp-json/wc/v3/products?tag=$tag&per_page=$perPage&page=$page&consumer_key=${Config.key2}&consumer_secret=${Config.secret2}");

    return res;
  }

  Future<List> getAllProducts(String tag) async {
    int i = 1;
    List l = [];
    bool b = true;

    while (b) {
      List response = await Product().getProducts(tag, i, 100);
      if (response.isNotEmpty && response[0] != "error") {
        l = l + response;
        i = i + 1;
      } else {
        break;
      }
    }
    return l;
  }

  Future<dynamic> getScrollProducts(String tag) async {
    int i = 1;

    var response = await Product().getProducts(tag, i, 20);

    return response;
  }
}
