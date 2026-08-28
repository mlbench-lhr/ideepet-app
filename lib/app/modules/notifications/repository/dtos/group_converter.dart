import 'package:idee_pet/app/app.dart';

List<GroupNotifications> groupByDate(
    List<GroupNotifications> groupedNotifications) {
  Map<DateTime, List<NotificationResponse>> groupedMap = {};

  // Itera sobre cada GroupNotifications e suas notificações
  for (var group in groupedNotifications) {
    for (var notification in group.notifications) {
      DateTime dateKey = DateTime(
        notification.date.year,
        notification.date.month,
        notification.date.day,
      );

      if (!groupedMap.containsKey(dateKey)) {
        groupedMap[dateKey] = [];
      }
      groupedMap[dateKey]!.add(notification);
    }
  }

  // Cria a lista agrupada, com a data mais recente primeiro
  List<GroupNotifications> groupedList = groupedMap.entries
      .map((entry) =>
          GroupNotifications(date: entry.key, notifications: entry.value))
      .toList()
    ..sort((a, b) => b.date.compareTo(
        a.date)); // Ordenação da data (mais recente para mais antiga)

  return groupedList;
}
