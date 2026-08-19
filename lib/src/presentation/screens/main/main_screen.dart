import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mofa/generated/l10n.dart';
import 'package:mofa/src/config/theme/color_schemes.dart';
import 'package:mofa/src/core/base/widget/base_stateful_widget.dart';
import 'package:mofa/src/core/resources/image_paths.dart';
import 'package:mofa/src/presentation/screens/home/home_screen.dart';
import 'package:mofa/src/presentation/screens/more/more_screen.dart';
import 'package:mofa/src/presentation/screens/project/project_screen.dart';
import 'package:mofa/src/presentation/screens/tasks/tasks_screen.dart';
import 'package:mofa/core/services/secure_screen_wrapper.dart';
import 'package:mofa/core/services/workspace_one_security_mixin.dart';

class MainScreen extends BaseStatefulWidget {
  const MainScreen({super.key});

  @override
  BaseState<MainScreen> baseCreateState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen>
    with WorkspaceOneSecurityMixin {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const HomeScreen(),
    const ProjectsScreen(),
    // const TasksScreen(),
    // const PointersToolScreen(),
    const MoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    performSecurityChecks(); // فحص أمان WS1
  }

  @override
  Widget baseBuild(BuildContext context) {
    return SecureScreenWrapper(
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: ColorSchemes.primary,
          unselectedItemColor: ColorSchemes.gray,
          onTap: _onItemTapped,
          items: [
            _buildNavItem(ImagePaths.homeHouse, S.of(context).home),
            _buildNavItem(ImagePaths.project, S.of(context).projects),
            // _buildNavItem(ImagePaths.task, S.of(context).tasks),
            // _buildNavItem(ImagePaths.pointer, S.of(context).pointers),
            _buildNavItem(ImagePaths.more, S.of(context).more),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavItem(String asset, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        asset,
        width: 24,
        height: 24,
        color: ColorSchemes.gray,
      ),
      activeIcon: SvgPicture.asset(
        asset,
        width: 24,
        height: 24,
        color: ColorSchemes.primary,
      ),
      label: label,
    );
  }
}
