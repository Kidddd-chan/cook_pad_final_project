import 'package:flutter/material.dart';
import 'package:fn_prj/pages/home_page.dart';

class SeeDetailsFood extends StatefulWidget {
  const SeeDetailsFood({super.key});


  @override
  State<SeeDetailsFood> createState() => _SeeDetailsFoodState();
}

class _SeeDetailsFoodState extends State<SeeDetailsFood> {
  int _selectedIndex = 0; // Track selected tab index
  final List<Widget> _pages = [
    HomePages(),
    SeeDetailsFood(),
    // Add more pages here...
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _opacity = (300 - _scrollController.offset) / 300;
        if (_opacity < 0.3) _opacity = 0.3; // Keep the image slightly visible
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header image with icons
            Stack(
              children: [
                Opacity(
                  opacity: _opacity,
                  child: ClipRRect(
                    child: Image.network(
                      'https://cdn1.tuoitre.vn/thumb_w/1200/2020/1/17/thit-kho-tau-1579262584061305990562-crop-15793964573892141833953.jpg',
                      width: screenWidth,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 20, // Căn chữ gần sát đáy ảnh
                  left: 20, // Căn lề trái
                  child: Text(
                    "Thịt Kho Tàu",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Chữ màu trắng để nổi bật
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
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePages()),
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 70,
                  child: IconButton(
                    onPressed: () {
                      // Share.share('Thử ngay món ăn "Thịt Kho Tàu" với công thức đơn giản này! Link: https://example.com');
                    },
                    icon: const Icon(Icons.share),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Title and details
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thịt kho tàu",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 20, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("30 phút", style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 16),
                      Icon(Icons.person, size: 20, color: Colors.grey),
                      SizedBox(width: 4),
                      Text("4 người", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ingredients Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nguyên Liệu",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("- Thịt ba chỉ"),
                  Text("- 10 quả Trứng vịt"),
                  Text("- 20 quả Trứng vịt"),
                  Text("- 700 ml nước dừa"),
                  Text("- 2 quả Ớt sừng không cay"),
                  Text("- 5 nhánh tỏi"),
                  Text("- 4 củ hành tím"),
                  Text("- 2 thìa muối hột"),
                  Text("- muối"),
                  Text("- tiêu"),
                  Text("- hạt nêm"),
                  Text("- đường"),
                  Text("- 500 ml nước lọc "),
                  Text("- bột ngọt"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Steps Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Cách Làm",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  StepCard(
                    stepNumber: 1,
                    description: "Thịt mua về rửa sạch cắt miếng to. cắm nước sôi đổ vào thịt cho 1 muỗng muối hạt, vài giọt dấm trắng để khử mùi thịt heo. trụng thịt 3phut gắp thịt ra để ráo nước. xong ướp thịt với 2 muỗng hạt nêm+1 muỗng muối + 1thia nước màu+2 muỗng nước mắm+ 1chut tiêu và nước cốt tỏi+ hành+ ớt,.(giã nước cốt Lấy cối bỏ ớt+hành+tỏi+ 1/3 thìa cafe bột ngọt, 2 muỗng đường cho vào cối dã nhuyễn. Bỏ vào thịt heo ướp 30-1tieng.\nThịt ướp xong bỏ vào chảo đảo cho săn bề mặt.( trứng luộc chín bóc vỏ để qua 1bên.",
                    imageUrl: "https://danviet.mediacdn.vn/upload/2-2019/images/2019-04-16/Cach-lam-thit-kho-tau-thom-ngon-bat-bai-cach-lam-thit-kho-tau-2-1555427684-width600height450.jpg", // Replace with your image link
                  ),
                  SizedBox(height: 10),
                  StepCard(
                    stepNumber: 2,
                    description: "Bỏ 1 muỗng đường vào nồi thắng màu cánh gián. Xong đổ700 mlnước dừa+500ml nước lọc 1muong muối+2thìa nước mắm đun sôi đổ thịt heo đã đảo săn vô kho. Sôi tầm 15p mình để lửa liu riu cho trứng luộc vào kho tầm 1tiếng. Tắt bếp xong hâm lại 20phút là OK.",
                    imageUrl: "https://cdn1.tuoitre.vn/thumb_w/1200/2020/1/17/thit-kho-tau-1579262584061305990562-crop-15793964573892141833953.jpg", // Replace with your image link
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
        // backgroundColor: Colors.white,
        // selectedItemColor: Colors.black38,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        // type: BottomNavigationBarType.fixed,
        // elevation: 0,
        // onTap: (index) {
        //   if (index == 0) {
        //     // Nếu bấm vào home, chuyển đến WelcomePage
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => SeeDetailsFood()),
        //     );
        //   } else if (index == 1) {
        //     // Nếu bấm vào person, chuyển đến HomePage
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => HomePages()),
        //     );
        //   } else {
        //     // Các trang khác
        //     _onItemTapped(index);
        //   }
        // },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tìm kiếm", backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.featured_play_list_outlined), label: "Kho món ăn của bạn"),
        ],
      ),
    );
  }
}

// Widget for each step in "Cách Làm"
class StepCard extends StatelessWidget {
  final int stepNumber;
  final String description;
  final String imageUrl;

  const StepCard({
    super.key,
    required this.stepNumber,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black,
          child: Text(
            stepNumber.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl, width: 400, height: 200, fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ],
    );
  }
}