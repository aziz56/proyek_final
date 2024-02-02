//main.dart
import 'package:firebase_flutter/Services/authservices.dart';
import 'package:firebase_flutter/screens/auth.dart';
import 'package:firebase_flutter/screens/authstateless.dart';
import 'package:firebase_flutter/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const SplashScreen();
            // }

            if (snapshot.hasData) {
              return const ChatScreen();
            }

            return Auth();
          }),
    );
  }
}
