import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fn_prj/pages/see_details_food.dart';
import 'dart:convert';

class Dish {
  final String id;
  final String name;
  final String category;
  final String createdAt;
  final String description;
  final String imageBase64;

  Dish({
    required this.id,
    required this.name,
    required this.category,
    required this.createdAt,
    required this.description,
    required this.imageBase64,
  });

  factory Dish.fromSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
    return Dish(
      id: snapshot.key ?? '',
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      createdAt: data['created_at'] ?? '',
      description: data['description'] ?? '',
      imageBase64: data['image_base64'] ?? '',
    );
  }
}

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child('dishes');

  List<Dish> _dishes = [];
  List<Dish> _filteredDishes = [];

  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDishes();
  }

  void _fetchDishes() {
    setState(() {
      _isLoading = true;
    });

    _databaseRef.onValue.listen((event) {
      final data = event.snapshot.children;

      _dishes = data.map((snapshot) {
        return Dish.fromSnapshot(snapshot);
      }).toList();

      setState(() {
        _filteredDishes = _dishes;
        _isLoading = false;
      });
    });
  }

  void _searchDishes(String query) {
    setState(() {
      _filteredDishes = _dishes.where((dish) {
        return dish.name.toLowerCase().contains(query.toLowerCase()) ||
            dish.category.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(height: 30),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 25),
                          const Text(
                            "Tìm kiếm",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications_none),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: _searchDishes,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tìm kiếm...',
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _searchDishes('');
                              },
                            )
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      const Row(
                        children: [
                          Text(
                            "Nguyên liệu phổ biến",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Cập nhật 13:27",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: _isLoading
                            ? Center(child: CircularProgressIndicator())
                            : _filteredDishes.isEmpty
                            ? Center(child: Text("Không tìm thấy kết quả"))
                            : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: _filteredDishes.length,
                          itemBuilder: (context, index) {
                            final dish = _filteredDishes[index];
                            return GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: dish.imageBase64.isNotEmpty
                                          ? Image.memory(
                                        base64Decode(dish.imageBase64),
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey,
                                            child: Center(child: Text('Lỗi tải ảnh')),
                                          );
                                        },
                                      )
                                          : Container(
                                        color: Colors.grey,
                                        child: Center(child: Text('Không có ảnh')),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 80,
                                    left: 5,
                                    child: Text(
                                      dish.name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white70,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0,
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 5,
                                    child: Text(
                                      dish.category,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 5.0,
                                            color: Colors.black,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black38,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePages()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SeeDetailsFood()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Tìm kiếm",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list_outlined),
              label: "Kho món ăn của bạn"),
        ],
      ),
    );
  }
}