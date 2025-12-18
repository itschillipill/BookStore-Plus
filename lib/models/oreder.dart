// models/order.dart
import 'package:book_store_plus/models/literature.dart';

class Oreder {
  final String name;
  final String phone;
  final String address;
  final List<Literature> books;
  final double totalPrice;

  Oreder({
    required this.name,
    required this.phone,
    required this.address,
    required this.books,
    required this.totalPrice,
  });
}