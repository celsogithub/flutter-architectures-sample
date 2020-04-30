import 'package:br/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('When create a category', () {
    test('Should return the color', () {
      final categoryType = CategoryType.PERSONAL;
      final color = Category.colorByName(categoryType);
      final Category category = Category(type: categoryType, color: color);
      expect(category.color, Category.colorByName(categoryType));
    });
  });
}