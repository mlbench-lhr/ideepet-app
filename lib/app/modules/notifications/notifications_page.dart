import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idee_pet/app/app.dart';

class NotificationsPage extends BasePage<NotificationsController> {
  const NotificationsPage({super.key}) : super(showBottomNavigation: false);

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notificações', style: AppTextStyles.title(fontSize: 18).style),
          SizedBox(height: 18),
          Obx(
            () => GroupNotificationView(
              onTap: controller.readNotifications,
              loading: controller.isLoading.value,
              groupNotifications: controller.groupedNotifications(),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
