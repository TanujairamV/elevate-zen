import 'package:flutter/material.dart';

enum AppNavigationSection {
  home,
  caseTaking,
  chat,
  records,
  profile,
}

class AppNavigationBar extends StatelessWidget {
  final AppNavigationSection currentSection;
  final ValueChanged<AppNavigationSection> onDestinationSelected;

  const AppNavigationBar({
    super.key,
    required this.currentSection,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentSection.index,
      onDestinationSelected: (index) {
        onDestinationSelected(
          AppNavigationSection.values[index],
        );
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.medical_services_outlined),
          selectedIcon: Icon(Icons.medical_services),
          label: 'Case',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline),
          selectedIcon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.description_outlined),
          selectedIcon: Icon(Icons.description),
          label: 'Records',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_circle_outlined),
          selectedIcon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}