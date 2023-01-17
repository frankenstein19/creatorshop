import 'package:creator_shop/data/model/user_model.dart';
import 'package:creator_shop/domain/usecase/app_state_usecase.dart';
import 'package:creator_shop/domain/usecase/create_account_usecase.dart';
import 'package:creator_shop/presentation/create_account/create_account_screen.dart';
import 'package:creator_shop/presentation/dasboard/dashboard_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../di/di_config.dart';
import '../../domain/usecase/login_screen_usecase.dart';
import '../../main.dart';
import '../../utils/themes.dart';
import '../create_account/bloc/create_account_bloc.dart';
import '../login/bloc/login_bloc.dart';
import '../login/login_screen.dart';
import 'bloc/app_state_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of your application.
  /// //
  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    getToken();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(getIt<LoginScreenUseCase>())),
        BlocProvider(create: (_) => AppStateBloc(getIt<AppStateUseCase>())),
        BlocProvider(
            create: (_) => CreateAccountBloc(getIt<CreateAccountUseCase>())),
      ],
      child: Builder(builder: (context) {
        context.read<AppStateBloc>().add(ListenAuthStateEvent());
        return BlocListener<AppStateBloc, AppStateState>(
          listener: (context, state) {
            FlutterNativeSplash.remove();
            if (state is UserAvailableState) {
              getIt.registerFactory<UserModel>(() => state.user);
              Navigator.of(getIt<GlobalKey<NavigatorState>>().currentContext ??
                      context)
                  .pushNamedAndRemoveUntil(
                      DashboardScreen.path, (Route<dynamic> route) => false);
            } else if (state is UserNotAvailableState) {
              getIt.unregister<UserModel>();
              Navigator.of(getIt<GlobalKey<NavigatorState>>().currentContext ??
                      context)
                  .pushNamedAndRemoveUntil(
                      LoginPage.path, (Route<dynamic> route) => false);
            }
          },
          child: MaterialApp(
            title: 'Flutter Demo',
            darkTheme: lightTheme,
            theme: lightTheme,
            navigatorKey: getIt<GlobalKey<NavigatorState>>(),
            routes: {
              DashboardScreen.path: (_) => const DashboardScreen(),
              LoginPage.path: (_) => const LoginPage(),
              CreateAccountScreen.path: (_) => const CreateAccountScreen()
            },
          ),
        );
      }),
    );
  }

  Future<void> getToken() async {
   final token= await FirebaseMessaging.instance.getToken();
   debugPrint("token: $token");
  }
}
