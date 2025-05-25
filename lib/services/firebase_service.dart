import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'music_services';

  Future<List<ServiceModel>> getServices() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(_collection)
          .orderBy('order')
          .get();

      return querySnapshot.docs
          .map((doc) => ServiceModel.fromMap(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch services: $e');
    }
  }

  Future<void> addService(ServiceModel service) async {
    try {
      await _firestore.collection(_collection).add(service.toMap());
    } catch (e) {
      throw Exception('Failed to add service: $e');
    }
  }

  Future<void> initializeSampleData() async {
    final services = [
      ServiceModel(
        id: '',
        title: 'Music Production',
        description: 'Custom Instrumentals & film scoring',
        iconPath: 'assets/images/music_icon.png',
        backgroundImage: 'assets/images/image1.png',
        order: 1,
      ),
      ServiceModel(
        id: '',
        title: 'Mixing & Mastering',
        description: 'Make your tracks Radio-ready',
        iconPath: 'assets/images/mixing_icon.png',
        backgroundImage: 'assets/images/image2.png',
        order: 2,
      ),
      ServiceModel(
        id: '',
        title: 'Lyrics Writing',
        description: 'Turn feelings into lyrics',
        iconPath: 'assets/images/lyrics_icon.png',
        backgroundImage: 'assets/images/image3.png',
        order: 3,
      ),
      ServiceModel(
        id: '',
        title: 'Vocals',
        description: 'Vocals that bring your lyrics to life',
        iconPath: 'assets/images/vocals_icon.png',
        backgroundImage: 'assets/images/image4.png',
        order: 4,
      ),
    ];

    for (var service in services) {
      await addService(service);
    }
  }
}