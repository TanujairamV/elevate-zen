import 'package:flutter/material.dart';

class DoctorNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const DoctorNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const items = [
    (
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view_rounded,
      label: 'Home',
    ),
    (
      icon: Icons.qr_code_scanner_outlined,
      selectedIcon: Icons.qr_code_scanner_rounded,
      label: 'Scan',
    ),
    (
      icon: Icons.groups_outlined,
      selectedIcon: Icons.groups_rounded,
      label: 'Patients',
    ),
    (
      icon: Icons.chat_bubble_outline_rounded,
      selectedIcon: Icons.chat_bubble_rounded,
      label: 'Chat',
    ),
    (
      icon: Icons.account_box_outlined,
      selectedIcon: Icons.account_box_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      destinations: items.map(
        (item) {
          return NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon),
            label: item.label,
          );
        },
      ).toList(),
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      indicatorColor: colorScheme.secondaryContainer,
    );
  }
}