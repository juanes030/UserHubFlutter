part of 'address_bloc.dart';

class AddressState extends Equatable {
  final List<AddressModel>? addresses;

  const AddressState({
    this.addresses = const [],
  });

  AddressState copyWith({
    List<AddressModel>? addresses,
  }) {
    return AddressState(
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  List<Object?> get props => [addresses];
}

final class AddressInitial extends AddressState {
  const AddressInitial() : super(addresses: const []);
}
