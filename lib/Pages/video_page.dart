import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:v_player/connectivity.dart';
import 'package:v_player/main.dart';
import 'package:v_player/widgets/text_field.dart';
import 'package:v_player/widgets/video_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final textController = TextEditingController(text: url);
  late VideoPlayerController _controller;
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  Color snackbarColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    initVideoPlayer(url);
    initConnectivity();
  }

  Future<void> initVideoPlayer(String newUrl) async {
    _controller = VideoPlayerController.network(newUrl)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
  }

  initConnectivity() {
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      print('source $_source');
      switch (_source.keys.toList().first) {
        case ConnectivityResult.mobile:
          {
            snackbarColor = Colors.green;
            string = 'Connected to mobile network';
            _controller.play();
            break;
          }
        case ConnectivityResult.wifi:
          {
            snackbarColor = Colors.green;
            string = 'Connected to wifi network';
            _controller.play();
            break;
          }
        default:
          {
            snackbarColor = Colors.red;
            _controller.pause();
            string = 'No internet connection!';
          }
      }
      setState(() {});
      showSnackbar(string, snackbarColor);
    });
  }

  showSnackbar(String text, Color color) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
            text,
          ),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Video Player')),
        body: RefreshIndicator(
          onRefresh: () {
            if (textController.text.trim().isEmpty) {
              showSnackbar("Please enter the url", Colors.black87);
              return Future.delayed(const Duration(seconds: 1));
            } else {
              initConnectivity();
              return initVideoPlayer(textController.text);
            }
          },
          child: ListView(
            children: [
              VideoPlayerWidget(controller: _controller),
              TextFieldWidget(
                controller: textController,
                hintText: 'Enter Video Url',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ElevatedButton.icon(
                    onPressed: () {
                      if (textController.text.trim().isEmpty) {
                        showSnackbar("Please enter the url", Colors.black87);
                        return;
                      }
                      initConnectivity();
                      initVideoPlayer(textController.text);
                    },
                    icon: const Icon(Icons.search),
                    label: const Text("Load Video")),
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      );
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _networkConnectivity.disposeStream();
  }
}
