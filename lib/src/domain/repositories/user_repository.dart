import "package:dartz/dartz.dart";

import '../../core/failure.dart';
import '../entities/user_entity.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, UserAccount>> registerUser(UserAccount data);
  Stream<Either<Failure, UserAccount>> getUser(String id);
  Future<Either<Failure, bool>> logoutUser();
  Either<Failure, UserAccount> getCurrentUser();
}
