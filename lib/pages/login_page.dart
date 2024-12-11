import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // Color(0xFF121212)
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
          title: const Text('COOKPAD',
              style: TextStyle(
                fontFamily: "Lato",
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buidPageTitle(),
            const SizedBox(height: 25),
            _buidFormLogin(),
            _buildHaveNotAccount(context),
          ],
        ));
  }

  Widget _buidPageTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
      alignment: Alignment.center,
      child: const Text(
        'Login',
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buidFormLogin() {
    return Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 53),
              _buildUsernameField(),
              const SizedBox(height: 25),
              _buildPasswordField(),
              _buildLoginButton(),
            ],
          ),
        ));
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
                return 'Email is required';
              }
              final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value);
              if (emailValid) {
                return null;
              } else {
                return 'Invalid email address';
              }
            },
            style: const TextStyle(
              color: Colors.orange,
              fontFamily: "Lato",
              fontSize: 16,
            ),
          ),
        )
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
        )
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.only(top: 60),
      child: ElevatedButton(
        // onPressed: null,
        onPressed: _onHandleLoginSubmit,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            disabledBackgroundColor: Colors.orangeAccent.withOpacity(0.7)),
        child: Text(
          'Login',
          style: TextStyle(
            fontFamily: "Lato",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.87),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildHaveNotAccount(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 46, bottom: 20),
      child: RichText(
        text: TextSpan(
          text: "Don't have account? ",
          style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 16,
            color: Color(0xFF979797),
          ),
          children: [
            TextSpan(
                text: "Register",
                style: const TextStyle(
                  fontFamily: "Lato",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _goToRegisterPage(context);
                    print("Di den man hinh register");
                  }),
          ],
        ),
      ),
    );
  }

  void _onHandleLoginSubmit() {
    if (_autoValidateMode == AutovalidateMode.disabled) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      // call API login or call firebase login
    } else {
      // Nothing
    }
  }

  void _goToRegisterPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }
}
