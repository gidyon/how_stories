// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserAccount extends Equatable {
  final String id;
  final String names;
  final String profileUrl;
  final String email;
  final String phone;
  final String password;

  const UserAccount({
    required this.id,
    required this.names,
    required this.profileUrl,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      names,
      profileUrl,
      email,
      phone,
    ];
  }

  static const empty = UserAccount(
    id: '',
    names: '',
    profileUrl: '',
    email: '',
    phone: '',
    password: '',
  );
}
