import '../models/book.dart';
import 'database_helper.dart';

class BookService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insertBook(Book book) async {
    final db = await _dbHelper.database;

    await db.insert('book', {
      'name': book.name,
      'price': book.price,
      'image': book.image,
    });

    print("Inserted: ${book.name}");
  }

  Future<List<Book>> fetchBasketBooks() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query('book');

    return List.generate(maps.length, (i) {
      return Book(
        maps[i]['name'] as String,
        maps[i]['price'] as int,
        maps[i]['image'] as String,
      );
    });
  }

  Future<void> clearBooks() async {
    final db = await _dbHelper.database;
    await db.delete('book');
    print("All books cleared");
  }

  Future<void> deleteBook(String name) async {
    final db = await _dbHelper.database;
    await db.delete('book', where: 'name = ?', whereArgs: [name]);
  }
}
