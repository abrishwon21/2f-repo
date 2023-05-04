import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class InitialAuthState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Uninitialized extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loading extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
