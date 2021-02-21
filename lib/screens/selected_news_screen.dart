import 'package:flutter/material.dart';
import 'package:sports_news/models/article.dart';
import 'package:sports_news/services/api_service.dart';
import 'package:sports_news/widgets/article_tile.dart';

class SelectedNewsScreen extends StatefulWidget {
  static const String routeName = "/football-news";
  final String selectedSport;
  SelectedNewsScreen(this.selectedSport);
  @override
  _SelectedNewsScreenState createState() => _SelectedNewsScreenState();
}

class _SelectedNewsScreenState extends State<SelectedNewsScreen> {
  List<Article> _newsData = [];

  @override
  void initState() {
    super.initState();
    _getSelectedSportsNews();
  }

  void _getSelectedSportsNews() async {
    ApiService apiService = ApiService();
    String category = "Sports";
    if (widget.selectedSport == "Football") {
      category = "Sports_Soccer";
    } else {
      category = "Sports_" + widget.selectedSport;
    }
    Map data = await apiService.fetchNewsData(category);
    setState(() {
      _newsData = apiService.processNewsData(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.selectedSport),
      ),
      body: Container(
        width: screenWidth,
        color: Colors.black87,
        child: _newsData.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.grey.withOpacity(0.6)),
                ),
              )
            : Container(
                child: RefreshIndicator(
                  color: Colors.black,
                  onRefresh: () async {
                    _getSelectedSportsNews();
                  },
                  child: ListView(
                    children: _newsData.map((e) => ArticleTile(e)).toList(),
                  ),
                ),
              ),
      ),
    );
  }
}
