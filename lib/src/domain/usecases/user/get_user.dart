import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../../../core/use_case.dart';
import '../../entities/user_entity.dart';
import '../../repositories/user_repository.dart';

class GetUserAccountUseCase
    implements UseCaseStream<Either<Failure, UserAccount>, String> {
  final UserAuthRepository _userAccountRepository;

  GetUserAccountUseCase(this._userAccountRepository);

  @override
  Stream<Either<Failure, UserAccount>> call({String? params}) {
    return _userAccountRepository.getUser(params!);
  }
}
