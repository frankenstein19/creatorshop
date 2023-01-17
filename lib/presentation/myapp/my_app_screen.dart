import 'package:creator_shop/domain/usecase/app_state_usecase.dart';
import 'package:creator_shop/domain/usecase/create_account_usecase.dart';
import 'package:creator_shop/presentation/create_account/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../di/di_config.dart';
import '../../domain/usecase/country_screen_usecase.dart';
import '../../domain/usecase/login_screen_usecase.dart';
import '../../utils/themes.dart';
import '../country/bloc/country_bloc.dart';
import '../country/country_screen.dart';
import '../create_account/bloc/create_account_bloc.dart';
import '../login/bloc/login_bloc.dart';
import '../login/login_screen.dart';
import 'bloc/app_state_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CountryBloc(getIt<CountryScreenUseCase>())),
        BlocProvider(create: (_) => LoginBloc(getIt<LoginScreenUseCase>())),
        BlocProvider(create: (_) => AppStateBloc(getIt<AppStateUseCase>())),
        BlocProvider(create: (_) => CreateAccountBloc(getIt<CreateAccountUseCase>())),
      ],
      child: Builder(builder: (context) {
        context.read<AppStateBloc>().add(ListenAuthStateEvent());
        return BlocListener<AppStateBloc, AppStateState>(
          listener: (context, state) {
            FlutterNativeSplash.remove();
            if (state is UserAvailableState) {
              Navigator.of(getIt<GlobalKey<NavigatorState>>().currentContext??context).pushNamedAndRemoveUntil(
                  CountryScreen.path, (Route<dynamic> route) => false);
            } else if (state is UserNotAvailableState) {
              Navigator.of(getIt<GlobalKey<NavigatorState>>().currentContext??context).pushNamedAndRemoveUntil(
                  LoginPage.path, (Route<dynamic> route) => false);
            }
          },
          child: MaterialApp(
            title: 'Flutter Demo',
            darkTheme: lightTheme,
            theme: lightTheme,
            navigatorKey: getIt<GlobalKey<NavigatorState>>(),
            routes: {
              CountryScreen.path: (_) => const CountryScreen(),
              LoginPage.path: (_) => const LoginPage(),
              CreateAccountScreen.path: (_)=> const CreateAccountScreen()
            },
          ),
        );
      }),
    );
  }
}
