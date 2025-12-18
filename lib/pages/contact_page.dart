import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Контакты"),
        centerTitle: true,
      ),

      body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildContactsCard(context),
                _buildFormCard(context),
              ],
            ),
    );
  }

  Widget _buildContactsCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Наши контакты",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              children: const [
                Icon(Icons.phone, color: Colors.blue),
                SizedBox(width: 10),
                Text("+1 (800) 123-4567", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: const [
                Icon(Icons.email, color: Colors.red),
                SizedBox(width: 10),
                Text("support@bookstore.com", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: const [
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "123 Book Street, New York, USA",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Divider(color: Colors.grey.shade300, thickness: 1),

            const SizedBox(height: 20),
            const Text(
              "Мы всегда здесь чтобы помочь! Задавайте свои вопросы и предложения",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildFormCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Отправте нам сообщения",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Ваше имя",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Введите ваше имя" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || !v.contains("@") ? "Введите корректный email" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _messageController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Сообщение",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Введите ваше сообщение" : null,
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showSuccessDialog();
                    }
                  },
                  child: const Text("Отправить"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Message Sent"),
        content: Text(
          "Thank you, ${_nameController.text}! We will reply to your email shortly.",
        ),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
