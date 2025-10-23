import 'package:go_router/go_router.dart';
import 'package:user_hub_flutter/presentation/screens/address_screen.dart';
import 'package:user_hub_flutter/presentation/screens/home_screen.dart';
import 'package:user_hub_flutter/presentation/screens/summary_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/addressScreen',
      builder: (context, state) => AddressScreen(),
    ),
    GoRoute(
      path: '/summaryScreen',
      builder: (context, state) => SummaryScreen(),
    ),
  ] 
);