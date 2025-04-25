import 'package:autoshine/models/service_model.dart';
import 'package:autoshine/services/carwash_services.dart';
import 'package:get/get.dart';

class UserServiceController extends GetxController {
  final _db = CarwashServices();

  var services = <ServiceModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }

  void fetchServices() async {
    try {
      isLoading.value = true;
      final data = await _db.getAllServices();
      services.assignAll(data);
    } catch (e) {
      print("Error fetching services: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
