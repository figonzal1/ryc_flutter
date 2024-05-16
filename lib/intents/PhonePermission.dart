import 'package:android_intent_plus/android_intent.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

var logger = Logger();

Future<void> callIntent() async {
  if (!await isCallPermissionGranted()) {
    //Request permission
    await requestCallPermission();
  }

  const AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.CALL', data: 'tel:+5699999999');
  intent.launch();
}

Future<bool> isCallPermissionGranted() async {
  return await Permission.phone.isGranted;
}

Future<bool> requestCallPermission() async {
  var permissionStatus = await Permission.phone.request();
  if (permissionStatus == PermissionStatus.granted) {
    logger.d("Phone permission granted");
    return true;
  } else {
    logger.d("Phone permission denied");
    return false;
  }
}
