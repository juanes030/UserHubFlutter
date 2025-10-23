import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_hub_flutter/blocs/address/address_bloc.dart';
import 'package:user_hub_flutter/blocs/user_form/user_form_bloc.dart';
import 'package:user_hub_flutter/config/router/app_router.dart';
import 'package:user_hub_flutter/config/theme/app_theme.dart';
import 'package:user_hub_flutter/setup_dependency_injection/setup_dependency_injection.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setUpDependencyInjection();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => getIt<UserFormBloc>()),
        BlocProvider(create: (BuildContext context) => getIt<AddressBloc>()),
      ],
      child: MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      routerConfig: appRouter,
    );
  }
}
