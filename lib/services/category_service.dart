import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/model/category.dart'; // This should match the path of your Category model.

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<ResponseResult> getCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      List<Category> categories = snapshot.docs.map((doc) {
        // Pass the document ID (`doc.id`) to the Category constructor
  


        return Category.fromMap(doc.data(), doc.id);
      }).toList();
      return ResponseResult.success(data: categories, message: "Fetch categories successfully");
    } catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }
}
