import 'package:how_stories/src/data/datasources/firebase/auth.dart';
import 'package:how_stories/src/domain/entities/user_entity.dart';

import 'package:how_stories/src/core/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/user_repository.dart';

class AuthRepositoryImpl extends UserAuthRepository {
  final AuthenticationRepository _authRepository;

  AuthRepositoryImpl(this._authRepository);

  @override
  Stream<Either<Failure, UserAccount>> getUser(String id) {
    return _authRepository.user.map((user) {
      if (user.isNotEmpty) {
        return Right(UserAccount(
          id: user.id,
          names: user.name ?? '',
          profileUrl: user.photo ?? '',
          email: user.email ?? '',
          phone: '',
          password: '',
        ));
      }
      return const Right(UserAccount.empty);
    });
  }

  @override
  Future<Either<Failure, bool>> logoutUser() async {
    try {
      await _authRepository.logOut();
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserAccount>> registerUser(UserAccount data) async {
    try {
      await _authRepository.signUp(email: data.email, password: data.password);
      return Right(data);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Either<Failure, UserAccount> getCurrentUser() {
    try {
      var user = _authRepository.currentUser;
      return Right(UserAccount(
        id: user.id,
        names: user.name ?? '',
        profileUrl: user.photo ?? '',
        email: user.email ?? '',
        phone: '',
        password: '',
      ));
    } catch (e) {
      return const Right(UserAccount.empty);
    }
  }
}
