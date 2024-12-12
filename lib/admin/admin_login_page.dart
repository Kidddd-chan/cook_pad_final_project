import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fn_prj/admin/list_Dish1.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email Input
              TextFormField(
                controller: _userController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Sai tai khoan vui lòng nhập lại";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Password Input
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Login Button
              GestureDetector(
                onTap: () {
                  loginAdmin();
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Text('Login'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != _userController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Tài khoản không tồn tại"),
          ));
        } else if (result.data()['password'] !=
            _passwordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Mật khẩu không tồn đúng"),
          ));
        } else
          (Navigator.push(context,
              MaterialPageRoute(builder: (context) => DishListPage1())));
      });
    });
  }
}
