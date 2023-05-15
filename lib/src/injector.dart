import 'package:get_it/get_it.dart';
import 'package:how_stories/src/data/repositories/stories_repository_impl.dart';

import 'core/constants.dart';
import 'data/datasources/firebase/auth.dart';
import 'data/datasources/local/app_database.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/stories_repository.dart';
import 'domain/repositories/user_repository.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Local database
  final database =
      await $FloorAppDatabase.databaseBuilder(kDatabaseName).build();
  injector.registerSingleton<AppDatabase>(database);

  // ===== DATA SOURCES ====
  // Auth using Firebase
  final UserAuthRepository firebaseAuthRepository =
      AuthRepositoryImpl(AuthenticationRepository());
  injector.registerSingleton<UserAuthRepository>(firebaseAuthRepository);

  // Stories API
  final StoryRepository storiesRepository = StoriesRepositoryImpl(database);
  injector.registerSingleton<StoryRepository>(storiesRepository);
}
