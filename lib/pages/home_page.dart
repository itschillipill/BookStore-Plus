import 'package:book_store_plus/pages/search_page.dart';
import 'package:book_store_plus/widgets/app_bar.dart';
import 'package:book_store_plus/widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: width > 600 ? null : MyDrawer(),
      body: CustomScrollView(
        slivers: [
          MyAppBar(width: width),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Hero(
                tag: "search",
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Нажмите для поиска",
                    focusedBorder: null,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onTap:
                      () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      ),
                ),
              ),
            ),
          ),
          Content(),
        ],
      ),
    );
  }
}
