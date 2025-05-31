import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:testdf/common/models/api_error_model.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/environment.dart';
import 'package:testdf/common/widgets/error_modal.dart';
import 'package:testdf/src/addresses/models/addresses_model.dart';
import 'package:testdf/src/addresses/views/add_address.dart';

class AddressNotifier with ChangeNotifier {
  Function refetchA = () {};

  void setRefetch(Function r) {
    refetchA = r;
  }

  AddressModel? address;

  void setAddress(AddressModel a) {
    address = a;
    notifyListeners();
  }

  void clearAddress() {
    address = null;
    notifyListeners();
  }

  List<String> addressTypes = ['Home', 'School', 'Office'];

  String _addressType = '';

  void setAddressType(String type) {
    _addressType = type;
    notifyListeners();
  }

  String get addressType => _addressType;

  void clearAddressType() {
    _addressType = '';
  }

  bool _defaultToogle = false;

  void setDefault(bool d) {
    _defaultToogle = d;
    notifyListeners();
  }

  bool get defautlToogle => _defaultToogle;

  void clearDefautl() {
    _defaultToogle = false;
  }

  void setAsDefault(BuildContext context, int id, Function refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
        "${Environment.appBaseUrl}/api/address/default/?id=$id",
      );

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, "Error changing address", true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteAddress(BuildContext context, int id, Function refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
        "${Environment.appBaseUrl}/api/address/delete/?id=$id",
      );

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, "Error deleting address", true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addAddress(BuildContext context, String data) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse("${Environment.appBaseUrl}/api/address/add/");

      final response = await http.post(
        url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 201) {
        refetchA();
        context.pop();
      }
    } catch (e) {
      debugPrint(e.toString());
      showErrorPopup(context, e.toString(), "Error adding address", true);
    }
  }
}
