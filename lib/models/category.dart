import 'package:grocery_app/services/networking.dart';
import 'package:grocery_app/woo/config.dart';

class Cat {
  String name;
  String slug;
  String image;
  int id;
  int count;
  List<dynamic> subCat = [];

  Cat({this.id, this.name, this.slug, this.image, this.count, this.subCat});
  Future<dynamic> getCats(int page) async {
    var res = await ApiBaseHelper().get2(Config.url2 +
        Config.allCat +
        "?page=$page&per_page=100&consumer_key=${Config.key2}&consumer_secret=${Config.secret2}");
    return res;
  }

  Future<List> getAllCats() async {
    int i = 1;
    List l = [];
    bool b = true;

    while (b) {
      List response = await Cat().getCats(i);
      if (response.isNotEmpty && response[0] != "error") {
        l = l + response;
        i = i + 1;
      } else {
        break;
      }
    }
    return l;
  }
}
