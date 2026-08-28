import 'package:get/get.dart';

import '../modules/notifications/notifications_binding.dart';
import '../modules/notifications/notifications_page.dart';

class NotificationsRoutes {
  NotificationsRoutes._();

  static const notifications = '/notifications';

  static final routes = [
    GetPage(
      name: notifications,
      page: () => NotificationsPage(),
      binding: NotificationsBinding(),
    ),
  ];
}
