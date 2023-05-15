import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:how_stories/src/domain/entities/user_entity.dart';
import 'package:how_stories/src/domain/repositories/user_repository.dart';

import 'user_auth_event.dart';
import 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  UserAuthBloc({required UserAuthRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.getCurrentUser().isRight()
              ? UserAuthState.authenticated(
                  authenticationRepository.getCurrentUser().getOrElse(
                        () => UserAccount.empty,
                      ),
                )
              : const UserAuthState.unauthenticated(),
        ) {
    on<UserChanged>(_onUserChanged);
    on<UserLogoutRequested>(_onLogoutRequested);

    // Listen for changes
    _userSubscription =
        _authenticationRepository.getUser('').map<UserAccount>((user) {
      return user.getOrElse(() => UserAccount.empty);
    }).listen((user) {
      add(UserChanged(user));
    });
  }

  final UserAuthRepository _authenticationRepository;
  late final StreamSubscription<UserAccount> _userSubscription;

  void _onUserChanged(UserChanged event, Emitter<UserAuthState> emit) {
    emit(
      event.user == UserAccount.empty
          ? UserAuthState.authenticated(event.user)
          : const UserAuthState.unauthenticated(),
    );
  }

  void _onLogoutRequested(
      UserLogoutRequested event, Emitter<UserAuthState> emit) {
    unawaited(_authenticationRepository.logoutUser());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
