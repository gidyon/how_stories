import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

enum AppStatus {
  loading,
  authenticated,
  unauthenticated,
}

class UserAuthState extends Equatable {
  final UserAccount user;
  final AppStatus status;

  const UserAuthState._({
    required this.status,
    this.user = UserAccount.empty,
  });

  const UserAuthState.loading() : this._(status: AppStatus.loading);

  const UserAuthState.authenticated(UserAccount user)
      : this._(status: AppStatus.authenticated, user: user);

  const UserAuthState.unauthenticated()
      : this._(status: AppStatus.unauthenticated);

  @override
  List<Object> get props => [];
}
