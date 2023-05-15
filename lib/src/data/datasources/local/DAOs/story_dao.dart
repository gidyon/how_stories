import 'package:floor/floor.dart';
import 'package:how_stories/src/data/datasources/local/entities/story.dart';

import '../../../../core/constants.dart';

@dao
abstract class StoryDao {
  @Query('SELECT * FROM $kStoriesTableName')
  Future<List<LocalStoryEntity>> getAllStories();

  @Query('SELECT * FROM $kStoriesTableName WHERE id = :id')
  Future<LocalStoryEntity?> findStoryById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStory(LocalStoryEntity story);
}
