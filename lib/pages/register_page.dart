import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import './login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _autoValidateMode = AutovalidateMode.disabled;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert password to bytes
    var hash = sha256.convert(bytes); // Hash the password
    return hash.toString(); // Return the hashed password
  }

  Future<void> createUser() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')));
        return;
      }

      try {
        // Hash the password before sending it to Firebase
        String hashedPassword = hashPassword(password);

        // Create a user in Firebase with email and hashed password
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password:
              password, // Use plain password, Firebase will hash it internally
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'created_at': Timestamp.now(),
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Sign Up Successful')));

        // Navigate to another page after successful registration (optional)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred. Please try again later.';
        if (e.code == 'email-already-in-use') {
          errorMessage =
              'The email address is already in use by another account.';
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    }
  }

  void _goToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'COOKPAD',
          style: TextStyle(
            fontFamily: "Lato",
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            margin:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
            child: const Text(
              'Register',
              style: TextStyle(
                fontFamily: "Lato",
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 25),
          _buildFormRegister(),
          _buildHaveAccount(),
        ],
      ),
    );
  }

  Widget _buildFormRegister() {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildUsernameField(),
            const SizedBox(height: 25),
            _buildPasswordField(),
            const SizedBox(height: 25),
            _buildConfirmPasswordField(),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username',
          style: TextStyle(
            fontFamily: "Lato",
            fontSize: 16,
            color: Colors.black.withOpacity(0.87),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Enter your Username",
              hintStyle: const TextStyle(
                color: Color(0xFF535353),
                fontFamily: "Lato",
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: Colors.orange.withOpacity(0.87),
                ),
              ),
              fillColor: const Color(0xFFFFE0B2).withOpacity(0.6),
              filled: true,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Username is required';
              }
              return null;
            },
            style: const TextStyle(
              color: Colors.orange,
              fontFamily: "Lato",
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontFamily: "Lato",
            fontSize: 16,
            color: Colors.black.withOpacity(0.87),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: ". . . . . . . . . . . .",
              hintStyle: const TextStyle(
                color: Color(0xFF535353),
                fontFamily: "Lato",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.orange,
                ),
              ),
              fillColor: const Color(0xFFFFE0B2).withOpacity(0.6),
              filled: true,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length <= 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
            style: const TextStyle(
              color: Colors.orange,
              fontFamily: "Lato",
              fontSize: 16,
            ),
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Password',
          style: TextStyle(
            fontFamily: "Lato",
            fontSize: 16,
            color: Colors.black.withOpacity(0.87),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              hintText: ". . . . . . . . . . . .",
              hintStyle: const TextStyle(
                color: Color(0xFF535353),
                fontFamily: "Lato",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: Colors.orange,
                ),
              ),
              fillColor: const Color(0xFFFFE0B2).withOpacity(0.6),
              filled: true,
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Confirm Password is required';
              }
              if (value != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
            style: const TextStyle(
              color: Colors.orange,
              fontFamily: "Lato",
              fontSize: 16,
            ),
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: createUser, // Call the function to create the user
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            fontFamily: "Lato",
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildHaveAccount() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      margin: const EdgeInsets.only(top: 8, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              fontFamily: "Lato",
              fontSize: 16,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          GestureDetector(
            onTap: () {
              _goToLoginPage(context);
            },
            child: const Text(
              'Login',
              style: TextStyle(
                fontFamily: "Lato",
                fontSize: 16,
                color: Colors.orangeAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
