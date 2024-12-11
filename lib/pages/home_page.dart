import 'package:flutter/material.dart';

import 'package:fn_prj/pages/see_details_food.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0; // Track selected tab index
  final List<Widget> _pages = [
    HomePages(),
    // Add more pages here...
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.height * 0.9,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(height: 30),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 25),
                          const Text(
                            "Tìm kiếm",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications_none),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search...',
                            prefixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      const Row(
                        children: [
                          Text(
                            "Nguyên liệu phổ biến",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Cập nhật 13:27",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      // Adding Grid with overlay text
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          // mainAxisSpacing: 5,
                          children: [
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GridTile(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(15), // Bo góc
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Màu bóng
                                          spreadRadius:
                                              2, // Độ lan tỏa của bóng
                                          blurRadius: 8, // Độ mờ của bóng
                                          offset:
                                              Offset(0, 4), // Dịch chuyển bóng
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15), // Bo góc ảnh
                                      child: Image.network(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo_etEVFHPQdatjflcGiwd6UtnOwPAXL-cRQ&s',
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 80, // Căn chữ gần sát đáy ảnh
                                    left: 5, // Căn lề trái
                                    child: Text(
                                      "Thịt Kho Tàu",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .white70, // Chữ màu trắng để nổi bật
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10.0, // Đổ bóng cho chữ
                                            color: Colors.black,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black38,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        onTap: (index) {
          if (index == 0) {
            // Nếu bấm vào home, chuyển đến WelcomePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePages()),
            );
          } else if (index == 1) {
            // Nếu bấm vào person, chuyển đến HomePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SeeDetailsFood()),
            );
          } else {
            // Các trang khác
            _onItemTapped(index);
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Tìm kiếm",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list_outlined),
              label: "Kho món ăn của bạn"),
        ],
      ),
    );
  }
}
