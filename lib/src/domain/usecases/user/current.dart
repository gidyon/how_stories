import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../../../core/use_case.dart';
import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetCurrentUserAccountUseCase
    implements UseCase<Either<Failure, UserAccount>, String> {
  final UserAuthRepository _userAccountRepository;

  GetCurrentUserAccountUseCase(this._userAccountRepository);

  @override
  Either<Failure, UserAccount> call({String? params}) {
    return _userAccountRepository.getCurrentUser();
  }
}
