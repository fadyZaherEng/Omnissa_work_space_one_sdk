import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mofa/flavors.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/routes/routes_manager.dart';
import 'package:mofa/src/config/theme/app_theme.dart';
import 'package:mofa/src/core/utils/network_connectivity.dart';
import 'package:mofa/src/core/utils/show_no_internet_dialog_widget.dart';
import 'package:mofa/src/di/injector.dart';
import 'package:mofa/src/presentation/blocs/agreements/agreements_bloc.dart';
import 'package:mofa/src/presentation/blocs/challenges/challenges_bloc.dart';
import 'package:mofa/src/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:mofa/src/presentation/blocs/deliverables/delivrables_bloc.dart';
import 'package:mofa/src/presentation/blocs/home/home_bloc.dart';
import 'package:mofa/src/presentation/blocs/initiatives/initiatives_bloc.dart';
import 'package:mofa/src/presentation/blocs/initiatives_details/initiatives_details_bloc.dart';
import 'package:mofa/src/presentation/blocs/main/main_cubit.dart';
import 'package:mofa/src/presentation/blocs/milstones/milstones_bloc.dart';
import 'package:mofa/src/presentation/blocs/more/more_bloc.dart';
import 'package:mofa/src/presentation/blocs/pointers_tool/pointers_tool_bloc.dart';
import 'package:mofa/src/presentation/blocs/project/project_bloc.dart';
import 'package:mofa/src/presentation/blocs/project_details/project_details_bloc.dart';
import 'package:mofa/src/presentation/blocs/risks/risks_bloc.dart';
import 'package:mofa/src/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:mofa/src/presentation/blocs/strategy/strategy_bloc.dart';
import 'package:mofa/src/presentation/blocs/strategy_details/strategy_details_bloc.dart';
import 'package:mofa/src/presentation/blocs/tasks/tasks_bloc.dart';
import 'package:mofa/src/presentation/screens/splash/splash_screen.dart';
import 'package:mofa/src/presentation/widgets/restart_widget.dart';
import 'package:mofa/core/services/workspace_one_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await WorkspaceOneService.instance.initialize();
  String appVersion = (await PackageInfo.fromPlatform()).version;
  runApp(
    RestartWidget(
      MyApp(appVersionCode: appVersion),
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => MyApp(appVersionCode: appVersion),
      // ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String appVersionCode;

  const MyApp({
    super.key,
    required this.appVersionCode,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      NetworkConnectivity.instance.initializeInternetConnectivityStream();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _getProviders(),
      child: BlocBuilder<MainCubit, Locale>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (context, state) {
          return StreamBuilder(
            stream: NetworkConnectivity.instance.myStream,
            builder: (mContext, snapshot) {
              if (snapshot.hasData && !kIsWeb) {
                _connectToInternet(snapshot);
              }
              return MaterialApp(
                // useInheritedMediaQuery: true,
                // darkTheme: AppTheme(state.languageCode).light,
                navigatorKey: navigatorKey,
                navigatorObservers: [
                  ChuckerFlutter.navigatorObserver,
                  routeObserver,
                ],
                themeMode: ThemeMode.light,
                supportedLocales: S.delegate.supportedLocales,
                onGenerateRoute: RoutesManager.getRoute,
                initialRoute: Routes.splash,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                title: F.title,
                theme: AppTheme(state.languageCode).light,
                locale: state,
                // Pass versionCode when navigating to the splash screen
                builder: (context, child) {
                  return _buildInitialScreen(context, child);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInitialScreen(BuildContext context, Widget? child) {
    return Navigator(
      observers: [
        ChuckerFlutter.navigatorObserver,
        routeObserver,
      ],
      key: navigatorKey,
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (_) => SplashScreen(
            versionCode: widget.appVersionCode,
          ),
        );
      },
      initialRoute: Routes.splash,
      onGenerateInitialRoutes: (navigator, initialRoute) {
        return [
          MaterialPageRoute(
            builder: (_) => SplashScreen(
              versionCode: widget.appVersionCode,
            ),
          ),
        ];
      },
      onGenerateRoute: RoutesManager.getRoute,
    );
  }

  void _connectToInternet(snapshot) {
    ConnectivityResult connectivityResult = snapshot.data;

    if (connectivityResult == ConnectivityResult.none) {
      if (!NetworkConnectivity.instance.isShowNoInternetDialog) {
        showNoInternetDialogWidget(
          context: navigatorKey.currentContext ?? context,
          onTapTryAgain: () async {
            bool isOnline =
                await NetworkConnectivity.instance.isInternetConnected();

            if (isOnline) {
              // ✅ يوجد اتصال الآن، أغلق النافذة
              if (Navigator.canPop(navigatorKey.currentContext ?? context)) {
                Navigator.of(navigatorKey.currentContext ?? context).pop();
              }
              NetworkConnectivity.instance.isShowNoInternetDialog = false;
            } else {
              // ⛔️ لا يوجد اتصال بعد، يمكن عرض Toast أو إبقاء الـ Dialog
              // مثلاً:
              ScaffoldMessenger.of(navigatorKey.currentContext ?? context)
                  .showSnackBar(
                SnackBar(content: Text(S.of(context).noInternetConnection)),
              );
            }
          },
        );
      }

      NetworkConnectivity.instance.isShowNoInternetDialog = true;
    } else {
      if (NetworkConnectivity.instance.isShowNoInternetDialog &&
          Navigator.canPop(navigatorKey.currentContext ?? context)) {
        Navigator.of(navigatorKey.currentContext ?? context).pop();
        NetworkConnectivity.instance.isShowNoInternetDialog = false;
      }
    }
  }

  List<BlocProvider> _getProviders() {
    return [
      BlocProvider<MainCubit>(create: (context) => injector()),
      BlocProvider<SignInBloc>(create: (context) => injector()),
      BlocProvider<ProjectBloc>(create: (context) => injector()),
      BlocProvider<MoreBloc>(create: (context) => injector()),
      BlocProvider<HomeBloc>(create: (context) => injector()),
      BlocProvider<ProjectDetailsBloc>(create: (context) => injector()),
      BlocProvider<PointersToolBloc>(create: (context) => injector()),
      BlocProvider<TasksBloc>(create: (context) => injector()),
      BlocProvider<RisksBloc>(create: (context) => injector()),
      BlocProvider<ChallengesBloc>(create: (context) => injector()),
      BlocProvider<InitiativesBloc>(create: (context) => injector()),
      BlocProvider<StrategyBloc>(create: (context) => injector()),
      BlocProvider<StrategyDetailsBloc>(create: (context) => injector()),
      BlocProvider<InitiativesDetailsBloc>(create: (context) => injector()),
      BlocProvider<AgreementBloc>(create: (context) => injector()),
      BlocProvider<ChangePasswordBloc>(create: (context) => injector()),
      BlocProvider<DelivrablesBloc>(create: (context) => injector()),
      BlocProvider<MilstonesBloc>(create: (context) => injector()),
    ];
  }
}
