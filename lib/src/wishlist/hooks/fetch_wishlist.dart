import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/environment.dart';
import 'package:testdf/src/categories/hook/results/category_products_results.dart';
import 'package:http/http.dart' as http;
import 'package:testdf/src/products/models/products_model.dart';

FetchProduct fetchWishlist() {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/wishlist/me');
      String? accessToken = Storage().getString('accessToken');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        products.value = productsFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, []);

  void refetch() {
    isLoading.value = true;

    fetchData();
  }

  return FetchProduct(
    products: products.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
