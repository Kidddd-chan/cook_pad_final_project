import 'package:flutter/material.dart';

class OnboarIng extends StatefulWidget {
  const OnboarIng({super.key});

  @override
  _OnboarIngState createState() => _OnboarIngState();
}

class _OnboarIngState extends State<OnboarIng> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 231),
      body: Container(
        child: Column(children: [
          Image.asset("images/landingpage.jpeg"),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Nấu ngon hơn mỗi ngày",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                    color: Colors.black, shape: BoxShape.circle),
                child: const Text(
                  "Tiếp theo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
