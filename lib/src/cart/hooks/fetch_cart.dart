import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/environment.dart';
import 'package:testdf/src/cart/hooks/results/cart_results.dart';
import 'package:http/http.dart' as http;
import 'package:testdf/src/cart/models/cart_model.dart';

FetchCart fetchCart() {
  final cart = useState<List<CartModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final accessToken = Storage().getString('accessToken');
  print(accessToken);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/me');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        cart.value = cartModelFromJson(response.body);
        print(cart.value);
      }
    } catch (e) {
      print(e.toString());
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    if (accessToken != null) {
      fetchData();
    }
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;

    fetchData();
  }

  return FetchCart(
    cart: cart.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
