import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/providers/theme_provider.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/screens/register_screen.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/notes_screen.dart';
import 'package:note_app/screens/add_note_screen.dart';
import 'package:note_app/screens/favorites_screen.dart';
import 'package:note_app/screens/settings_screen.dart';
import 'package:note_app/screens/profile_screen.dart';
import 'package:note_app/screens/contact_us.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('Firebase başarıyla başlatıldı');
  } catch (e) {
    print('Firebase başlatma hatası: $e');
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Not Çepte',
      theme: Provider.of<ThemeProvider>(context, listen: true).currentTheme,
      initialRoute: '/',
      routes: {

        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/notes': (context) => const NotesScreen(),
        '/add_note': (context) => const AddNoteScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/contact': (context) => const ContactScreen(),


      },
    );
  }
}