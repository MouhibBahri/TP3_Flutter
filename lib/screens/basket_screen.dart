import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  final BookService _bookService = BookService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basket"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await _bookService.clearBooks();
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: _bookService.fetchBasketBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erreur : ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final books = snapshot.data ?? [];

          if (books.isEmpty) {
            return const Center(child: Text("Aucun livre trouvé"));
          }

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return ListTile(
                leading: Image.network(
                  book.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(book.name),
                subtitle: Text("Prix : ${book.price} DT"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSampleBook,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addSampleBook() async {
    await _bookService.insertBook(
      Book("Clean Code", 50, "https://picsum.photos/200"),
    );
    setState(() {});
  }
}
