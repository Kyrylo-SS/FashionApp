import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/environment.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/error_modal.dart';
import 'package:testdf/src/auth/models/auth_token_model.dart';
import 'package:testdf/src/auth/models/profile_model.dart';
import 'package:testdf/src/entrypoint/controllers/bottom_tab_notifier.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool _isRLoading = false;

  bool get isRLoading => _isLoading;

  void setRLoading() {
    _isRLoading = !_isRLoading;
    notifyListeners();
  }

  void loginFunc(String data, BuildContext ctx) async {
    setLoading();

    try {
      var url = Uri.parse("${Environment.appBaseUrl}/auth/token/login");
      var response = await http.post(
        url,
        headers: {"Content-Type": 'application/json'},
        body: data,
      );

      if (response.statusCode == 200) {
        String accessToken = authTokenModelFromJson(response.body).authToken;
        Storage().setString('accessToken', accessToken);

        getUser(accessToken, ctx);
        setLoading();
      } else {
        setLoading();
        showErrorPopup(ctx, AppText.kErrorLogin, "Login Error", null);
      }
    } catch (e) {
      setLoading();
      showErrorPopup(ctx, AppText.kErrorLogin, "Login Error", null);
    }
  }

  void registrationFunc(String data, BuildContext ctx) async {
    setRLoading();

    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/users/');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: data,
      );

      if (response.statusCode == 201) {
        setRLoading();
        ctx.pop();
      } else if (response.statusCode == 400) {
        setRLoading();
        var data = jsonDecode(response.body);
        showErrorPopup(ctx, data['password'][0], null, null);
      }
    } catch (e) {
      setRLoading();
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  void getUser(String accessToken, BuildContext ctx) async {
    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/users/me');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        Storage().setString(accessToken, response.body);
        ctx.read<TabIndexNotifier>().setIndex(0);
        ctx.go('/home');
      }
    } catch (e) {
      setLoading();
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  ProfileModel? getUserData() {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken != null) {
      var data = Storage().getString(accessToken);
      if (data != null) {
        return profileModelFromJson(data);
      }
    }
  }
}
