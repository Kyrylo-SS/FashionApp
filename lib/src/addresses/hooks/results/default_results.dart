import 'package:flutter/material.dart';
import 'package:testdf/src/addresses/models/addresses_model.dart';

class FetchDefaultAddress {
  final AddressModel? address;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchDefaultAddress({
    required this.address,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
