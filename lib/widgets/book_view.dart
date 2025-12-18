import 'package:book_store_plus/cubit/books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/literature.dart';

class BookView extends StatefulWidget {
  final Literature book;
  const BookView({super.key, required this.book});

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;
    final BooksCubit booksCubit = context.watch<BooksCubit>();
    bool favorite = booksCubit.favorities.contains(widget.book);
    bool isInCart = booksCubit.inCart.contains(widget.book);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      booksCubit.addToFavorities(widget.book);
                    });
                  },
                  icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child:
                      isWide
                          ? Row(
                            spacing: 24,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: _BookCover(
                                  book: widget.book,
                                  height: 400,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: _BookDetails(
                                  book: widget.book,
                                  inShoppingCart: isInCart,
                                  addToCart: () {
                                    setState(() {
                                      booksCubit.addToCart(widget.book);
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _BookCover(book: widget.book, height: 300),
                              const SizedBox(height: 16),
                              _BookDetails(
                                book: widget.book,
                                inShoppingCart: isInCart,
                                addToCart: () {
                                  setState(() {
                                    booksCubit.addToCart(widget.book);
                                  });
                                },
                              ),
                            ],
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookCover extends StatelessWidget {
  final Literature book;
  final double height;
  const _BookCover({required this.book, required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child:
          book.coverImage.isNotEmpty
              ? Image.network(
                book.coverImage,
                height: height,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(),
              )
              : _placeholder(),
    );
  }
}

class _BookDetails extends StatelessWidget {
  final Literature book;
  final bool inShoppingCart;
  final VoidCallback addToCart;

  const _BookDetails({
    required this.book,
    required this.inShoppingCart,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Название
        Text(
          book.title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Автор
        Text(
          "Автор: ${book.author}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),

        // Рейтинг со звёздами
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(
              book.rating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Описание
        Text(book.description, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 24),

        // Цена + кнопка купить
        Row(
          children: [
            Text(
              "${book.price.toStringAsFixed(2)} ₽",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: addToCart,
                icon: const Icon(Icons.shopping_cart),
                label: Text(!inShoppingCart ? "Купить" : "В корзине"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _placeholder() {
  return Container(
    height: 300,
    color: Colors.grey[300],
    child: const Icon(Icons.book, size: 50, color: Colors.white),
  );
}
