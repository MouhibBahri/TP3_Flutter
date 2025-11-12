import '../models/book.dart';
import 'database_helper.dart';

class BookService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insertBook(Book book) async {
    final db = await _dbHelper.database;
    await db.transaction((txn) async {
      await txn.rawInsert(
        "INSERT INTO book(name, price, image) VALUES('${book.name}',${book.price},'${book.image}' )",
      );
    });
    await db.close();
  }

  Future<List<Book>> fetchBasketBooks() async {
    List<Book> books = [];
    var db = await _dbHelper.database;

    await db.transaction((txn) async {
      List<Map> list = await txn.rawQuery("SELECT * FROM book");

      for (var element in list) {
        books.add(
          Book(
            element["name"] as String,
            element["price"] as int,
            element["image"].toString(),
          ),
        );
      }
    });

    await db.close();
    return books;
  }

  Future<void> clearBooks() async {
    var db = await _dbHelper.database;
    await db.transaction((txn) async {
      await txn.rawDelete("DELETE FROM book");
    });
    await db.close();
  }
}
