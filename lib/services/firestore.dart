import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestore {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String name, String email) async {
    try {
      // Lấy uid của người dùng sau khi đăng ký
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Lấy đối tượng Firestore instance
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        Map<String, dynamic> userData = {
          'name': name,
          'email': email,
          'created_at': FieldValue.serverTimestamp(),
        };

        // Thêm người dùng vào collection 'users'
        await firestore.collection('users').doc(user.uid).set(userData);

        print("User added successfully to Firestore!");
      } else {
        print("No user is logged in.");
      }
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  void addUsers() async {
    // Tạo danh sách các user dummy
    List<Map<String, String>> dummyUsers = [
      {'name': 'Alice', 'email': 'alice@example.com'},
      {'name': 'Bob', 'email': 'bob@example.com'},
      {'name': 'Charlie', 'email': 'charlie@example.com'},
      {'name': 'David', 'email': 'david@example.com'},
      {'name': 'Eve', 'email': 'eve@example.com'},
      {'name': 'Frank', 'email': 'frank@example.com'},
      {'name': 'Grace', 'email': 'grace@example.com'},
      {'name': 'Hannah', 'email': 'hannah@example.com'},
      {'name': 'Isaac', 'email': 'isaac@example.com'},
      {'name': 'Jack', 'email': 'jack@example.com'},
    ];

    // Lặp qua danh sách và thêm từng user vào Firestore
    for (var user in dummyUsers) {
      await addUser(user['name']!, user['email']!);
    }
  }

// Gọi hàm thêm user dummy
}
