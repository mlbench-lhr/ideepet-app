import 'package:flutter/material.dart';
import 'package:idee_pet/app/modules/notifications/notifications.dart';
import 'package:idee_pet/app/core/core_old/colors.dart';
import 'package:idee_pet/app/core/core_old/widgets/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GroupNotificationView extends StatelessWidget {
  final bool loading;
  final List<GroupNotifications> groupNotifications;
  final Function(NotificationResponse notification) onTap;
  const GroupNotificationView({
    super.key,
    required this.loading,
    required this.groupNotifications,
    required this.onTap,
    //required this.read,
  });

  @override
  Widget build(BuildContext context) {
    return groupNotifications.isEmpty && !loading
        ? Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 48,
                    color: const Color.fromRGBO(158, 158, 158, 1),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nenhuma notificação disponível',
                    style: AppTextStyles.poppinsMedium(fontSize: 14).style,
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: loading ? 4 : groupNotifications.length,
            itemBuilder: (BuildContext context, int index) {
              if (loading) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeletonizer(
                        child: Container(
                            width: 100, height: 14, color: Colors.grey[300])),
                    Card(
                      color: AppColors.background,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Skeletonizer(
                          child: Column(
                            children: List.generate(
                                2,
                                (_) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Container(
                                          width: double.infinity,
                                          height: 14,
                                          color: Colors.grey[300]),
                                    )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }

              DateTime today = DateTime.now();
              DateTime groupDate = groupNotifications[index].date;

              bool isToday = groupDate.year == today.year &&
                  groupDate.month == today.month &&
                  groupDate.day == today.day;

              String formattedDate =
                  DateFormat("dd 'de' MMMM", 'pt_BR').format(groupDate);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isToday ? 'Hoje' : formattedDate,
                      style: AppTextStyles.poppinsMedium(fontSize: 14).style),
                  Card(
                    color:
                        isToday ? AppColors.background : AppColors.buttonColor,
                    child: NotificationView(
                        onTap: onTap,
                        notifications: groupNotifications[index].notifications),
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          );
  }
}
