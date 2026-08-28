import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idee_pet/app/modules/notifications/repository/dtos/enum.dart';
import 'package:idee_pet/app/modules/notifications/repository/dtos/notification.entity.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';

class NotificationView extends StatelessWidget {
  final Function(NotificationResponse notifications) onTap;
  final List<NotificationResponse> notifications;
  const NotificationView({
    super.key,
    required this.onTap,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        final notification = notifications[index];
        return ListTile(
          onTap: () => onTap(notification),
          leading: Card(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                notifications[index].isRead
                    ? NotificationType.check.path
                    : notifications[index].type.path,
                // width: width,
                // height: height,
              ),
            ),
          ),
          title: Text(
            notifications[index].title,
            style: AppTextStyles.poppinsLight(fontSize: 12).style,
            overflow: TextOverflow.visible,
          ),
        );
      },
    );
  }
}
