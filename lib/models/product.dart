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

  Future<List> getProductsCustom(
      {String tag,
      int page,
      int perPage,
      String searchVal,
      // String tagName,
      String tagId,
      String categoryId,
      String sortBy,
      String sortOrder = "asc"}) async {
    String parameter = "";
    if (searchVal != null) {
      parameter += "&search=$searchVal";
    }
    if (page != null) {
      parameter += "&page=$page";
    }
    if (perPage != null) {
      parameter += "&per_page=$perPage";
    }
    if (categoryId != null) {
      parameter += "&category=$categoryId";
    }
    if (tagId != null) {
      parameter += "&tag=$tagId";
    }
    // if (tagName != null) {
    //   parameter += "&tag=$tagName";
    // }
    if (sortBy != null) {
      parameter += "&orderby=$sortBy";
    }
    if (sortBy != null) {
      parameter += "&order=$sortOrder";
    }

    List l = [];

    List response = await await ApiBaseHelper().get2(Config.url2 +
        Config.productsURL +
        "?consumer_key=${Config.key2}&consumer_secret=${Config.secret2}${parameter.toString()}");

    for (var json in response) {
      List<Tag> tags = [];
      List<String> images = [];
      List<Cat> categories = [];
      if (json["categories"] != null) {
        json["categories"].forEach((v) {
          categories
              .add(new Cat(id: v["id"], name: v["name"], slug: v["slug"]));
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
      l.add(new Product(
          id: json["id"],
          name: json["name"],
          description: json["description"],
          shortDescription: json["short_description"],
          slug: json["slug"],
          onSale: json["on_sale"],
          sku: json["sku"],
          permaLink: json["permalink"],
          price: json["price"],
          regularPrice: json["regular_price"],
          salePrice: json["sale_price"],
          stockStatus: json["stock_status"],
          images: images,
          categories: categories,
          tags: tags));
    }
    return l;
  }

  // Future<dynamic> getScrollProducts(String tag) async {
  //   int i = 1;

  //   var response = await Product().getProducts(tag, i, 20);

  //   return response;
  // }

}
