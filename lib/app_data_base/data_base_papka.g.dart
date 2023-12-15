// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_base_papka.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  LugatDao? _lugatDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LugatModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `english` TEXT NOT NULL, `uzbek` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LugatDao get lugatDao {
    return _lugatDaoInstance ??= _$LugatDao(database, changeListener);
  }
}

class _$LugatDao extends LugatDao {
  _$LugatDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _lugatModelInsertionAdapter = InsertionAdapter(
            database,
            'LugatModel',
            (LugatModel item) => <String, Object?>{
                  'id': item.id,
                  'english': item.english,
                  'uzbek': item.uzbek
                }),
        _lugatModelDeletionAdapter = DeletionAdapter(
            database,
            'LugatModel',
            ['id'],
            (LugatModel item) => <String, Object?>{
                  'id': item.id,
                  'english': item.english,
                  'uzbek': item.uzbek
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LugatModel> _lugatModelInsertionAdapter;

  final DeletionAdapter<LugatModel> _lugatModelDeletionAdapter;

  @override
  Future<List<LugatModel>> umumiyMalumot() async {
    return _queryAdapter.queryList('SELECT * FROM LugatModel ORDER by english',
        mapper: (Map<String, Object?> row) => LugatModel(
            row['english'] as String, row['uzbek'] as String,
            id: row['id'] as int?));
  }

  @override
  Future<List<LugatModel>> umumiyMalumotUzbek() async {
    return _queryAdapter.queryList('SELECT * FROM LugatModel ORDER by uzbek',
        mapper: (Map<String, Object?> row) => LugatModel(
            row['english'] as String, row['uzbek'] as String,
            id: row['id'] as int?));
  }

  @override
  Future<void> malumotQoshish(LugatModel lugatModel) async {
    await _lugatModelInsertionAdapter.insert(
        lugatModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletSoz(LugatModel lugatModel) async {
    await _lugatModelDeletionAdapter.delete(lugatModel);
  }
}
