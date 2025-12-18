import 'package:book_store_plus/cubit/books_cubit.dart';
import 'package:book_store_plus/models/literature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isExpanded = MediaQuery.of(context).size.width > 600;
    List<Literature> inCart = context.watch<BooksCubit>().inCart;

    double totalPrice = inCart.fold(0, (sum, book) => sum + book.price);

    return Scaffold(
      appBar: AppBar(title: const Text("Корзина"), centerTitle: true),

      body:
          inCart.isEmpty
              ? const Center(child: Text("Ваша корзина пуста"))
              :
              isExpanded
              ? Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      itemCount: inCart.length,
                      itemBuilder: (_, index) {
                        final book = inCart[index];
                        return ListTile(
                          leading: SizedBox(
                            width: 50,
                            child:
                                book.coverImage.isNotEmpty
                                    ? Image.network(
                                      book.coverImage,
                                      fit: BoxFit.cover,
                                    )
                                    : const Icon(Icons.book),
                          ),
                          title: Text(book.title),
                          subtitle: Text("${book.price} ₽"),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () {
                              context.read<BooksCubit>().addToCart(book);
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  Expanded(flex: 2, child: _buildOrderForm(totalPrice, inCart)),
                ],
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: inCart.length,
                      itemBuilder: (_, index) {
                        final book = inCart[index];
                        return ListTile(
                          leading: SizedBox(
                            width: 50,
                            child:
                                book.coverImage.isNotEmpty
                                    ? Image.network(
                                      book.coverImage,
                                      fit: BoxFit.cover,
                                    )
                                    : const Icon(Icons.book),
                          ),
                          title: Text(book.title),
                          subtitle: Text("${book.price} ₽"),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () {
                              context.read<BooksCubit>().addToCart(book);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  _buildOrderForm(totalPrice, inCart),
                ],
              ),
    );
  }

  Widget _buildOrderForm(double totalPrice, List<Literature> inCart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Всего товаров: ${inCart.length}", style: const TextStyle(fontSize: 16)),
          Text(
            "Общая цена: ${totalPrice.toStringAsFixed(2)} ₽",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 4),

          Row(
            children: const [
              Icon(Icons.local_shipping, color: Colors.green, size: 18),
              SizedBox(width: 6),
              Text(
                "Бесплатная доставка",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Ваше имя",
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (v) => v == null || v.isEmpty ? "Введите ваше имя" : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Номер телефона",
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? "Введите ваш номер телефона"
                              : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: "Адрес доставки",
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (v) =>
                          v == null || v.isEmpty ? "Введите адрес доставки" : null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    context.read<BooksCubit>().clearCart();
                  });
                  _showSuccess(context);
                }
              },
              child: const Text("Сделать заказ"),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Ваш заказ оформлен"),
            content: Text(
              "Спасибо за заказ, ${nameController.text}! Мы свяжемся с вами по телефону ${phoneController.text}.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }
}
