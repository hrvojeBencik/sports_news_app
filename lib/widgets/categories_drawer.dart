import 'package:flutter/material.dart';
import 'package:sports_news/screens/selected_news_screen.dart';

class CategoriesDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Column(
              children: [
                _drawerTile(context, "Football", SelectedNewsScreen.routeName),
                _drawerTile(context, "NBA", SelectedNewsScreen.routeName),
                _drawerTile(context, "NFL", SelectedNewsScreen.routeName),
                _drawerTile(context, "Tennis", SelectedNewsScreen.routeName),
                _drawerTile(context, "Golf", SelectedNewsScreen.routeName),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _drawerTile(BuildContext context, String title, String routeName) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w200,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SelectedNewsScreen(title),
          ),
        );
      },
    );
  }
}
