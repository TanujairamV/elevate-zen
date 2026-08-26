import 'package:flutter/material.dart';
import '../app/widgets/patient_navigation_bar.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  bool notificationsEnabled = true;

  void _navigate(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
          context,
          '/patient',
        );
        break;
      case 1:
        Navigator.pushReplacementNamed(
          context,
          '/patient/case',
        );
        break;
      case 2:
        Navigator.pushReplacementNamed(
          context,
          '/patient/chat',
        );
        break;
      case 3:
        Navigator.pushReplacementNamed(
          context,
          '/patient/records',
        );
        break;
      case 4:
        break;
    }
  }

  void _editProfile() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              8,
              24,
              28,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit Profile',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(
                    Icons.person_outline,
                  ),
                  title: const Text(
                    'Edit personal information',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                  title: const Text(
                    'Change profile photo',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPrivacySecurity() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              8,
              24,
              28,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy & Security',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        colorScheme.primaryContainer,
                    child: Icon(
                      Icons.lock_outline,
                      color:
                          colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: const Text(
                    'Password & Security',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        colorScheme.secondaryContainer,
                    child: Icon(
                      Icons.privacy_tip_outlined,
                      color:
                          colorScheme.onSecondaryContainer,
                    ),
                  ),
                  title: const Text(
                    'Privacy Settings',
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _signOut() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 24,
        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.medical_information_outlined,
                color: colorScheme.onPrimaryContainer,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Patient Profile',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Search',
            icon: const Icon(
              Icons.search_rounded,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 4,
            ),
            child: CircleAvatar(
              radius: 21,
              backgroundImage: const NetworkImage(
                'https://i.pravatar.cc/150?img=12',
              ),
              backgroundColor:
                  colorScheme.primaryContainer,
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            22,
            30,
            22,
            32,
          ),
          child: Column(
            children: [
              _ProfileHero(
                onEdit: _editProfile,
              ),
              const SizedBox(height: 36),
              const _PersonalInformation(),
              const SizedBox(height: 20),
              const _EmergencyContact(),
              const SizedBox(height: 20),
              const _MedicalOverview(),
              const SizedBox(height: 20),
              _SettingsSection(
                notificationsEnabled:
                    notificationsEnabled,
                onNotificationsChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
                onPrivacyTap: _showPrivacySecurity,
              ),
              const SizedBox(height: 24),
              _SignOutButton(
                onPressed: _signOut,
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PatientNavigationBar(
        selectedIndex: 4,
        onSelected: _navigate,
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  final VoidCallback onEdit;

  const _ProfileHero({
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 142,
              height: 142,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(
                      alpha: 0.12,
                    ),
                    blurRadius: 18,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=12',
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: FloatingActionButton.small(
                onPressed: onEdit,
                elevation: 2,
                child: const Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Text(
          'Rahul Kumar',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(
                fontWeight: FontWeight.w400,
                color: colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          '52 yrs • Male • O+',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: onEdit,
          icon: const Icon(
            Icons.edit_outlined,
          ),
          label: const Text(
            'Edit Profile',
          ),
          style: FilledButton.styleFrom(
            minimumSize: const Size(172, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ],
    );
  }
}

class _PersonalInformation extends StatelessWidget {
  const _PersonalInformation();

  @override
  Widget build(BuildContext context) {
    return _ProfileSection(
      title: 'Personal Information',
      icon: Icons.person_outline,
      children: [
        _InformationRow(
          label: 'Email',
          value: 'rahul.k@example.com',
          trailing: const Icon(
            Icons.chevron_right_rounded,
          ),
        ),
        const _SectionDivider(),
        _InformationRow(
          label: 'Phone Number',
          value: '+91 98765 43210',
          trailing: const Icon(
            Icons.chevron_right_rounded,
          ),
        ),
      ],
    );
  }
}

class _EmergencyContact extends StatelessWidget {
  const _EmergencyContact();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _ProfileSection(
      title: 'Emergency Contact',
      icon: Icons.contact_phone_outlined,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anjali Kumar',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Spouse • +91 98765 11223',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                            color:
                                colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton.filledTonal(
                onPressed: () {},
                tooltip: 'Call emergency contact',
                icon: const Icon(
                  Icons.phone_outlined,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MedicalOverview extends StatelessWidget {
  const _MedicalOverview();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _ProfileSection(
      title: 'Medical Overview',
      icon: Icons.medical_information_outlined,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Allergies',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                      color: colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _MedicalChip(
                    label: 'Penicillin',
                    backgroundColor:
                        colorScheme.errorContainer,
                    foregroundColor:
                        colorScheme.onErrorContainer,
                  ),
                  _MedicalChip(
                    label: 'Peanuts',
                    backgroundColor:
                        colorScheme.errorContainer,
                    foregroundColor:
                        colorScheme.onErrorContainer,
                  ),
                ],
              ),
            ],
          ),
        ),
        const _SectionDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 14,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Current Medications',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                      color: colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 10),
              _MedicalChip(
                label: 'Amlodipine 5mg',
                backgroundColor:
                    colorScheme.primaryContainer,
                foregroundColor:
                    colorScheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
        const _SectionDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 14,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Blood Group',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                ),
              ),
              Text(
                'O+',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MedicalChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  const _MedicalChip({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final bool notificationsEnabled;
  final ValueChanged<bool> onNotificationsChanged;
  final VoidCallback onPrivacyTap;

  const _SettingsSection({
    required this.notificationsEnabled,
    required this.onNotificationsChanged,
    required this.onPrivacyTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _ProfileSection(
      title: 'Settings',
      icon: Icons.settings_outlined,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Notifications',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                ),
              ),
              Switch(
                value: notificationsEnabled,
                onChanged: onNotificationsChanged,
              ),
            ],
          ),
        ),
        const _SectionDivider(),
        InkWell(
          onTap: onPrivacyTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 14,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Privacy & Security',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _ProfileSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 15,
            ),
            color: colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _InformationRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? trailing;

  const _InformationRow({
    required this.label,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          if (trailing != null)
            IconTheme(
              data: IconThemeData(
                color: colorScheme.onSurfaceVariant,
                size: 28,
              ),
              child: trailing!,
            ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Divider(
      height: 1,
      thickness: 1,
      indent: 18,
      endIndent: 18,
      color: colorScheme.outlineVariant,
    );
  }
}

class _SignOutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SignOutButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.logout_rounded,
      ),
      label: const Text(
        'Sign Out',
      ),
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.error,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
      ),
    );
  }
}