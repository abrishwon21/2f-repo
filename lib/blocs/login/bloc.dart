import 'dart:async';

import 'package:authapp/blocs/auth/bloc_state.dart';
import 'package:authapp/blocs/login/event.dart';
import 'package:authapp/blocs/login/state.dart';
import 'package:authapp/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  StreamSubscription? subscription;

  String verID = "";

  LoginBloc({required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(InitialLoginState()) {
    on<EmailSignUpRequested>((event, emit) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      emit(LoadingState());
      bool res = await _authRepository.signUp(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password);

      User u = await _authRepository.getUser();

      if (res) {
        _pref.setString("uid", u.uid);
        emit(LoginCompleteState(u));
      } else {
        emit(LogInFailed());
      }
    });

    on<EmailSignInRequested>((event, emit) async {
      emit(LoadingState());
      SharedPreferences _pref = await SharedPreferences.getInstance();
      EmailSignInRequested(event.email, event.password);
      await _authRepository.SignIn(
          email: event.email, password: event.password);
      User u = await _authRepository.getUser();
      _pref.setString("uid", u.uid);
      emit(LoginCompleteState(u));
    });
    on<SendOtpEvent>(
      (event, emit) async {
        emit(LoadingState());
        Stream subscription = await sendOtp(event.phoNo);
      },
    );

    on<OtpSendEvent>(
      (event, emit) async {
        emit(OtpSentState());
      },
    );

    on<LoginCompleteEvent>(
      (event, emit) async {
        emit(LoginCompleteState(event.firebaseUser));
      },
    );

    on<LoginExceptionEvent>(
      (event, emit) async {
        emit(LoginCompleteState(
            ExceptionState(message: event.message) as User?));
      },
    );

    on<VerifyOtpEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
          UserCredential result =
              await _authRepository.verifyAndLogin(verID, event.otp);
          if (result.user != null) {
            emit(LoginCompleteState(result.user));
          } else {
            emit(OtpExceptionState(message: "Invalid otp!"));
          }
        } catch (e) {
          emit(OtpExceptionState(message: "Invalid otp!"));
          print(e);
        }
      },
    );
  }

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {}

  @override
  void onEvent(LoginEvent event) {
    // TODO: implement onEvent
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    // TODO: implement onError
    super.onError(error, stacktrace);
    print(stacktrace);
  }

  Future<void> close() async {
    print("Bloc closed");
    super.close();
  }

  Stream<LoginEvent> sendOtp(String phoNo) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    final PhoneVerificationCompleted = (AuthCredential authCredential) {
      _authRepository.getUser();
      _authRepository.getUser().catchError((onError) {
        print(onError);
      }).then((user) {
        eventStream.add(LoginCompleteEvent(user));
        eventStream.close();
      });
    };

    final PhoneVerificationFailed = (FirebaseAuthException authException) {
      print(authException.message);
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final PhoneCodeSent = (String verId, [int? forceResent]) {
      this.verID = verId;
      eventStream.add(OtpSendEvent());
    };
    final PhoneCodeAutoRetrievalTimeout = (String verid) {
      this.verID = verid;
      eventStream.close();
    };

    await _authRepository.sendOtp(
        phoNo,
        Duration(seconds: 1),
        PhoneVerificationFailed,
        PhoneVerificationCompleted,
        PhoneCodeSent,
        PhoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }
}
