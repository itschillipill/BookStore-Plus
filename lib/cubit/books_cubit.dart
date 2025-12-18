// cubit/books_cubit.dart
import 'package:book_store_plus/models/literature.dart';
import 'package:book_store_plus/services/filter_books.dart';
import 'package:book_store_plus/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/filter.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

class BooksCubit extends Cubit<List<Literature>> {
  BooksCubit() : super([]) {
    loadData();
  }

  List<Literature> favorities = [];
  List<Literature> inCart = [];

  Future<void> loadData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/books.json');
      final List decoded = jsonDecode(jsonString);

      final books = decoded.map((e) => Literature.fromJson(e)).toList();

      emit(books);
    } catch (e) {
      debugPrint("Error loading books: $e");
      emit([]);
    }
  }

  void addToFavorities(Literature book) {
    if (favorities.contains(book)) {
      MessageService.showSnackBar("Убрано из избранного");
      favorities.remove(book);
      return;
    }
    favorities.add(book);
    MessageService.showSnackBar("Добавлено в избранное");
  }

  void addToCart(Literature book) {
    if (inCart.contains(book)) {
      inCart.remove(book);
      return;
    }
    inCart.add(book);
  }
  void clearCart() {
    inCart.clear();
  }
  void clearFavorities() {
    favorities.clear();
  }

  List<Literature> search(String query, {Filter? filter}) {
    final q = query.toLowerCase();
    if (q.isEmpty) return filterBooks(state, filter);

    final res =
        state.where((book) {
          final inTitle = book.title.toLowerCase().contains(q);
          final inAuthor = book.author.toLowerCase().contains(q);
          return inTitle || inAuthor;
        }).toList();

    return filterBooks(res, filter);
  }
}
