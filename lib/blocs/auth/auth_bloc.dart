import 'package:authapp/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_event.dart';
import 'bloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthRepository _authRepository;

  AuthBloc({authRepository}) : super(InitialAuthState()) {
    _authRepository = authRepository;
    on<AppStarted>((event, emit) async {
      final bool hasToken = await _authRepository.getUser() != null;
      SharedPreferences _pref = await SharedPreferences.getInstance();
      bool _isLoggedin = await _pref.getString("uid") != null;

      if (hasToken || _isLoggedin) {
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
