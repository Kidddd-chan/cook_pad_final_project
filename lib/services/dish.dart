import 'package:cloud_firestore/cloud_firestore.dart';

class Dish {
  // Khai báo tham chiếu tới collection 'dishes'
  final CollectionReference dishes =
      FirebaseFirestore.instance.collection('dishes');

  // Thêm món ăn vào Firestore
  Future<void> addDish(String name, String imageUrl, String description) async {
    try {
      Map<String, dynamic> dishData = {
        'name': name,
        'image': imageUrl,
        'description': description,
        'created_at': FieldValue.serverTimestamp(),
      };

      // Thêm một document mới vào collection 'dishes'
      await dishes.add(dishData);
      print("Dish added successfully!");
    } catch (e) {
      print("Error adding dish: $e");
    }
  }

  // Sửa thông tin món ăn
  Future<void> updateDish(
      String dishId, String name, String imageUrl, String description) async {
    try {
      Map<String, dynamic> updatedData = {
        'name': name,
        'image': imageUrl,
        'description': description,
        'updated_at': FieldValue.serverTimestamp(),
      };

      // Cập nhật document theo dishId
      await dishes.doc(dishId).update(updatedData);
      print("Dish updated successfully!");
    } catch (e) {
      print("Error updating dish: $e");
    }
  }

  // Xóa món ăn
  Future<void> deleteDish(String dishId) async {
    try {
      // Xóa document theo dishId
      await dishes.doc(dishId).delete();
      print("Dish deleted successfully!");
    } catch (e) {
      print("Error deleting dish: $e");
    }
  }

  // Xem danh sách các món ăn
  Stream<QuerySnapshot> viewDishes() {
    try {
      // Trả về stream dữ liệu từ Firestore
      return dishes.orderBy('created_at', descending: true).snapshots();
    } catch (e) {
      print("Error viewing dishes: $e");
      rethrow;
    }
  }
}
