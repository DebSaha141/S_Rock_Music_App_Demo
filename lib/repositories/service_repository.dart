import '../models/service_model.dart';
import '../services/firebase_service.dart';

abstract class IServiceRepository {
  Future<List<ServiceModel>> getServices();
}

class ServiceRepository implements IServiceRepository {
  final FirebaseService _firebaseService;

  ServiceRepository(this._firebaseService);

  @override
  Future<List<ServiceModel>> getServices() async {
    return await _firebaseService.getServices();
  }
}
