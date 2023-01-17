
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';


import 'di/di_config.dart';
import 'presentation/myapp/my_app_screen.dart';

/// App start with here

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// This will initialize firebase after that we can use firebase any where.
  await Firebase.initializeApp();
  configureDependencies(Env.development);
  initGlobal();
  runApp(const MyApp());
}

void initGlobal(){
  GetIt.instance.registerSingleton<GlobalKey<NavigatorState>>(GlobalKey<NavigatorState>());
}


