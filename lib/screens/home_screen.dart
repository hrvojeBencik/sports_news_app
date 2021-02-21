import 'package:flutter/material.dart';
import 'package:sports_news/models/article.dart';
import 'package:sports_news/services/api_service.dart';
import 'package:sports_news/widgets/article_tile.dart';
import 'package:sports_news/widgets/categories_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController _drawerIconController;

  List<Article> _articles = [];

  void _fetchLatestNews() async {
    ApiService apiService = ApiService();
    Map result = await apiService.fetchNewsData("Sports");
    setState(() {
      _articles = apiService.processNewsData(result);
    });
  }

  @override
  void initState() {
    super.initState();
    _drawerIconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _fetchLatestNews();
  }

  @override
  void dispose() {
    super.dispose();
    _drawerIconController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("B-Sports"),
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _drawerIconController,
          ),
          onPressed: () {
            if (_drawerIconController.isCompleted) {
              _drawerIconController.reverse();
              if (_scaffoldKey.currentState.isDrawerOpen) {
                Navigator.pop(context);
              }
            } else {
              _drawerIconController.forward();
              _scaffoldKey.currentState.openDrawer();
            }
          },
        ),
      ),
      body: Scaffold(
        key: _scaffoldKey,
        drawer: CategoriesDrawer(),
        backgroundColor: Colors.black87,
        body: _articles.isNotEmpty
            ? ListView(
                children: _articles.map((e) => ArticleTile(e)).toList(),
              )
            : Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.grey.withOpacity(0.6))),
              ),
      ),
    );
  }
}
