import 'package:flutter/material.dart';
import '../app/widgets/doctor_navigation_bar.dart';

class DoctorPatientScreen extends StatelessWidget {
  const DoctorPatientScreen({super.key});

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/doctor');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/doctor/scan');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/doctor/patients');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/doctor/chat');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/doctor/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  24,
                  24,
                  32,
                ),
                child: Column(
                  children: const [
                    _PatientHeader(),
                    SizedBox(height: 34),
                    _Timeline(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DoctorNavigationBar(
        selectedIndex: 2,
        onSelected: (index) => _navigate(context, index),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.medical_information_outlined,
              color: colorScheme.onPrimaryContainer,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Doctor Patients',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
            ),
          ),
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              'AS',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientHeader extends StatelessWidget {
  const _PatientHeader();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 47,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?img=12',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Robert C. Vance',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                '68 yrs • Male • ID: 8943-22X',
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
        const SizedBox(width: 12),
        FloatingActionButton.small(
          onPressed: () {},
          elevation: 0,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _YearDivider(
          year: '2026',
          current: true,
        ),
        const SizedBox(height: 20),
        _TimelineItem(
          icon: Icons.medical_services_outlined,
          iconBackground: Theme.of(context)
              .colorScheme
              .primaryContainer,
          iconColor: Theme.of(context)
              .colorScheme
              .onPrimaryContainer,
          lineHeight: 35,
          child: const _AppointmentCard(),
        ),
        _TimelineItem(
          icon: Icons.water_drop_outlined,
          iconBackground: Theme.of(context)
              .colorScheme
              .secondaryContainer,
          iconColor: Theme.of(context)
              .colorScheme
              .onSecondaryContainer,
          lineHeight: 35,
          child: const _LabCard(),
        ),
        const SizedBox(height: 10),
        const _YearDivider(
          year: '2025',
        ),
        const SizedBox(height: 20),
        _TimelineItem(
          icon: Icons.medication_outlined,
          iconBackground: Theme.of(context)
              .colorScheme
              .tertiaryContainer,
          iconColor: Theme.of(context)
              .colorScheme
              .onTertiaryContainer,
          lineHeight: 35,
          child: const _PrescriptionCard(),
        ),
        const SizedBox(height: 10),
        const _YearDivider(
          year: '2024',
        ),
        const SizedBox(height: 20),
        _TimelineItem(
          icon: Icons.medical_information_outlined,
          iconBackground: Theme.of(context)
              .colorScheme
              .errorContainer,
          iconColor: Theme.of(context)
              .colorScheme
              .onErrorContainer,
          lineHeight: 0,
          child: const _DiagnosisCard(),
        ),
      ],
    );
  }
}

class _YearDivider extends StatelessWidget {
  final String year;
  final bool current;

  const _YearDivider({
    required this.year,
    this.current = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = current
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;

    final foregroundColor = current
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurfaceVariant;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            year,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(
                  color: foregroundColor,
                  fontWeight: current
                      ? FontWeight.w600
                      : FontWeight.w500,
                ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Divider(
            color: colorScheme.outlineVariant,
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final Widget child;
  final double lineHeight;

  const _TimelineItem({
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.child,
    required this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 58,
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 29,
                    color: iconColor,
                  ),
                ),
                if (lineHeight > 0)
                  Expanded(
                    child: Container(
                      width: 3,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _TimelineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Cardiology Follow-up',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Current',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Today • 10:30 AM',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 18),
          Text(
            'Patient reports mild shortness of breath\nafter moderate exertion. Blood pressur...',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
                  height: 1.45,
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 18),
          const _SmallAction(
            icon: Icons.edit_note_outlined,
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}

class _LabCard extends StatelessWidget {
  const _LabCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _TimelineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comprehensive Metabolic Panel',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            'Feb 14, 2026 • Quest Diagnostics',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _LabResultRow(
                  name: 'Cholesterol (Total)',
                  value: '240 mg/dL ↑',
                  warning: true,
                ),
                const SizedBox(height: 10),
                _LabResultRow(
                  name: 'Glucose',
                  value: '95 mg/dL',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LabResultRow extends StatelessWidget {
  final String name;
  final String value;
  final bool warning;

  const _LabResultRow({
    required this.name,
    required this.value,
    this.warning = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            name,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: colorScheme.onSurface,
                ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
                color: warning
                    ? colorScheme.error
                    : colorScheme.onSurface,
                fontWeight: warning
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
        ),
      ],
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _TimelineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prescription Updated',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            'Nov 03, 2025 • Dr. Sarah Jenkins',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.medication_outlined,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Atorvastatin',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '20mg • 1 tablet daily at bedtime',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color:
                                  colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagnosisCard extends StatelessWidget {
  const _DiagnosisCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _TimelineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Initial Diagnosis',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            'Jun 12, 2024 • General Hospital',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              15,
              14,
              15,
              15,
            ),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorScheme.onErrorContainer,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Essential (primary) hypertension',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  colorScheme.onErrorContainer,
                            ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'ICD-10: I10. Patient presented\nwith persistent high blood\npressure readings over 3 visits.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              height: 1.4,
                              color:
                                  colorScheme.onErrorContainer,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final Widget child;

  const _TimelineCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          18,
          20,
          18,
          18,
        ),
        child: child,
      ),
    );
  }
}

class _SmallAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SmallAction({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 19,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}