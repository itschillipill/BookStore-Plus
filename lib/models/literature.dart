// models/literature.dart
import 'package:book_store_plus/models/language.dart';

import 'audience.dart';
import 'genre.dart';

class Literature {
  final String title;
  final String author;
  final String description;
  final String coverImage;
  final double price;
  final Language language;
  final Audience audience;
  final int pages;
  final int ageLimit;
  final Genre genre;
  final double rating;

  Literature({
    required this.title,
    required this.author,
    required this.description,
    required this.coverImage,
    required this.price,
    required this.language,
    required this.audience,
    required this.pages,
    required this.ageLimit,
    required this.genre,
    required this.rating,
  });

  factory Literature.fromJson(Map<String, dynamic> json) {
    return Literature(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      coverImage: json['coverImage'],
      price: (double.tryParse(json['price'].toString()) ?? 0) * 33,
      language: Language.values.firstWhere(
        (e) => e.name == json['language'],
        orElse: () => Language.en,
      ),
      audience: Audience.values.firstWhere(
        (e) => e.name == json['audience'],
        orElse: () => Audience.all,
      ),
      pages: json['pages'],
      ageLimit: int.tryParse(json['ageLimit'].toString()) ?? 0,
      genre: Genre.values.firstWhere(
        (e) => e.name == json['genre'],
        orElse: () => Genre.fantasy,
      ),
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
