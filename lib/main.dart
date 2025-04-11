import 'package:datasharing/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC6MAKhTnEjEZGQTUxSCOvaH2HKKymAloo",
      authDomain: "datasharing-3a3a7.firebaseapp.com",
      projectId: "datasharing-3a3a7",
      storageBucket: "datasharing-3a3a7.firebasestorage.app",
      messagingSenderId: "248320214190",
      appId: "1:248320214190:web:fb125ffed0f8084b80993f",
      measurementId: "G-1541QKC307",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Web',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
