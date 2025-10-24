part of 'address_bloc.dart';

sealed class AddressEvent {
  const AddressEvent();
}

class SetAddressEvent extends AddressEvent {
  final AddressModel address;
  const SetAddressEvent({required this.address});
}

class DeleteAddressEvent extends AddressEvent {
  final AddressModel address;
  const DeleteAddressEvent({required this.address});
}
