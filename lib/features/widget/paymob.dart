import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebViewPage extends StatefulWidget {
  final String checkoutUrl;
  final int lectureId;
  final int studentId;

  const PaymobWebViewPage({
    super.key,
    required this.checkoutUrl,
    required this.lectureId,
    required this.studentId,
  });

  @override
  State<PaymobWebViewPage> createState() => _PaymobWebViewPageState();
}

class _PaymobWebViewPageState extends State<PaymobWebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.startsWith('modares://payment/callback')) {
              Navigator.pop(context, true);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.checkoutUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدفع'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}