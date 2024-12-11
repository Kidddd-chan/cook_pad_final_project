import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:random_string/random_string.dart';

class AddDish extends StatefulWidget {
  const AddDish({super.key});

  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  String? value;
  final ImagePicker _picker = new ImagePicker();
  File? selectedImage;
  TextEditingController _controller = new TextEditingController();
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  uploadItem() {
    if (selectedImage != null && _controller.text != "") {
      String addID = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(addID);
    }
  }

  final List<String> categoryitem = ['ca', 'muc', 'bao ngu', 'nam'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            GestureDetector(child: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text('Add Dish'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 20),
        child: Column(
          children: [
            Text('Image'),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 120,
                width: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 15)),
                child: Icon(Icons.camera_alt_outlined),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Tên món ăn'),
            Container(
                padding: EdgeInsets.only(left: 40),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFFececf8)),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(border: InputBorder.none),
                )),
            const SizedBox(
              height: 40,
            ),
            Text('Phân loại'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Color(0xFFececf8)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: categoryitem
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: ((value) => setState(() {
                          this.value = value;
                        })),
                    dropdownColor: Colors.white,
                    hint: Text("Chọn mục"),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    value: value,
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {}, child: Text('Thêm món ăn')))
          ],
        ),
      ),
    );
  }
}
