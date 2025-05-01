import 'package:flutter/material.dart';
import 'package:yt_download_manager/utils/assets_path.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
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
              Image(image: AssetImage(AssetPath.yt_icon)),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Paste YouTube URL here..",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
