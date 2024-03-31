import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/login.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/detail.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/splash.dart';
import 'package:inkostel/pages/tes.dart';

void main() async {
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

  bool isAllowedToSendNotifications = await  AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotifications){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: const SplashScreen());
  }
}
