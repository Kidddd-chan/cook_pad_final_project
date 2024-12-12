import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'update_Dish.dart'; // Import trang update_Dish.dart
import 'package:fn_prj/admin/add_Dish1.dart';

class DishListPage1 extends StatefulWidget {
  @override
  _DishListPageState createState() => _DishListPageState();
}

class _DishListPageState extends State<DishListPage1> {
  final DatabaseReference _dishesRef =
  FirebaseDatabase.instance.ref().child("dishes");

  List<Map<String, dynamic>> _dishes = [];
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchDishes();
  }

  void _fetchDishes() {
    _dishesRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map<dynamic, dynamic>) {
        List<Map<String, dynamic>> dishesList = [];
        data.forEach((key, value) {
          dishesList.add({
            'id': key,
            'name': value['name'] ?? 'Unknown',
            'category': value['category'] ?? 'Unknown',
            'description': value['description'] ?? 'No description available',
            'image_base64': value['image_base64'] ?? '',
            'created_at': value['created_at'] ?? 'Unknown time',
          });
        });
        setState(() {
          _dishes = dishesList;
        });
      }
    });
  }

  void _deleteDish(String id) {
    _dishesRef.child(id).remove();
  }

  void _navigateToUpdatePage(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateDish(dishId: id),
      ),
    );
  }

  void _navigateToAddDishPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddDish1(),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredDishes() {
    if (_searchQuery.isEmpty) {
      return _dishes; // Trả về toàn bộ danh sách nếu không có từ khóa
    }
    return _dishes.where((dish) {
      final name = dish['name'].toString().toLowerCase();
      final category = dish['category'].toString().toLowerCase();
      return name.contains(_searchQuery) || category.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredDishes = _getFilteredDishes();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
            });
          },
          decoration: InputDecoration(
            hintText: 'Tìm kiếm món ăn...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.orange),
          ),
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _searchController.clear();
                _searchQuery = "";
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddDishPage,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredDishes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        filteredDishes[index]['name'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _deleteDish(filteredDishes[index]['id']),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () =>
                                _navigateToUpdatePage(filteredDishes[index]['id']),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Category: ${filteredDishes[index]['category']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${filteredDishes[index]['description']}',
                    style: TextStyle(fontSize: 14),
                    maxLines: 2, // Giới hạn hiển thị tối đa 2 dòng
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Created at: ${filteredDishes[index]['created_at']}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  filteredDishes[index]['image_base64']!.isNotEmpty
                      ? Image.memory(
                    Base64Decoder()
                        .convert(filteredDishes[index]['image_base64']!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.image, size: 50, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
