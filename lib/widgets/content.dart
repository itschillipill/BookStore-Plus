import 'package:book_store_plus/cubit/books_cubit.dart';
import 'package:book_store_plus/models/filter.dart';
import 'package:book_store_plus/models/genre.dart';
import 'package:book_store_plus/models/literature.dart';
import 'package:book_store_plus/services/filter_books.dart';
import 'package:book_store_plus/utils/extentions.dart';
import 'package:book_store_plus/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/language.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<Literature> romance = [];
  List<Literature> fantasy = [];
  List<Literature> detective = [];
  List<Literature> russian =[];

  @override
  void initState() {
    romance = filterBooks(
      context.deps.booksCubit.state,
      Filter(genres: [Genre.romance]),
    );
    fantasy = filterBooks(
      context.deps.booksCubit.state,
      Filter(genres: [Genre.fantasy]),
    );
    detective = filterBooks(
      context.deps.booksCubit.state,
      Filter(genres: [Genre.scienceFiction]),
    );
    russian = filterBooks(
      context.deps.booksCubit.state,
      Filter(languages: [Language.ru]),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, List<Literature>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 15,
              children: [
                Text(
                  "Ничего не найдено :/",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton(
                  onPressed: context.deps.booksCubit.loadData,
                  child: Text("Обновить список"),
                ),
              ],
            ),
          );
        }

        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildList("На русском языке", russian),
                _buildList("Фантастика", fantasy),
                _buildList("Роаны", romance),
                _buildList("Детективы", detective),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildList(String title, List<Literature> books) {
    if (books.isEmpty) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length > 12 ? 12 : books.length,
            itemBuilder: (context, index) {
              return BookCard(book: books[index]);
            },
          ),
        ),
      ],
    );
  }
}
