import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreateMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDissmissActionReceivedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedNotification receivedNotification) async {}
}