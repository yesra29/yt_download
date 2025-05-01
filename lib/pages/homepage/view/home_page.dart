import 'package:flutter/material.dart';
import 'package:yt_download_manager/utils/assets_path.dart';
import 'package:yt_download_manager/screens/settings_screen.dart';
import 'package:yt_download_manager/pages/downloads/downloads_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const SettingsScreen(),
    const DownloadsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages[_currentIndex],
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }

  Widget _bottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 0,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 28),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, size: 28),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.download, size: 28),
          label: 'Downloads',
        ),
      ],
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Download Manager",
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(AssetPath.ytLogo),
              fit: BoxFit.contain,
              height: 150,
              width: 150,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Paste YouTube URL here..",
                  hintStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            const SizedBox(
              height: 30,
            ),
            _downloadButton(),
          ],
        ),
      ),
    );
  }

  Widget _downloadButton() {
    return GestureDetector(
      onTap: () {
        // Handle download button tap
        print("Download button tapped");
      },
      child: SizedBox(
        height: 50,
        width: 200,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.red,
          ),
          child: const Center(
              child: Text("Download",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18))),
        ),
      ),
    );
  }
}
