import 'package:flutter/material.dart';
import 'package:v_player/Pages/video_page.dart';

const url =
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.cyan,
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold))),
        home: const VideoPlayerScreen(),
      ),
    );
  }
}
