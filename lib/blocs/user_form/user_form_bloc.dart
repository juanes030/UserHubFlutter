import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_form_event.dart';
part 'user_form_state.dart';

class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  UserFormBloc() : super(UserFormInitial()) {
    on<SetFirstNameEvent>((event, emit) {
      emit(state.copyWith(firstName: event.firstName));
    });
    on<SetLastNameEvent>((event, emit) {
      emit(state.copyWith(lastName: event.lastName));
    });
    on<SetBirthDateEvent>((event, emit) {
      emit(state.copyWith(birthDate: event.birthDate));
    });
  }
}
