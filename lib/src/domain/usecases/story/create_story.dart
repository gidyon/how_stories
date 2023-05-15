import 'package:dartz/dartz.dart';
import 'package:how_stories/src/domain/entities/story_entity.dart';
import 'package:how_stories/src/domain/repositories/stories_repository.dart';

import '../../../core/failure.dart';
import '../../../core/use_case.dart';

class CreateStoryUseCase
    implements UseCaseFuture<Either<Failure, Story>, Story> {
  final StoryRepository _storyRepository;

  CreateStoryUseCase(this._storyRepository);

  @override
  Future<Either<Failure, Story>> call({Story? params}) {
    return _storyRepository.createStory(params!);
  }
}
