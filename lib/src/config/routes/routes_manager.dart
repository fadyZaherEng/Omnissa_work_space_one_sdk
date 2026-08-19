import 'package:flutter/material.dart';
import 'package:mofa/src/domain/entities/home/project.dart';
import 'package:mofa/src/domain/entities/home/stratgy.dart';
import 'package:mofa/src/presentation/screens/agreements/agreements_screen.dart';
import 'package:mofa/src/presentation/screens/challenges/challenges_screen.dart';
import 'package:mofa/src/presentation/screens/change_language/change_language_screen.dart';
import 'package:mofa/src/presentation/screens/change_password/change_password_screen.dart';
import 'package:mofa/src/presentation/screens/deliverables/delivrables_screen.dart';
import 'package:mofa/src/presentation/screens/initiatives/initiatives_screen.dart';
import 'package:mofa/src/presentation/screens/initiatives_detaills/initiatives_details_screen.dart';
import 'package:mofa/src/presentation/screens/pointers_tool/pointers_tool_screen.dart';
import 'package:mofa/src/presentation/screens/project/project_screen.dart';
import 'package:mofa/src/presentation/screens/project_detaills/project_details_screen.dart';
import 'package:mofa/src/presentation/screens/project_milstons/milstones_screen.dart';
import 'package:mofa/src/presentation/screens/risks/risks_screen.dart';
import 'package:mofa/src/presentation/screens/settings/settings_screen.dart';
import 'package:mofa/src/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:mofa/src/presentation/screens/main/main_screen.dart';
import 'package:mofa/src/presentation/screens/splash/splash_screen.dart';
import 'package:mofa/src/presentation/screens/strategy/strategy_screen.dart';
import 'package:mofa/src/presentation/screens/strategy_detaills/strategy_details_screen.dart';
import 'package:mofa/src/presentation/screens/tasks/tasks_screen.dart';

class Routes {
  static const String splash = "/";
  static const String main = "/main";
  static const String signIn = "/signIn";
  static const String projectDetails = "/projectDetails";
  static const String strategyDetails = "/strategyDetails";
  static const String initiativesDetails = "/InitiativesDetails";
  static const String tasksScreen = "/tasksScreen";
  static const String pointersScreen = "/pointersScreen";
  static const String projectsScreen = "/projectsScreen";
  static const String risksScreen = "/risksScreen";
  static const String challengesScreen = "/challengesScreen";
  static const String initiativesScreen = "/initiativesScreen";
  static const String strategyScreen = "/strategyScreen";
  static const String agreementsScreen = "/agreementsScreen";
  static const String settingsScreen = "/settingsScreen";
  static const String changePasswordScreen = "/changePasswordScreen";
  static const String changeLanguageScreen = "/changeLanguageScreen";
  static const String deliverablesScreen = "/deliverablesScreen";
  static const String milstonesScreen = "/milstonesScreen";
}

class RoutesManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.main:
        return _materialRoute(const MainScreen());
      case Routes.signIn:
        return _materialRoute(const SignInScreen());
      case Routes.strategyScreen:
        return _materialRoute(const StrategyScreen());
      case Routes.projectDetails:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          ProjectDetailsScreen(
            projectId: arguments['projectId'] as String,
          ),
        );
      case Routes.strategyDetails:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          StrategyDetailsScreen(
            strategy: arguments['strategy'] as Strategy,
          ),
        );
      case Routes.initiativesDetails:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(
          InitiativesDetailsScreen(
            initiatives: arguments['initiatives'] as Project,
          ),
        );
      case Routes.tasksScreen:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(TasksScreen(
          isShowBackButton: arguments['isShowBackButton'] as bool,
        ));
      case Routes.pointersScreen:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(PointersToolScreen(
          isShowBackButton: arguments['isShowBackButton'] as bool,
        ));
      case Routes.projectsScreen:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(ProjectsScreen(
          isShowBackButton: arguments['isShowBackButton'] as bool,
        ));
      case Routes.risksScreen:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(RisksScreen(
          isShowBackButton: arguments['isShowBackButton'] as bool,
        ));
      case Routes.challengesScreen:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(ChallengesScreen(
          isShowBackButton: arguments['isShowBackButton'] as bool,
        ));
      case Routes.initiativesScreen:
        return _materialRoute(const InitiativesScreen());
      case Routes.settingsScreen:
        return _materialRoute(const SettingsScreen());
      case Routes.agreementsScreen:
        return _materialRoute(const AgreementsScreen());
      case Routes.splash:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(SplashScreen(
          versionCode: arguments['versionCode'] as String? ?? "",
        ));
      case Routes.changePasswordScreen:
        return _materialRoute(const ChangePasswordScreen());
      case Routes.changeLanguageScreen:
        return _materialRoute(const ChangeLanguageScreen());
      case Routes.deliverablesScreen:
        return _materialRoute(const DeliverablesScreen());
      case Routes.milstonesScreen:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(MilstonesScreen(
          isShowBackButton: arguments['isShowBackButton'] as bool,
        ));
      default:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return _materialRoute(SplashScreen(
          versionCode: arguments['versionCode'] as String? ?? "",
        ));
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> unDefinedRoute(String name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Not found")),
        body: Center(
          child: Text(name),
        ),
      ),
    );
  }
}
