import 'package:get_it/get_it.dart';
import 'package:user_hub_flutter/blocs/address/address_bloc.dart';
import 'package:user_hub_flutter/blocs/user_form/user_form_bloc.dart';

void setUpDependencyInjectionBlocs(GetIt getIt) {
  getIt.registerSingleton<UserFormBloc>(UserFormBloc());
  getIt.registerSingleton<AddressBloc>(AddressBloc());
}