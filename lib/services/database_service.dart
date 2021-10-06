import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqf_lite;
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/i_database_service.dart';

@Injectable(as: IDatabaseService)
class DatabaseService implements IDatabaseService {

  static const String tableName = 'weather';

  @override
  Future insertWeatherItems(List<WeatherModel> weatherModels) async {
    final db = await _createOrGetDb();
    var batch = db.batch();

    weatherModels.forEach((model) {
      batch.insert(tableName,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    });

    await batch.commit(noResult: true);
  }

  @override
  Future<void> insertWeather(WeatherModel weatherModel) async {
    final db = await _createOrGetDb();

    await db.insert(
      tableName,
      weatherModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.close();
  }

  @override
  Future<List<WeatherModel>> getWeather() async {
    final db = await _createOrGetDb();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    await db.close();

    return List.generate(maps.length, (i) {
      return WeatherModel.db(
        maps[i]['id'],
        maps[i]['weather_description'],
        maps[i]['temperature'],
        maps[i]['city_name'],
        maps[i]['time'],
      );
    });
  }

  @override
  Future deleteAllStoredWeather() async {
    final db = await _createOrGetDb();
    await db.rawDelete('DELETE FROM ' + tableName);
  }

  Future<Database> _createOrGetDb() async {
    return await sqf_lite.openDatabase(
        join(await sqf_lite.getDatabasesPath(), 'weather_database.db'),
        version: 1,
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE weather('
                'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                'weather_description TEXT, '
                'temperature REAL,'
                'city_name TEXT,'
                'time TEXT)',
          );
        }
    );
  }
}