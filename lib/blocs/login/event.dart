import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends LoginEvent {
  String phoNo;

  SendOtpEvent({required this.phoNo});
}

class AppStartEvent extends LoginEvent {}

class VerifyOtpEvent extends LoginEvent {
  String otp;

  VerifyOtpEvent({required this.otp});
}

class LogoutEvent extends LoginEvent {}

class OtpSendEvent extends LoginEvent {}

class LoginCompleteEvent extends LoginEvent {
  final User firebaseUser;
  LoginCompleteEvent(this.firebaseUser);
}

class LoginExceptionEvent extends LoginEvent {
  String message;

  LoginExceptionEvent(this.message);
}

class EmailSignUpRequested extends LoginEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  EmailSignUpRequested(
      this.firstName, this.lastName, this.email, this.password);
}

class EmailSignInRequested extends LoginEvent {
  final String email;
  final String password;
  EmailSignInRequested(this.email, this.password);
}
