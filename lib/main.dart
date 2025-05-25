import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'firebase_options.dart';
import 'view_models/home_view_model.dart';
import 'repositories/service_repository.dart';
import 'services/firebase_service.dart';
import 'views/home_screen.dart';
import 'package:flutter/services.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<FirebaseService>(FirebaseService());
  getIt.registerSingleton<ServiceRepository>(
    ServiceRepository(getIt<FirebaseService>()),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupDependencies();
  await initializeSampleDataIfNeeded();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFFA90140), 
    ),
  );
  runApp(const MyApp());
}

Future<void> initializeSampleDataIfNeeded() async {
  try {
    final firebaseService = getIt<FirebaseService>();
    final services = await firebaseService.getServices();

    if (services.isEmpty) {
      print('Initializing sample data...');
      await firebaseService.initializeSampleData();
      print('Sample data initialized successfully!');
    } else {
      print('Sample data already exists, skipping');
    }
  } catch (e) {
    print('Error : $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(getIt<ServiceRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Music Production App',
        theme: ThemeData(
          primaryColor: Color(0xFFA90140),
          scaffoldBackgroundColor: const Color(0xFF18171C),
          fontFamily: 'Roboto',
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
