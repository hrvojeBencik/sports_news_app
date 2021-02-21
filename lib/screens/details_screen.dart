import 'package:flutter/material.dart';
import 'package:sports_news/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home_screen.dart';

class DetailsScreen extends StatefulWidget {
  final Article article;

  DetailsScreen(this.article);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Find out more",
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Navigator.pop(context);
                // Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
        ],
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.article.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String response) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.3),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.grey.withOpacity(0.4)),
                ),
              ),
            )
        ],
      ),
    );
  }
}
