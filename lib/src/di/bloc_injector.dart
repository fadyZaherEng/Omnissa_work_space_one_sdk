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

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<MainCubit>(
    () => MainCubit(
      injector(),
      injector(),
    ),
  );
  injector.registerFactory<SignInBloc>(
    () => SignInBloc(
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
    ),
  );
  injector.registerFactory<ProjectBloc>(() => ProjectBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<MoreBloc>(() => MoreBloc(
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<HomeBloc>(() => HomeBloc(
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<ProjectDetailsBloc>(() => ProjectDetailsBloc(
        injector(),
        injector(),
      ));
  injector.registerFactory<PointersToolBloc>(() => PointersToolBloc(
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<TasksBloc>(() => TasksBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<RisksBloc>(() => RisksBloc(
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<ChallengesBloc>(() => ChallengesBloc(
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<InitiativesBloc>(() => InitiativesBloc(
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<StrategyBloc>(() => StrategyBloc(
        injector(),
        injector(),
        injector(),
      ));

  injector.registerFactory<StrategyDetailsBloc>(() => StrategyDetailsBloc(
        injector(),
      ));
  injector.registerFactory<InitiativesDetailsBloc>(
    () => InitiativesDetailsBloc(),
  );
  injector.registerFactory<AgreementBloc>(() => AgreementBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<ChangePasswordBloc>(
      () => ChangePasswordBloc(injector()));
  injector.registerFactory<MilstonesBloc>(() => MilstonesBloc(
        injector(),
        injector(),
        injector(),
        injector(),
        injector(),
      ));
  injector.registerFactory<DelivrablesBloc>(() => DelivrablesBloc(
        injector(),
        injector(),
        injector(),
        injector(),
      ));
}
