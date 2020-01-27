class Category {
  int categoryId;
  String categoryName;

  Category({
    this.categoryId,
    this.categoryName,
  });

  Category.fromJson(Map<String, dynamic> map) {
    categoryId = map['categoryId'];
    categoryName = map['categoryName'];
  }
}