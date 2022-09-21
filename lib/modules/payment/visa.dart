import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payment_c6/shared/common/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisCard extends StatelessWidget {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    print(' ezz :https://accept.paymob.com/api/acceptance/iframes/374930?payment_token=$PAYMENT_FINAL_TOKEN_VISA');

    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl:
              'https://accept.paymob.com/api/acceptance/iframes/374929?payment_token=$PAYMENT_FINAL_TOKEN_VISA',

          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },

          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
