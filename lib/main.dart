import 'package:authapp/blocs/auth/bloc_event.dart';
import 'package:authapp/blocs/auth/bloc_state.dart';
import 'package:authapp/blocs/blocs.dart';
import 'package:authapp/blocs/login/state.dart';
import 'package:authapp/data/repositories/repositories.dart';
import 'package:authapp/views/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();
  AuthRepository authRepository = AuthRepository();
  runApp(RepositoryProvider(
    create: (context) => AuthRepository(),
    child: BlocOverrides.runZoned(
        () => MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) =>
                        AuthBloc(authRepository: authRepository)
                          ..add(AppStarted())),
                BlocProvider(
                  create: (context) =>
                      LoginBloc(authRepository: authRepository),
                ),
              ],
              child: AuthApp(authRepository: authRepository),
            ),
        blocObserver: AppBlocObserver()),
  ));
}

class AuthApp extends StatefulWidget {
  final AuthRepository _authRepository;
  AuthApp({Key? key, required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  @override
  State<AuthApp> createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  AuthRepository get authRepository => widget._authRepository;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 740),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: '2F Capital',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Scaffold(
              body: Center(
                child: child,
              ),
            ),
          );
        },
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is Uninitialized) {
            return AuthScreen(); //splash screen
          } else if (state is Unauthenticated) {
            return AuthScreen();
          } else if (state is Authenticated) {
            return BottomNavBarScreen();
          } else {
            return AuthScreen();
          }
        }));
  }
}
