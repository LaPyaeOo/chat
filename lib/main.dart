import 'package:chat/presentation/page/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'data/firebase_options.dart';
import 'presentation/page/Messaging_page.dart';
import 'presentation/page/login_page.dart';
import 'presentation/page/main_page.dart';
import 'presentation/page/signup_page.dart';
import 'presentation/page/initial_page.dart';
import 'presentation/page/splash_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatterApp());
}

class ChatterApp extends StatelessWidget {
  const ChatterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat',

      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      // home: ChatterHome(),
      initialRoute: '/',
      routes: {
        '/':(context)=> const SplashPage(),
        '/initialPage': (context) => const InitialPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => SignupPage(),
        '/mainPage': (context)=> const MainPage(),
        '/messagingPage': (context) => const MessagingPage(),
        '/chat':(context)=>ChatPage()
      },
    );
  }
}
