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

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, List<Literature>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Ничего не найдено :/",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: context.deps.booksCubit.loadData,
                  child: const Text("Обновить список"),
                ),
              ],
            ),
          );
        }

        final romance = filterBooks(state, Filter(genres: [Genre.romance]));
        final fantasy = filterBooks(state, Filter(genres: [Genre.fantasy]));
        final detective =
            filterBooks(state, Filter(genres: [Genre.scienceFiction]));
        final russian = filterBooks(state, Filter(languages: [Language.ru]));

        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildList("На русском языке", russian),
                _buildList("Фантастика", fantasy),
                _buildList("Романы", romance),
                _buildList("Детективы", detective),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildList(String title, List<Literature> books) {
    if (books.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
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
        const SizedBox(height: 20),
      ],
    );
  }
}
