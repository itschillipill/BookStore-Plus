import 'package:book_store_plus/models/filter.dart';
import 'package:book_store_plus/models/literature.dart';

List<Literature> filterBooks(List<Literature> books, Filter? filter) {
  if (filter == null || filter == Filter.none()) return books;

  return books.where((book) {
    final matchesAudience =
        filter.audience == null || filter.audience!.contains(book.audience);
    final matchesGenre =
        filter.genres == null || filter.genres!.contains(book.genre);
    final matchesMaxPrice =
        filter.maxPrice == null || book.price <= filter.maxPrice!;
    final matchesMinPrice =
        filter.minPrice == null || book.price >= filter.minPrice!;
    final matchesLanguage =
        filter.languages == null || filter.languages!.contains(book.language);
    return matchesAudience &&
        matchesGenre &&
        matchesMinPrice &&
        matchesMaxPrice &&
        matchesLanguage;
  }).toList();
}
