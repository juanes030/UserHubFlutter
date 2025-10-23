import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<SetAddressEvent>((event, emit) {
      final updatedAddresses = List<String>.from(state.addresses ?? []);
      updatedAddresses.add(event.address);
      emit(state.copyWith(addresses: updatedAddresses));
    });

    on<DeleteAddressEvent>((event, emit) {
      final updatedAddresses = List<String>.from(state.addresses ?? []);
      updatedAddresses.remove(event.address);
      emit(state.copyWith(addresses: updatedAddresses));
    });
  }
}
