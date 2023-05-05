import 'package:authapp/blocs/auth/auth_bloc.dart';
import 'package:authapp/blocs/login/bloc.dart';
import 'package:authapp/data/repositories/repositories.dart';
import 'package:authapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/all_models.dart';

final gt = GetIt.instance;
Future<void> init() async {
  // final firebInit = await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // gt.registerFactory(
  //   () => firebInit,
  // );
  gt.registerFactory(() => AuthBloc(
        authRepository: gt(),
      ));
  gt.registerFactory(() => LoginBloc(authRepository: gt()));
//data
  gt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(firebaseAuth: FirebaseAuth.instance));

  //model
  gt.registerLazySingleton<UserModel>(() => UserModel(
      firstName: gt(),
      lastName: gt(),
      email: gt(),
      password: gt(),
      phone: gt()));
//external
  final sharedPreferences = await SharedPreferences.getInstance();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  gt.registerLazySingleton(() => sharedPreferences);
  gt.registerLazySingleton(() => firebaseAuth);
}
