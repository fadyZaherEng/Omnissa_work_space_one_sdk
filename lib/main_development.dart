import 'package:chucker_flutter/chucker_flutter.dart';
import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  ChuckerFlutter.showNotification = false;
  ChuckerFlutter.showOnRelease = false;
  F.appFlavor = Flavor.development;
  runner.main();
}
