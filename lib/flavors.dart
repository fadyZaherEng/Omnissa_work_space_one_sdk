import 'package:mofa/src/data/sources/remote/api_key.dart';

enum Flavor {
  development,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return APIKeys.baseUrlDevelopment;
      case Flavor.production:
        return APIKeys.baseUrlProduction;
      default:
        return APIKeys.baseUrlProduction;
    }
  }

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Mofa';
      case Flavor.production:
        return 'Mofa';
      default:
        return 'Mofa';
    }
  }
}
