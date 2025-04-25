import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/environment.dart';

class WishlistNotifier with ChangeNotifier {
  List<int> _wishlist = [];
  String? error;

  List<int> get wishlist => _wishlist;

  void _saveToStorage() {
    final String? accessToken = Storage().getString('accessToken');
    if (accessToken != null) {
      Storage().setString('${accessToken}wishlist', jsonEncode(_wishlist));
    }
  }

  void _toggleItem(int id) {
    if (_wishlist.contains(id)) {
      _wishlist.remove(id);
    } else {
      _wishlist.add(id);
    }

    _saveToStorage();
    notifyListeners();
  }

  /// Добавить или удалить из избранного
  Future<void> addRemoveWishlist(int id, Function refetch) async {
    final String? accessToken = Storage().getString('accessToken');
    final String? rawData = Storage().getString('${accessToken}wishlist');

    try {
      if (rawData != null) {
        final decoded = jsonDecode(rawData);
        if (decoded is List) {
          _wishlist = List<int>.from(decoded);
        }
      }
    } catch (e) {
      error = 'Ошибка при загрузке wishlist: $e';
    }

    try {
      final Uri url = Uri.parse(
        '${Environment.appBaseUrl}/api/wishlist/toggle/?id=$id',
      );
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201 || response.statusCode == 204) {
        _toggleItem(id);
        refetch(); // внешний коллбэк
      }
    } catch (e) {
      error = 'Ошибка при обновлении wishlist: $e';
      notifyListeners();
    }
  }
}
