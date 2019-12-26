import 'dart:async';

import 'package:bwa_learning/dao/CategoryDao.dart';
import 'package:bwa_learning/models/Category.dart';
import 'package:scoped_model/scoped_model.dart';

mixin CategoryModel on Model {
  List<Category> _categories = [];
  List<Category> _foundedCategory = [];
  Category _category;
  bool _isLoading = false;

  List<Category> get Categories {
    return List.from(_categories);
  }

  List<Category> get foundedCategory {
    return List.from(_foundedCategory);
  }

  bool get isLoading {
    return _isLoading;
  }

  Category get currentCategory {
    return _category;
  }

  void setCurrentCategory(Category category) {
    _category = category;
  }

  Future<Null> fetchCategory() async {
    _isLoading = true;
    notifyListeners();

    _categories = [];

    print('fetch Categories by institutionId');

    try {
      _categories = await CategoryDao.db.getCategories();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
    }
  }
}
