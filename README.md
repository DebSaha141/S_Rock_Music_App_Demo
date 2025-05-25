# 🎵 S Rock Music App

This repository contains the UI design for the **Home Page** of the **S Rock Music App**, built as part of a design and development task for the S Rock team.

## 📸 Screenshots and Architecture

<div align="center">
  <img src="https://res.cloudinary.com/dzabseimd/image/upload/v1748200581/1000106457-portrait_yipefh.png" width="300" alt="Home Screen"/>
</div>


## 🎥 Demo Video

[![App Demo Video](https://res.cloudinary.com/dzabseimd/image/upload/v1748189226/23739728_sl_012120_27300_18_ngqdmt.jpg)](https://res.cloudinary.com/dzabseimd/video/upload/v1748200595/1000106458_opnayf.mp4)

*Click the image above to watch the demo video*

**Alternative video hosting options:**
- **Cloudinary Link:** [Demo Video](https://res.cloudinary.com/dzabseimd/video/upload/v1748200595/1000106458_opnayf.mp4)


## ✨ Features

- **Modern UI Design**: Beautiful gradient interface with custom service cards
- **Firebase Integration**: Real-time data fetching from Firestore database
- **Clean Architecture**: MVVM pattern with proper separation of concerns
- **Dependency Injection**: GetIt service locator for clean dependency management
- **State Management**: Provider pattern for reactive UI updates
- **Dynamic Navigation**: Seamless screen transitions and routing
- **Responsive Design**: Dynamic data-driven layout without hardcoded content
- **Flexible Image Loading**: Support for both network images (Cloudinary) and local assets
- **Error Handling**: Comprehensive error states and retry mechanisms
- **Loading States**: User-friendly loading indicators with progress tracking

## 📁 Project Structure

```
lib/
├── main.dart                    # Application entry point
├── models/                      # Data models and entities
│   └── service_model.dart      # Service data structure
├── repositories/                # Data access abstraction layer
│   └── service_repository.dart # Repository pattern implementation
├── view_models/                 # Business logic and state management
│   └── home_view_model.dart    # Home screen ViewModel
├── views/                       # UI screens and pages
│   ├── home_screen.dart        # Main home interface
│   └── service_detail_screen.dart # Service details page
├── widgets/                     # Reusable UI components
│   ├── service_card.dart       # Custom service card widget
│   └── custom_bottom_nav.dart  # Bottom navigation component
└── services/                    # External service integrations
    └── firebase_service.dart   # Firebase operations

assets/
├── images/                      # Application assets
└── fonts/                       # Custom typography
```

## 🏗️ Architecture

The application follows **MVVM (Model-View-ViewModel)** architecture pattern:

```dart
// ViewModel example - HomeViewModel
class HomeViewModel extends ChangeNotifier {
  final ServiceRepository _serviceRepository;
  
  List<ServiceModel> _services = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Getters for UI state
  List<ServiceModel> get services => _services;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadServices() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      _services = await _serviceRepository.getServices();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

## 🔥 Firebase Implementation

The app integrates with Firebase Firestore for:
- **Dynamic Content**: Service data stored in cloud database
- **Real-time Updates**: Automatic UI updates when data changes

### Key Firebase Features:
```dart
// Example service data structure
{
  "title": "Music Production",
  "description": "Custom Instrumentals & film scoring",
  "backgroundImage": "assets/images/image1.png", 
  "iconPath": "assets/images/music_icon.png",
  "order": 1
}
```

## 🔧 Technical Implementation

### Dependency Injection with GetIt
The app implements **Service Locator pattern** using GetIt for clean dependency management:

```dart
// Dependency setup in main.dart
final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<FirebaseService>(FirebaseService());
  getIt.registerSingleton<ServiceRepository>(
    ServiceRepository(getIt<FirebaseService>())
  );
}

// Usage in ViewModels
class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._serviceRepository); // Injected dependency
  
  final ServiceRepository _serviceRepository;
}
```


### Responsive Home Screen

The home page is **fully dynamic** and adapts seamlessly to different screen sizes using Flutter's `MediaQuery` for responsive design.


All UI elements automatically scale based on device dimensions:

```dart
final screenHeight = MediaQuery.of(context).size.height;
final screenWidth = MediaQuery.of(context).size.width;

// Header container takes 38% of screen height
Container(
  height: screenHeight * 0.38,
  width: screenWidth,
  // ...
)

// Typography scales with screen width
Text(
  'Free Demo',
  style: GoogleFonts.lobster(
    fontSize: screenWidth * 0.125, // 12.5% of screen width
    // ...
  ),
)

// Responsive padding
padding: EdgeInsets.symmetric(
  horizontal: screenWidth * 0.04,
  vertical: screenHeight * 0.012,
)
```

This ensures the app looks great on phones, tablets, and different orientations without any layout issues.

### Flexible Image Loading System
The app supports **multiple image sources** with intelligent fallback mechanisms:

```dart
// Flexible image loading in service_card.dart
Widget _buildServiceIcon() {
  if (service.iconPath.isNotEmpty) {
    if (service.iconPath.startsWith('http')) {
      // Network images (Cloudinary, CDN, etc.)
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          service.iconPath, // Supports Cloudinary URLs
          width: 24,
          height: 24,
          color: Colors.white,
          colorBlendMode: BlendMode.srcIn,
          errorBuilder: (context, error, stackTrace) {
            return _getFallbackIcon(service.title);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          },
        ),
      );
    } else if (service.iconPath.startsWith('assets/')) {
      // Local asset images
      return Image.asset(
        service.iconPath,
        width: 24,
        height: 24,
        color: Colors.white,
        errorBuilder: (context, error, stackTrace) {
          return _getFallbackIcon(service.title);
        },
      );
    }
  }
  
  // Fallback to icon-based display
  return _getFallbackIcon(service.title);
}
```

**Image System Features:**
- **Cloudinary Support**: Direct URL support for cloud-based images
- **Asset Images**: Local bundled images for offline reliability
- **Graceful Fallbacks**: Icon-based fallbacks when images fail to load
- **Loading States**: Progress indicators during network image loading
- **Error Handling**: Automatic fallback to alternative displays
- **Performance Optimization**: Proper image caching and memory management

### State Management with Provider
```dart
// Reactive UI updates
Consumer<HomeViewModel>(
  builder: (context, viewModel, child) {
    if (viewModel.isLoading) {
      return CircularProgressIndicator();
    }
    return ListView.builder(/* ... */);
  },
);
```

### Navigation System
```dart
// Screen navigation implementation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ServiceDetailScreen(
      serviceName: service.title,
    ),
  ),
);
```

### Asynchronous Data Handling
```dart
// Firebase data fetching with error handling
Future<List<ServiceModel>> getServices() async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('music_services')
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
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1          # State management
  firebase_core: ^3.13.1    # Firebase core functionality
  cloud_firestore: ^5.6.8   # Cloud Firestore database
  get_it: ^7.6.4            # Dependency injection
  cupertino_icons: ^1.0.8   # iOS style icons
  google_fonts: ^6.2.1      # Google Fonts
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Firebase project setup
- Android Studio or VS Code
- Git for version control

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter-music-production-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**
   - Create Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Enable Firestore Database
   - Add your app to Firebase project
   - Download configuration files:
     - `google-services.json` → `android/app/`
     - `GoogleService-Info.plist` → `ios/Runner/`

4. **Run the application**
   ```bash
   flutter run
   ```

---

<p align="center"><b>Made with ❤️ by Debmalya Saha</b></p>
