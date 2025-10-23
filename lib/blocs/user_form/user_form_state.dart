part of 'user_form_bloc.dart';

class UserFormState extends Equatable {
  final String? firstName;
  final String? lastName;
  final DateTime? birthDate;

  const UserFormState({
    this.firstName = '',
    this.lastName = '',
    this.birthDate
  });

  UserFormState copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate
  }) =>
  UserFormState(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    birthDate: birthDate ?? this.birthDate,
  );
  
  @override
  List<Object?> get props => [
    firstName,
    lastName,
    birthDate
  ];
}

final class UserFormInitial extends UserFormState {
  const UserFormInitial():super(
    firstName: '',
    lastName: '',
    birthDate: null
  );
}
