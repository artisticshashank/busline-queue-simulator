import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/queue_provider.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load connection strings
  try {
    await dotenv.load(fileName: "assets/env");
  } catch (e) {
    debugPrint("No env file found or error loading it: $e");
  }

  // Initialize Supabase
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl != null &&
      supabaseKey != null &&
      supabaseUrl != 'YOUR_SUPABASE_URL' &&
      supabaseUrl.isNotEmpty) {
    try {
      await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
      debugPrint("Supabase initialized successfully.");
    } catch (e) {
      debugPrint("Error initializing Supabase: $e");
    }
  } else {
    debugPrint(
      "Supabase credentials missing. App will run in offline/demo mode (backend features may fail).",
    );
  }

  runApp(const BusLineApp());
}

class BusLineApp extends StatelessWidget {
  const BusLineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => QueueProvider())],
      child: MaterialApp(
        title: 'BusLine',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3:
              false, // Disabled to avoid ink_sparkle.frag shader issues
          fontFamily:
              'Roboto', // Default, but can update if Google Fonts needed
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
