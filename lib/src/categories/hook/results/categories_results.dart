import 'package:flutter/material.dart';
import 'package:testdf/src/categories/models/categories_model.dart';

class FetchCategories {
  final List<Categories> categories;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCategories({
    required this.categories,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
