import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  VideoAppState createState() => VideoAppState();
}

class VideoAppState extends State<VideoApp> {

  final List<String> videoEmbedUrls = [
    'https://www.youtube.com/embed/_o7qjN3KF8U?si=M0yo4R94r_NaVjyQ&amp;start=10',
    'https://www.youtube.com/embed/y8OnoxKotPQ?si=EmT_Ellfthq1ORcq&amp;start=92',
    'https://www.youtube.com/embed/eSqexFg74F8?si=pi77XZW6oI4rbw_9&amp;start=110'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Data Entry')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            var wvController = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) => NavigationDecision.navigate,
                ),
              );
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                child: WebViewWidget(controller: wvController..loadRequest(Uri.parse(videoEmbedUrls[index])))
              ),
            );
          },
        ),
      ),
    );
  }
}