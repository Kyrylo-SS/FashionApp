import 'package:flutter/material.dart';
import 'package:testdf/src/addresses/models/addresses_model.dart';

class FetchAddresses {
  final List<AddressModel> addresses;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchAddresses({
    required this.addresses,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
