import 'package:bwa_learning/models/origin/Category.dart';
import 'package:mysql1/mysql1.dart';

import 'Config.dart';

class CategoryDao {

  static final CategoryDao db = CategoryDao();

  Future<MySqlConnection> get database async {
    print("getDB");
    final conn = await Config.conn.mysqlConfiguration();
    return conn;
  }

  Future<List<Category>> getCategories() async {
    print("getCategory");
    var db = await database;

    List<Category> categoryList = [];

    var res = await db.query("SELECT * FROM category");

    if (res.length > 0) {
      res.forEach((f) {
        print('res');
        print(f.fields);
        categoryList.add(Category.fromJson(f.fields));
        categoryList.sort((a, b) {
          return a.categoryName.compareTo(b.categoryName);
        });
      });
    }
    else{
      print("Null");
    }

    return categoryList;
  }

  Future<List<Category>> getCategoryByInstitutionId(int institutionId) async {
    print("getCategoryByinstitutionId");
    var db = await database;

    List<Category> categoryList = [];

    var res = await db.query("SELECT * FROM category where institutionId = $institutionId");

    if (res.fields.length > 0) {
      res.forEach((f) {
        print(f);
        categoryList.add(Category.fromJson(f.fields));
        categoryList.sort((a, b) {
          return a.categoryName.compareTo(b.categoryName);
        });
      });
    }
    else{
      print("Null");
    }

    return categoryList;
  }

}
