// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'DAOs/story_dao.dart';
import 'entities/story.dart';

part 'app_database.g.dart';

// @TypeConverters([SourceTypeConverter])
@Database(version: 1, entities: [LocalStoryEntity])
abstract class AppDatabase extends FloorDatabase {
  StoryDao get storyDao;
}
