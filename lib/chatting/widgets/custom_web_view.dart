// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';

// import 'package:webview_flutter/webview_flutter.dart';

// class CustomWebView extends StatefulWidget {
//   CustomWebView(
//     {
//     this.url,
//     super.key,
//   });
//    String? url; 
//   @override
//   State<CustomWebView> createState() => _CustomWebViewState();
// }

// class _CustomWebViewState extends State<CustomWebView> {
//    late WebViewController controller;
//   @override
//   void initState() {
//     super.initState();
//      controller =  WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse("https://firebasestorage.googleapis.com/v0/b/telegram-da9d4.appspot.com/o/docs?alt=media&token=f4250f1b-cf3c-4272-96d0-505b21d3e0c2"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
        
//         body: WebViewWidget(controller: controller));
//   }
// }
