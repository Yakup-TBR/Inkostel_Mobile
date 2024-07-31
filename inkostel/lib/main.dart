import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/splash.dart';

import 'firebase_options.dart';

void main() async {
  // Inisiasi database
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Notifikasi Simpan
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: "grup_notifikasi",
        channelKey: "notif_simpan",
        channelName: "Notifikasi Simpan",
        channelDescription: "Test Notifikasi Simpan"),
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "grup_notifikasi", channelGroupName: "Grup Notifikasi")
  ]);

  bool isAllowedToSendNotifications =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotifications) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  // ignore: use_super_parameters
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //Ganti GetMaterialApp buat Run Login soalnya pakai Get.to
    //Kalo mau balikin lagi tinggal ganti ke MaterialApp
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: AuthChecker());
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return Home();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
