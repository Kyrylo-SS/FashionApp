import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/environment.dart';
import 'package:testdf/src/addresses/hooks/results/address_list_results.dart';
import 'package:http/http.dart' as http;
import 'package:testdf/src/addresses/models/addresses_model.dart';

FetchAddresses fetchAddress() {
  final address = useState<List<AddressModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final accessToken = Storage().getString('accessToken');

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/address/addresslist');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        address.value = addressListFromJson(response.body);
      }
    } catch (e) {
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

  return FetchAddresses(
    addresses: address.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
