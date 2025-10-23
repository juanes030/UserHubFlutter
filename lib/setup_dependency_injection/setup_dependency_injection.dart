import 'package:get_it/get_it.dart';
import 'package:user_hub_flutter/setup_dependency_injection/setup_dependency_injection_blocs.dart';

GetIt getIt = GetIt.instance;

void setUpDependencyInjection() {
  setUpDependencyInjectionBlocs(getIt);
}