part of 'address_bloc.dart';

sealed class AddressEvent {
  const AddressEvent();
}

class SetAddressEvent extends AddressEvent{
  final String address;
  SetAddressEvent({required this.address});
}

class DeleteAddressEvent extends AddressEvent{
  final String address;
  DeleteAddressEvent({required this.address});
}