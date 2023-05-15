import 'package:dartz/dartz.dart';
import 'package:how_stories/src/domain/entities/story_entity.dart';
import 'package:how_stories/src/domain/repositories/stories_repository.dart';

import '../../../core/failure.dart';
import '../../../core/use_case.dart';

class GetStoryUseCase implements UseCaseFuture<Either<Failure, Story>, String> {
  final StoryRepository _storyRepository;

  GetStoryUseCase(this._storyRepository);

  @override
  Future<Either<Failure, Story>> call({String? params}) {
    return _storyRepository.getStory(params!);
  }
}
