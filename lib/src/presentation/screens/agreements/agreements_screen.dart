import 'package:flutter/material.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/presentation/screens/agreements/widgets/current/current_agreements_screen.dart';
import 'package:mofa/src/presentation/screens/agreements/widgets/previous/previous_agreements_screen.dart';
import 'package:mofa/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:mofa/src/presentation/widgets/custom_tap_bar_widget.dart';

class AgreementsScreen extends StatefulWidget {
  const AgreementsScreen({super.key});

  @override
  State<AgreementsScreen> createState() => _AgreementsScreenState();
}

class _AgreementsScreenState extends State<AgreementsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(
        context,
        title: S.of(context).agreements,
        isHaveBackButton: true,
        centredTitle: false,
        onBackButtonPressed: () => Navigator.pop(context),
      ),
      body: CurrentAgreementsScreen(),
      // CustomTabBarWidget(
      //   contentOfTapOne: const CurrentAgreementsScreen(),
      //   contentOfTapTwo: const PreviousAgreementsScreen(),
      //   titleOfTapOne: S.of(context).currents,
      //   titleOfTapTwo: S.of(context).previous,
      //   tabController: _tabController,
      // ),
    );
  }
}
