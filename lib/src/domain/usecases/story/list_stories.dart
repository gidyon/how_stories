import 'package:dartz/dartz.dart';
import 'package:how_stories/src/core/params/list_stories_request.dart';
import 'package:how_stories/src/domain/entities/story_entity.dart';
import 'package:how_stories/src/domain/repositories/stories_repository.dart';

import '../../../core/failure.dart';
import '../../../core/use_case.dart';

class ListStoriesCase
    implements
        UseCaseFuture<Either<Failure, List<Story>>, ListArticlesRequestParams> {
  final StoryRepository _storyRepository;

  ListStoriesCase(this._storyRepository);

  @override
  Future<Either<Failure, List<Story>>> call(
      {ListArticlesRequestParams? params}) {
    return _storyRepository.listStories(params!);
  }
}
