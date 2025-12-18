import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/books_cubit.dart';
import '../models/literature.dart';
import '../widgets/book_card.dart';

class MyBooksPage extends StatelessWidget {
  const MyBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    List<Literature> books = context.watch<BooksCubit>().favorities;
    return Scaffold(
      appBar: AppBar(title: Text("Избранное")),
      body:
          books.isEmpty
              ? Center(child: Text("Ничего не найдено"))
              : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      width > 800
                          ? 4
                          : width > 600
                          ? 3
                          : width > 400
                          ? 2
                          : 1,
                ),
                shrinkWrap: true,
                itemCount: books.length,
                itemBuilder: (context, index) => BookCard(book: books[index]),
              ),
    );
  }
}
