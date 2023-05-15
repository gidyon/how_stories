import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../../../core/use_case.dart';
import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class CreateUserAccountUseCase
    implements UseCaseFuture<Either<Failure, UserAccount>, UserAccount> {
  final UserAuthRepository _userAccountRepository;

  CreateUserAccountUseCase(this._userAccountRepository);

  @override
  Future<Either<Failure, UserAccount>> call({UserAccount? params}) {
    return _userAccountRepository.registerUser(params!);
  }
}
