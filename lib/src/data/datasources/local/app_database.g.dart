// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StoryDao? _storyDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `stories` (`id` TEXT NOT NULL, `author` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `contentText` TEXT NOT NULL, `contentHtml` TEXT NOT NULL, `approved` INTEGER NOT NULL, `imageUrls` TEXT NOT NULL, `creatorId` TEXT NOT NULL, `editorId` TEXT NOT NULL, `approvedAtUnixTimestamp` INTEGER NOT NULL, `modificationLogs` TEXT NOT NULL, `updatedAtUnixTimestamp` INTEGER NOT NULL, `createdAtUnixTimestamp` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StoryDao get storyDao {
    return _storyDaoInstance ??= _$StoryDao(database, changeListener);
  }
}

class _$StoryDao extends StoryDao {
  _$StoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _localStoryEntityInsertionAdapter = InsertionAdapter(
            database,
            'stories',
            (LocalStoryEntity item) => <String, Object?>{
                  'id': item.id,
                  'author': item.author,
                  'title': item.title,
                  'description': item.description,
                  'contentText': item.contentText,
                  'contentHtml': item.contentHtml,
                  'approved': item.approved ? 1 : 0,
                  'imageUrls': item.imageUrls,
                  'creatorId': item.creatorId,
                  'editorId': item.editorId,
                  'approvedAtUnixTimestamp': item.approvedAtUnixTimestamp,
                  'modificationLogs': item.modificationLogs,
                  'updatedAtUnixTimestamp': item.updatedAtUnixTimestamp,
                  'createdAtUnixTimestamp': item.createdAtUnixTimestamp
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LocalStoryEntity> _localStoryEntityInsertionAdapter;

  @override
  Future<List<LocalStoryEntity>> getAllStories() async {
    return _queryAdapter.queryList('SELECT * FROM stories',
        mapper: (Map<String, Object?> row) => LocalStoryEntity(
            id: row['id'] as String,
            author: row['author'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            contentText: row['contentText'] as String,
            contentHtml: row['contentHtml'] as String,
            approved: (row['approved'] as int) != 0,
            imageUrls: row['imageUrls'] as String,
            creatorId: row['creatorId'] as String,
            editorId: row['editorId'] as String,
            approvedAtUnixTimestamp: row['approvedAtUnixTimestamp'] as int,
            modificationLogs: row['modificationLogs'] as String,
            updatedAtUnixTimestamp: row['updatedAtUnixTimestamp'] as int,
            createdAtUnixTimestamp: row['createdAtUnixTimestamp'] as int));
  }

  @override
  Future<LocalStoryEntity?> findStoryById(String id) async {
    return _queryAdapter.query('SELECT * FROM stories WHERE id = ?1',
        mapper: (Map<String, Object?> row) => LocalStoryEntity(
            id: row['id'] as String,
            author: row['author'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            contentText: row['contentText'] as String,
            contentHtml: row['contentHtml'] as String,
            approved: (row['approved'] as int) != 0,
            imageUrls: row['imageUrls'] as String,
            creatorId: row['creatorId'] as String,
            editorId: row['editorId'] as String,
            approvedAtUnixTimestamp: row['approvedAtUnixTimestamp'] as int,
            modificationLogs: row['modificationLogs'] as String,
            updatedAtUnixTimestamp: row['updatedAtUnixTimestamp'] as int,
            createdAtUnixTimestamp: row['createdAtUnixTimestamp'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertStory(LocalStoryEntity story) async {
    await _localStoryEntityInsertionAdapter.insert(
        story, OnConflictStrategy.replace);
  }
}
