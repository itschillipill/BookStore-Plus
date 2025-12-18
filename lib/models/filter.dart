// models/filter.dart
import 'package:book_store_plus/models/audience.dart';
import 'package:book_store_plus/models/genre.dart';
import 'package:book_store_plus/models/language.dart';

class Filter {
  final List<Audience>? audience;
  final List<Genre>? genres;
  final double? minPrice;
  final double? maxPrice;
  final List<Language>? languages;
  final int? ageLimit;

  Filter({
    this.genres,
    this.minPrice,
    this.maxPrice,
    this.ageLimit,
    this.audience,
    this.languages,
  });

  factory Filter.none() => Filter();
}
