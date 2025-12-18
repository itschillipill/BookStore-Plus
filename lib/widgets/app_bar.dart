import 'package:book_store_plus/pages/cart_page.dart';
import 'package:book_store_plus/pages/my_books_page.dart';
import 'package:book_store_plus/pages/profile_page.dart';
import 'package:book_store_plus/utils/constants/constants.dart';
import 'package:flutter/material.dart';

import '../pages/contact_page.dart';

class MyAppBar extends StatelessWidget {
  final double width;
  const MyAppBar({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: false,
      title: Text(
        Constants.appName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions:
          width < 600
              ? null
              : [
                TextButton.icon(
                  label: Text("Корзина"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                  icon: Icon(Icons.shopping_cart_rounded),
                ),
                TextButton.icon(
                  label: Text("Контакты"),
                  onPressed: () {
                    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),);
                  },
                  icon: Icon(Icons.phone),
                ),
                TextButton.icon(
                  label: Text("Мои книги"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyBooksPage()),
                    );
                  },
                  icon: Icon(Icons.book),
                ),
                IconButton(onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                }, icon: Icon(Icons.person)),
              ],
    );
  }
}
