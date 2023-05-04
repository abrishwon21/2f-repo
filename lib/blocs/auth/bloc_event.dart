import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  AuthEvent([List props = const []]);
}

// class PhoneSignAuthRequested extends AuthEvent {
//   final String phone;
//   PhoneSignAuthRequested(this.phone);
// }

class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final String token;

  LoggedIn({required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  // TODO: implement props
  List<Object> get props => [];
}
