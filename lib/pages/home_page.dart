import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fn_prj/pages/see_details_food.dart';
import 'dart:convert';

import 'favorite_page.dart';

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
  final DatabaseReference _databaseRef =
  FirebaseDatabase.instance.ref().child('dishes');
  List<Dish> favoriteDishes = [];
  List<Dish> _dishes = [];
  List<Dish> _filteredDishes = [];
  List<String> _categories = ['Tất cả'];
  String _selectedCategory = 'Tất cả';

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

      // Dynamically extract unique categories
      _categories = ['Tất cả'];
      _categories.addAll(
        _dishes
            .map((dish) => dish.category)
            .toSet() // Remove duplicates
            .toList(),
      );

      _filterDishes();
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _filterDishes() {
    setState(() {
      _filteredDishes = _dishes.where((dish) {
        final nameMatch = dish.name
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
        final categoryMatch = _selectedCategory == 'Tất cả' ||
            dish.category.toLowerCase() == _selectedCategory.toLowerCase();

        return nameMatch && categoryMatch;
      }).toList();
    });
  }

  void _searchDishes(String query) {
    _filterDishes();
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterDishes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Colors.orange[50],
            child: Column(
              children: [
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Tìm kiếm Công Thức",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications_none,
                            color: Colors.orange[800]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
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
                        prefixIcon:
                        Icon(Icons.search, color: Colors.orange[800]),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          icon: Icon(Icons.clear,
                              color: Colors.orange[800]),
                          onPressed: () {
                            _searchController.clear();
                            _searchDishes('');
                          },
                        )
                            : null,
                      ),
                    ),
                  ),
                ),
                // Dynamic Categories Horizontal List
                SizedBox(
                  height: 50,
                  child: _isLoading
                      ? Center(
                      child: CircularProgressIndicator(
                          color: Colors.orange[800]))
                      : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8),
                        child: ChoiceChip(
                          label: Text(_categories[index]),
                          selected:
                          _selectedCategory == _categories[index],
                          onSelected: (bool selected) {
                            if (selected) {
                              _selectCategory(_categories[index]);
                            }
                          },
                          selectedColor: Colors.orange[200],
                          backgroundColor: Colors.orange[100],
                          labelStyle: TextStyle(
                            color: _selectedCategory == _categories[index]
                                ? Colors.white
                                : Colors.orange[800],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(
              child: CircularProgressIndicator(
                color: Colors.orange[800],
              ),
            )
                : _filteredDishes.isEmpty
                ? Center(
              child: Text(
                "Không tìm thấy kết quả",
                style: TextStyle(color: Colors.orange[800]),
              ),
            )
                : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: _filteredDishes.length,
              itemBuilder: (context, index) {
                final dish = _filteredDishes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SeeDetailsFood(dish: dish),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: dish.imageBase64.isNotEmpty
                              ? Image.memory(
                            base64Decode(dish.imageBase64),
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                color: Colors.orange[100],
                                height: 150,
                                child: Center(
                                  child: Text(
                                    'Lỗi tải ảnh',
                                    style: TextStyle(
                                        color:
                                        Colors.orange[800]),
                                  ),
                                ),
                              );
                            },
                          )
                              : Container(
                            color: Colors.orange[100],
                            height: 150,
                            child: Center(
                              child: Text(
                                'Không có ảnh',
                                style: TextStyle(
                                    color: Colors.orange[800]),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              dish.name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[800],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange[800],
        unselectedItemColor: Colors.orange[300],
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritePage(favoriteDishes: favoriteDishes),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Tìm kiếm",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list_outlined),
            label: "Món ăn yêu thích",
          ),
        ],
      ),
    );
  }
}
