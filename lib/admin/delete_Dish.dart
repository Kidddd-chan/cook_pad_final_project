import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DeleteDish extends StatefulWidget {
  const DeleteDish({super.key});

  @override
  _DeleteDishState createState() => _DeleteDishState();
}

class _DeleteDishState extends State<DeleteDish> {
  final DatabaseReference _dishesRef =
  FirebaseDatabase.instance.ref().child('dishes');
  List<Map> _dishes = [];

  // Fetch dishes from the Firebase Realtime Database
  @override
  void initState() {
    super.initState();
    _fetchDishes();
  }

  _fetchDishes() async {
    _dishesRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map<dynamic, dynamic>) {
        // Kiểm tra nếu data là Map
        List<Map> dishesList = [];
        data.forEach((key, value) {
          // Lấy dữ liệu từ Firebase và cung cấp giá trị mặc định khi không có dữ liệu
          dishesList.add({
            'id': key,
            'category': value['category'] ?? 'Unknown',
            'description': value['description'] ?? 'No description available',
            'image_base64': value['image_base64'] ?? '',
            'created_at': value['created_at'] ??
                'Unknown time', // Cung cấp giá trị mặc định nếu 'created_at' là null
          });
        });
        setState(() {
          _dishes = dishesList;
        });
      }
    });
  }

  // Delete a dish from Firebase Realtime Database
  _deleteDish(String dishId) async {
    await _dishesRef.child(dishId).remove();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Món ăn đã được xóa!')),
    );
    _fetchDishes(); // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        GestureDetector(child: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text('Delete Dish'),
      ),
      body: _dishes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _dishes.length,
        itemBuilder: (context, index) {
          var dish = _dishes[index];
          return ListTile(
            leading: Image.network(dish['imageUrl'],
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text(dish['name']),
            subtitle: Text('Category: ${dish['category']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteDish(dish['id']),
            ),
          );
        },
      ),
    );
  }
}
