import 'dart:convert'; // Required for base64 conversion
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb

class AddDish1 extends StatefulWidget {
  const AddDish1({super.key});

  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish1> {
  String? value;
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final List<String> categoryItems = ['Ăn trưa','Ăn tối' ,'Ăn vặt', 'Ăn sáng','Đồ chay'];

  // Function to pick an image
  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<String> convertImageToBase64(XFile imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }

  // Function to upload dish details to Firebase Realtime Database
  Future<void> uploadDish() async {
    if (selectedImage != null && _nameController.text.isNotEmpty) {
      try {
        // Convert image to Base64
        String base64Image = await convertImageToBase64(selectedImage!);

        // Add data to Firebase Realtime Database
        DatabaseReference dbRef = FirebaseDatabase.instance.ref("dishes");
        await dbRef.push().set({
          'name': _nameController.text,
          'description': _descriptionController.text,
          'category': value ?? 'Uncategorized',
          'image_base64': base64Image,
          'created_at': DateTime.now().toIso8601String(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Món ăn đã được thêm thành công!")));

        // Reset fields after successful upload
        setState(() {
          selectedImage = null;
          _nameController.clear();
          _descriptionController.clear();
          value = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Lỗi khi tải lên: $e")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Vui lòng chọn ảnh và nhập tên món ăn.")));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text('Thêm món ăn'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Image', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              GestureDetector(
                onTap: getImage,
                child: Center(
                  child: Container(
                    height: 120,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: selectedImage != null
                        ? kIsWeb
                        ? FutureBuilder<String>(
                      future: convertImageToBase64(selectedImage!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.done &&
                            snapshot.hasData) {
                          return Image.memory(
                            base64Decode(snapshot.data!),
                            fit: BoxFit.cover,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )
                        : Image.file(File(selectedImage!.path),
                        fit: BoxFit.cover)
                        : Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Tên món ăn', style: TextStyle(fontSize: 16)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: Color(0xFFececf8)),
                child: TextField(
                  maxLines: 3,
                  controller: _nameController,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),
              Text('Mô tả', style: TextStyle(fontSize: 16)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: Color(0xFFececf8)),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),
              Text('Phân loại', style: TextStyle(fontSize: 16)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: Color(0xFFececf8)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: categoryItems.map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    )).toList(),
                    onChanged: ((value) => setState(() {
                      this.value = value;
                    })),
                    dropdownColor: Colors.white,
                    hint: Text("Chọn mục"),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    value: value,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: uploadDish,
                  child: Text('Thêm món ăn'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
