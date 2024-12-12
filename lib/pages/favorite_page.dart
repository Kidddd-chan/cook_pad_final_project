import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';

class FavoritePage extends StatefulWidget {
  final List<Dish> favoriteDishes;

  const FavoritePage({Key? key, required this.favoriteDishes}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: Text(
          "Danh sách yêu thích",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: widget.favoriteDishes.isEmpty
          ? Center(
        child: Text(
          "Chưa có món ăn yêu thích",
          style: TextStyle(color: Colors.orange[800], fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: widget.favoriteDishes.length,
        itemBuilder: (context, index) {
          final dish = widget.favoriteDishes[index];
          return ListTile(
            leading: dish.imageBase64.isNotEmpty
                ? Image.memory(
              base64Decode(dish.imageBase64),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : Container(
              width: 50,
              height: 50,
              color: Colors.orange[100],
              child: Icon(Icons.image_not_supported),
            ),
            title: Text(dish.name),
            subtitle: Text(dish.category),
          );
        },
      ),

    );
  }
}
