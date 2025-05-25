import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../repositories/service_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final ServiceRepository _serviceRepository;

  HomeViewModel(this._serviceRepository) {
    loadServices();
  }

  List<ServiceModel> _services = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<ServiceModel> get services => _services;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadServices() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _services = await _serviceRepository.getServices();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> refreshServices() async {
    await loadServices();
  }

  void onServiceTapped(ServiceModel service) {
    print('Service tapped: ${service.title}');
  }
}
