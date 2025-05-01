import 'dart:io';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:yt_download_manager/utils/assets_path.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _urlController = TextEditingController();
  final YoutubeExplode yt = YoutubeExplode();
  String? videoUrl;
  String? videoTitle;
  String? videoDescription;

  // Fetch metadata
  Future<void> fetchMetadata(String url) async {
    try {
      final videoId = VideoId(url);
      final video = await yt.videos.get(videoId);
      setState(() {
        videoTitle = video.title;
        videoDescription = video.description;
      });
    } catch (e) {
      print('Error fetching metadata: $e');
      setState(() {
        videoTitle = null;
        videoDescription = 'Error fetching metadata';
      });
    }
  }

  // Download the video
  Future<void> downloadVideo(String url) async {
    try {
      final videoId = VideoId(url);
      final manifest = await yt.videos.streamsClient.getManifest(videoId);
      StreamInfo? streamInfo;

      if (manifest.muxed.isNotEmpty) {
        streamInfo = manifest.muxed.first;
      } else if (manifest.audioOnly.isNotEmpty) {
        streamInfo = manifest.audioOnly.first;
      } else if (manifest.videoOnly.isNotEmpty) {
        streamInfo = manifest.videoOnly.first;
      }

      // If no valid stream found
      if (streamInfo == null) {
        print("No available streams to download.");
        return;
      }

      final file = File('/storage/emulated/0/Download/${videoId.value}.mp4');
      final videoStream = yt.videos.streamsClient.get(streamInfo);
      await videoStream.pipe(file.openWrite());
      print('Download completed!');
    } catch (e) {
      print('Error downloading video: $e');
    }
  }

  _downloadButton() async {
    final url = _urlController.text;
    if (url.isNotEmpty) {
      await fetchMetadata(url);
      await downloadVideo(url);
      _urlController.clear();
    } else {
      print('Please enter a valid URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Download Manager",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(AssetPath.yt_icon),
                  fit: BoxFit.contain,
                  height: 150,
                  width: 150,
                ),
                TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    hintText: "Paste YouTube URL here..",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: _downloadButton,
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          "Download",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (videoTitle != null)
                  Column(
                    children: [
                      Text(
                        'Title: $videoTitle',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Description: $videoDescription',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }

  Widget _bottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 0,
      currentIndex: 0,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      onTap: (index) {
        setState(() {
          // You can implement navigation actions here
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
