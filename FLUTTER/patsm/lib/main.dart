import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:patsm/app_cubit.dart';
import 'package:patsm/app_state.dart';
import 'package:patsm/features/auth/login/login_bloc.dart';
import 'package:patsm/features/auth/login/login_ui.dart';
import 'package:patsm/features/auth/signup/signup_bloc.dart';
import 'package:patsm/features/auth/signup/signup_ui.dart';
import 'package:patsm/features/history/history_bloc.dart';
import 'package:patsm/features/history/history_ui.dart';
import 'package:patsm/features/home/cannot_score/cannot_score_ui.dart';
import 'package:patsm/features/home/homepage/homepage_bloc.dart';
import 'package:patsm/features/home/homepage/homepage_ui.dart';
import 'package:patsm/features/home/update_score/update_score_bloc.dart';
import 'package:patsm/features/home/update_score/update_score_ui.dart';
import 'package:patsm/features/home/user_found/user_found_bloc.dart';
import 'package:patsm/features/home/user_found/user_found_ui.dart';
import 'package:patsm/features/home/user_not_found/user_not_found_ui.dart';
import 'package:patsm/features/home/view_score/view_score_ui.dart';
import 'package:patsm/go_router_refresh_stream.dart';
import 'package:patsm/repos/auth_repo.dart';
import 'package:patsm/repos/history_repo.dart';
import 'package:patsm/repos/home_repo.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB6SJ0chK2z99ng0_pgsuqESR8S0pCX-DU",
        appId: "1:106442186316:web:dd7c4cf40dc5313d145ee9",
        messagingSenderId: "106442186316",
        projectId: "patsm-76602",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    RepositoryProvider(
      create: (BuildContext context) => AuthRepo(),
      child: BlocProvider(
        create: (BuildContext context) =>
            AppCubit(authRepo: context.read<AuthRepo>()),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xff5A429E),
        ),
        scaffoldBackgroundColor: const Color(0xff9384BD),
      ),
      title: 'PATSM',
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }

  late final _router = GoRouter(
    initialLocation: '/update_score',
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) {
          return BlocProvider(
            create: (BuildContext context) => LoginBloc(
              authRepo: context.read<AuthRepo>(),
              appCubit: context.read<AppCubit>(),
            ),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        name: 'signup',
        path: '/signup',
        builder: (context, state) {
          return BlocProvider(
            create: (BuildContext context) => SignupBloc(
              authRepo: context.read<AuthRepo>(),
              appCubit: context.read<AppCubit>(),
            ),
            child: const SignupPage(),
          );
        },
      ),
      GoRoute(
        name: 'homepage',
        path: '/',
        builder: (context, state) {
          return RepositoryProvider(
            create: (BuildContext context) => HomeRepo(),
            child: BlocProvider(
              create: (BuildContext context) => HomePageBloc(
                homeRepo: context.read<HomeRepo>(),
                appCubit: context.read<AppCubit>(),
              ),
              child: const HomePage(),
            ),
          );
        },
        routes: [
          GoRoute(
            name: 'user_404',
            path: 'user_404',
            builder: (context, state) {
              return const UserNotFoundPage();
            },
          ),
          GoRoute(
            name: 'cannot_score',
            path: 'cannot_score',
            builder: (context, state) {
              return const CannotScorePage();
            },
          ),
          GoRoute(
            name: 'user',
            path: 'user/:username',
            builder: (context, state) {
              return RepositoryProvider(
                create: (BuildContext context) => HomeRepo(),
                child: BlocProvider(
                  create: (BuildContext context) => UserFoundBloc(
                    homeRepo: context.read<HomeRepo>(),
                    appCubit: context.read<AppCubit>(),
                    username: state.params['username']!,
                  ),
                  child: const UserFoundPage(),
                ),
              );
            },
          ),
          GoRoute(
            name: 'view_score',
            path: 'view_score',
            builder: (context, state) {
              return ViewScorePage(
                data:
                    (context.read<AppCubit>().state as ViewScoreAppState).data,
                max: (context.read<AppCubit>().state as ViewScoreAppState).max,
                id: (context.read<AppCubit>().state as ViewScoreAppState).id,
              );
            },
          ),
          GoRoute(
            name: 'update_score',
            path: 'update_score',
            builder: (context, state) {
              return RepositoryProvider(
                create: (BuildContext context) => HomeRepo(),
                child: BlocProvider(
                  create: (BuildContext context) => UpdateScoreBloc(
                    homeRepo: context.read<HomeRepo>(),
                    appCubit: context.read<AppCubit>(),
                    id: (context.read<AppCubit>().state as UpdateScoreAppState).id,
                    score: (context.read<AppCubit>().state as UpdateScoreAppState).score,
                  ),
                  child: const UpdateScorePage(),
                ),
              );
            },
          ),
        ],
      ),
      //---
      GoRoute(
        name: 'history',
        path: '/history',
        builder: (context, state) {
          return RepositoryProvider(
            create: (BuildContext context) => HistoryRepo(),
            child: BlocProvider(
              create: (BuildContext context) => HistoryBloc(
                historyRepo: context.read<HistoryRepo>(),
                appCubit: context.read<AppCubit>(),
              ),
              child: const HistoryPage(),
            ),
          );
        },
      ),
    ],
    redirect: (context, state) {
      log(context.read<AppCubit>().state.toString());

      ///------------- AUTH
      if (context.read<AppCubit>().state is LoginAppState &&
          state.location != '/login') {
        return '/login';
      }
      if (context.read<AppCubit>().state is SignupAppState &&
          state.location != '/signup') {
        return '/signup';
      }

      /// ------------------------------------

      ///------------- HOME
      if (context.read<AppCubit>().state is HomePageAppState &&
          state.location != '/') {
        return '/';
      }
      if (context.read<AppCubit>().state is UserNotFoundAppState &&
          state.location != '/user_404') {
        return '/user_404';
      }
      if (context.read<AppCubit>().state is UserFoundAppState &&
          !state.location.contains('/user/')) {
        return '/user/${(context.read<AppCubit>().state as UserFoundAppState).username}';
      }
      if (context.read<AppCubit>().state is CannotScoreAppState &&
          !state.location.contains('/cannot_score')) {
        return '/cannot_score';
      }
      if (context.read<AppCubit>().state is ViewScoreAppState &&
          !state.location.contains('/view_score')) {
        return '/view_score';
      }
      if (context.read<AppCubit>().state is UpdateScoreAppState &&
          !state.location.contains('/update_score')) {
        return '/update_score';
      }
      /// ------------------------------------

      ///------------- HISTORY
      if (context.read<AppCubit>().state is HistoryAppState &&
          state.location != '/history') {
        return '/history';
      }
      /// ------------------------------------

      return null;
    },
    refreshListenable: GoRouterRefreshStream(context.read<AppCubit>().stream),
  );
}
