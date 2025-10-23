part of 'user_form_bloc.dart';

sealed class UserFormEvent{
  const UserFormEvent();
}

class SetFirstNameEvent extends UserFormEvent{
  final String firstName;
  SetFirstNameEvent({required this.firstName});
}

class SetLastNameEvent extends UserFormEvent{
  final String lastName;
  SetLastNameEvent({required this.lastName});
}

class SetBirthDateEvent extends UserFormEvent{
  final DateTime birthDate;
  SetBirthDateEvent({required this.birthDate});
}
