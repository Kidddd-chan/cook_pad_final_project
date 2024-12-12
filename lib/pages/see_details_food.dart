import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';

class SeeDetailsFood extends StatelessWidget {
  final Dish dish;

  const SeeDetailsFood({Key? key, required this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: Text(dish.name, style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: dish.imageBase64.isNotEmpty
                    ? Image.memory(
                  base64Decode(dish.imageBase64),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.orange[100],
                      height: 200,
                      child: Center(
                        child: Text(
                          'Lỗi tải ảnh',
                          style: TextStyle(color: Colors.orange[800]),
                        ),
                      ),
                    );
                  },
                )
                    : Container(
                  color: Colors.orange[100],
                  height: 200,
                  child: Center(
                    child: Text(
                      'Không có ảnh',
                      style: TextStyle(color: Colors.orange[800]),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Tên món ăn: ${dish.name}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Danh mục: ${dish.category}",
                style: TextStyle(fontSize: 16, color: Colors.orange[600]),
              ),
              SizedBox(height: 16),
              Text(
                "Mô tả:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                dish.description,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
