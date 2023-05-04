import 'package:authapp/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

import 'bloc_event.dart';
import 'bloc_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
// final AuthRepository authRepository;
// AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
//   on<EmailSignUpRequested>((event, state) async {
//     //TO DO: emit loading state
//     emit(LoadingState());
//     //TO DO: signup logic in try catch
//     try {
//       authRepository.signUp(
//           firstName: event.firstName,
//           lastName: event.lastName,
//           email: event.email,
//           password: event.password);

//       emit(Authenticated());
//     } catch (e) {
//       emit(UnAuthenticated());
//     }
//   });

//   //signin
//   on<EmailSignInRequested>((event, state) async {
//     //TO DO: emit loading state
//     emit(LoadingState());
//     //TO DO: signup logic in try catch
//     try {
//       authRepository.SignIn(email: event.email, password: event.password);

//       emit(Authenticated());
//     } catch (e) {
//       emit(UnAuthenticated());
//     }
//   });
//   on<PhoneSignAuthRequested>((event, state) async {
//     //To Do: phone sign in
//   });
// }
// }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository userRepository;

  AuthBloc(this.userRepository) : super(InitialAuthState()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.getUser() != null;

      if (hasToken) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(Loading());
      emit(Authenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(Loading());
      emit(Unauthenticated());
    });
  }

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {}
}
