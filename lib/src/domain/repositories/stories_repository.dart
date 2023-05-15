import "package:dartz/dartz.dart";

import '../../core/failure.dart';
import '../../core/params/list_stories_request.dart';
import '../entities/story_entity.dart';

abstract class StoryRepository {
  Future<Either<Failure, Story>> createStory(Story data);
  Future<Either<Failure, Story>> getStory(String id);
  Future<Either<Failure, List<Story>>> listStories(
      ListArticlesRequestParams params);
}
