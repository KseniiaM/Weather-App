import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/services/i_database_service.dart';

class DatabaseService implements IDatabaseService {
  Future _createDb() async {

    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
        join(await getDatabasesPath(), 'weather_database.db'),
        onCreate: (db, version) {
          // Run the CREATE TABLE statement on the database.
          return db.execute(
            'CREATE TABLE weather(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
          );
        },
    );
  }
}