import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateDish extends StatefulWidget {
  final String dishId;

  UpdateDish({required this.dishId});

  @override
  _UpdateDishPageState createState() => _UpdateDishPageState();
}

class _UpdateDishPageState extends State<UpdateDish> {
  final DatabaseReference _dishesRef =
  FirebaseDatabase.instance.ref().child("dishes");
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageBase64Controller;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _categoryController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageBase64Controller = TextEditingController();
    _fetchDishDetails();
  }

  void _fetchDishDetails() {
    _dishesRef.child(widget.dishId).once().then((snapshot) {
      final data = snapshot.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _nameController.text = data['name'] ?? '';
        _categoryController.text = data['category'] ?? '';
        _descriptionController.text = data['description'] ?? '';
        _imageBase64Controller.text = data['image_base64'] ?? '';
      });
    });
  }

  void _updateDish() {
    if (_formKey.currentState!.validate()) {
      _dishesRef.child(widget.dishId).update({
        'name': _nameController.text,
        'category': _categoryController.text,
        'description': _descriptionController.text,
        'image_base64': _imageBase64Controller.text,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dish updated successfully!')),
        );
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Dish'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageBase64Controller,
                decoration: InputDecoration(labelText: 'Image (Base64)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image in Base64 format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateDish,
                child: Text('Update Dish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
