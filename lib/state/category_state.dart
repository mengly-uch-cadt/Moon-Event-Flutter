import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/category.dart';

class CategoryNotifier extends StateNotifier<List<Category>>{
  CategoryNotifier() : super([]);

  void setCategoryData(List<Category> categoryData){
    state = categoryData;
  }

  void clearCategoryData(){
    state = [];
  }
}

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<Category>>((ref){
  return CategoryNotifier();
});