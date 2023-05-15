import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

abstract class UserAuthEvent extends Equatable {
  const UserAuthEvent();

  @override
  List<Object> get props => [];
}

class UserLogoutRequested extends UserAuthEvent {
  const UserLogoutRequested();
}

class UserChanged extends UserAuthEvent {
  const UserChanged(this.user);

  final UserAccount user;
}
