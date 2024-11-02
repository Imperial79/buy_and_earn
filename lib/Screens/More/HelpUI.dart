import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpUI extends StatefulWidget {
  const HelpUI({super.key});

  @override
  State<HelpUI> createState() => _HelpUIState();
}

class _HelpUIState extends State<HelpUI> {
  late WebViewController controller;
  double _progress = 0;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://tawk.to/chat/66a3d12832dca6db2cb639eb/1i3nui26e'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(context, title: "Support", isLoading: _progress != 1),
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
