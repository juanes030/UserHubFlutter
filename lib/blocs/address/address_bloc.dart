import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_hub_flutter/models/address_model.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(const AddressInitial()) {
    on<SetAddressEvent>((event, emit) {
      final updatedAddresses = List<AddressModel>.from(state.addresses ?? []);
      updatedAddresses.add(event.address);
      emit(state.copyWith(addresses: updatedAddresses));
    });

    on<DeleteAddressEvent>((event, emit) {
      final updatedAddresses = List<AddressModel>.from(state.addresses ?? []);
      updatedAddresses.remove(event.address);
      emit(state.copyWith(addresses: updatedAddresses));
    });
  }
}
