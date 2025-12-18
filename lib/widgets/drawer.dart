import 'package:book_store_plus/models/user.dart';
import 'package:book_store_plus/pages/contact_page.dart';
import 'package:book_store_plus/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../pages/cart_page.dart';
import '../pages/my_books_page.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final user = User.appUser();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );  
            },
            child: UserAccountsDrawerHeader(
              accountName: Text(user.name),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Корзина"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text("Мои книги"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyBooksPage()),
              );
              
            },
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Контакты"),
            onTap: () {
              Navigator.pop(context);
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
