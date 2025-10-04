import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:konta_app/app/navigation/app_routes.dart';
import 'package:konta_app/feature/accounts/ui/bottom_sheets/account_selector_bottom_sheet.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onItemTapped(int index) {
    if (index == 2) return;

    final realIndex = index < 2 ? index : index - 1;
    navigationShell.goBranch(
      realIndex,
      initialLocation: realIndex == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await context.push(AppRoutes.transactionsCreate),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1),
          BottomNavigationBar(
            currentIndex: navigationShell.currentIndex < 2
                ? navigationShell.currentIndex
                : navigationShell.currentIndex + 1,
            elevation: 0,
            selectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: 'home_label'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.bar_chart_outlined),
                label: 'reports_label'.tr,
              ),

              const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),

              BottomNavigationBarItem(
                icon: const Icon(Icons.notifications_outlined),
                label: 'reminder_label'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                label: 'profile_label'.tr,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
