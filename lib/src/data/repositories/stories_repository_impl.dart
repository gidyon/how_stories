// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:how_stories/src/core/failure.dart';
import 'package:how_stories/src/core/params/list_stories_request.dart';
import 'package:how_stories/src/data/datasources/local/app_database.dart';
import 'package:how_stories/src/data/datasources/local/entities/story.dart';
import 'package:how_stories/src/domain/entities/story_entity.dart';
import 'package:how_stories/src/domain/repositories/stories_repository.dart';

const kImageUrlSplitter = '[###]';

class StoriesRepositoryImpl extends StoryRepository {
  final AppDatabase _appDatabase;

  StoriesRepositoryImpl(this._appDatabase);

  @override
  Future<Either<Failure, Story>> createStory(Story data) async {
    try {
      await _appDatabase.storyDao.insertStory(
        LocalStoryEntity(
          id: data.id,
          author: data.author,
          title: data.title,
          description: data.description,
          contentText: data.contentText,
          contentHtml: data.contentHtml,
          approved: data.approved,
          imageUrls: data.imageUrls.join(kImageUrlSplitter),
          creatorId: data.creatorId,
          editorId: data.editorId,
          approvedAtUnixTimestamp: data.approvedAtUnixTimestamp,
          modificationLogs: data.modificationLogs,
          updatedAtUnixTimestamp: data.updatedAtUnixTimestamp,
          createdAtUnixTimestamp: data.createdAtUnixTimestamp,
        ),
      );
      return Right(data);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Story>> getStory(String id) async {
    try {
      var story = await _appDatabase.storyDao.findStoryById(id);
      return Right(
        Story(
          id: id,
          author: story!.author,
          title: story.title,
          description: story.description,
          contentText: story.contentText,
          contentHtml: story.contentHtml,
          approved: story.approved,
          imageUrls: story.imageUrls.split(kImageUrlSplitter),
          creatorId: story.creatorId,
          editorId: story.editorId,
          approvedAtUnixTimestamp: story.approvedAtUnixTimestamp,
          modificationLogs: story.modificationLogs,
          updatedAtUnixTimestamp: story.updatedAtUnixTimestamp,
          createdAtUnixTimestamp: story.createdAtUnixTimestamp,
        ),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Story>>> listStories(
      ListArticlesRequestParams params) async {
    try {
      var stories = await _appDatabase.storyDao.getAllStories();
      return Right(
        stories
            .map((story) => Story(
                  id: story.id,
                  author: story.author,
                  title: story.title,
                  description: story.description,
                  contentText: story.contentText,
                  contentHtml: story.contentHtml,
                  approved: story.approved,
                  imageUrls: story.imageUrls.split(kImageUrlSplitter),
                  creatorId: story.creatorId,
                  editorId: story.editorId,
                  approvedAtUnixTimestamp: story.approvedAtUnixTimestamp,
                  modificationLogs: story.modificationLogs,
                  updatedAtUnixTimestamp: story.updatedAtUnixTimestamp,
                  createdAtUnixTimestamp: story.createdAtUnixTimestamp,
                ))
            .toList(),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
