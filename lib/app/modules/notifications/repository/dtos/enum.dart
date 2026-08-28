enum NotificationType {
  health("health", "assets/notification/heart.svg"),
  club("club", "assets/notification/shop.svg"),
  check("check", "assets/notification/check.svg");

  final String type;
  final String path;

  const NotificationType(this.type, this.path);

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
      (e) => e.type == value,
      orElse: () => NotificationType.club,
    );
  }
}
