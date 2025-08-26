import 'package:flutter/material.dart';
import 'package:home_pause/core/constants/app_colors.dart';
import 'package:home_pause/core/constants/app_strings.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.house_rounded),
          label: AppStrings.homeTab,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.stars),
          label: AppStrings.scoreTab,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: AppStrings.profileTab,
        ),
      ],
    );
  }
}
