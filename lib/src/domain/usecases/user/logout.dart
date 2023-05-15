import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../../../core/use_case.dart';
import '../../repositories/user_repository.dart';

class LogoutAccountUseCase
    implements UseCaseFuture<Either<Failure, bool>, String> {
  final UserAuthRepository _userAccountRepository;

  LogoutAccountUseCase(this._userAccountRepository);

  @override
  Future<Either<Failure, bool>> call({String? params}) {
    return _userAccountRepository.logoutUser();
  }
}
