import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_page.dart';
import 'login.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({super.key, User? user});

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
  }

  void _goToHomePage() {
    // Navigate to HomePage and remove the current route
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.orange[800]),
            onPressed: _goToHomePage,
          ),
          backgroundColor: Colors.orange[50],
          title: Text(
            'Thông Tin Tài Khoản',
            style: TextStyle(
              color: Colors.orange[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.orange[800]),
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // User Avatar/Icon
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.orange[100],
                child: _currentUser?.photoURL != null
                    ? ClipOval(
                        child: Image.network(
                          _currentUser!.photoURL!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.orange[800],
                      ),
              ),
              SizedBox(height: 20),

              // User Details
              _buildUserDetailCard(
                icon: Icons.person_outline,
                title: 'Tên Người Dùng',
                value: _currentUser?.displayName ?? 'Chưa cập nhật',
              ),

              _buildUserDetailCard(
                icon: Icons.email_outlined,
                title: 'Email',
                value: _currentUser?.email ?? 'Chưa cập nhập',
              ),

              SizedBox(height: 30),

              // Logout Button
              ElevatedButton(
                onPressed: _goToHomePage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[800],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Đăng Xuất',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  // Helper method to build user detail cards
  Widget _buildUserDetailCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.orange[800],
            size: 30,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.orange[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
