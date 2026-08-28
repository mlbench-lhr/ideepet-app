import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(Permission permission) async {
  final status = await permission.request();

  if (status == PermissionStatus.granted) {
    return true;
  } else if (status == PermissionStatus.denied) {
    return false;
  } else if (status == PermissionStatus.permanentlyDenied) {
    openAppSettings();
    return false;
  }
  return false;
}
