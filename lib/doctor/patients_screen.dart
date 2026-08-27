import 'package:flutter/material.dart';

class DoctorPatientsScreen extends StatefulWidget {
  const DoctorPatientsScreen({super.key});

  @override
  State<DoctorPatientsScreen> createState() =>
      _DoctorPatientsScreenState();
}

class _DoctorPatientsScreenState extends State<DoctorPatientsScreen> {
  final TextEditingController searchController =
      TextEditingController();

  final List<_PatientData> _allPatients = const [
    _PatientData(
      name: 'Nirunjhana',
      age: 45,
      gender: 'Female',
      patientId: 'NR-8902',
      status: _PatientStatus.aiSummaryReady,
      isFeatured: true,
    ),
    _PatientData(
      name: 'Anita Rao',
      age: 32,
      gender: 'Female',
      patientId: 'AR-4419',
      status: _PatientStatus.needsReview,
    ),
    _PatientData(
      name: 'Sanjay Joshi',
      age: 58,
      gender: 'Male',
      patientId: 'SJ-1104',
      status: _PatientStatus.processing,
    ),
  ];

  List<_PatientData> _filteredPatients = const [];

  @override
  void initState() {
    super.initState();
    _filteredPatients = _allPatients;
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredPatients = _allPatients;
        return;
      }

      _filteredPatients = _allPatients.where((patient) {
        return patient.name.toLowerCase().contains(query) ||
            patient.patientId.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _navigate(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/doctor');
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacementNamed(
          context,
          '/doctor/profile',
        );
        break;
    }
  }

  void _openPatient(_PatientData patient) {
    Navigator.pushNamed(
      context,
      '/doctor/patient',
      arguments: patient.patientId,
    );
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
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  24,
                  24,
                  32,
                ),
                children: [
                  Text(
                    'Patient Cases',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Review patient information and AI-assisted case summaries.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 20),
                  SearchBar(
                    controller: searchController,
                    hintText: 'Search patients',
                    leading: Icon(
                      Icons.search_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    elevation: const WidgetStatePropertyAll(0),
                    backgroundColor: WidgetStatePropertyAll(
                      colorScheme.surfaceContainerLow,
                    ),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 16),
                    ),
                    constraints: const BoxConstraints(
                      minHeight: 56,
                      maxHeight: 56,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_filteredPatients.isEmpty)
                    _EmptyResults(query: searchController.text)
                  else
                    ..._filteredPatients.map(
                      (patient) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _PatientCard(
                          patient: patient,
                          onTap: () => _openPatient(patient),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: _navigate,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(Icons.people_alt_rounded),
            label: 'Patients',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
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
          Text(
            'Patients',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              'C',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

enum _PatientStatus { aiSummaryReady, needsReview, processing }

class _PatientData {
  final String name;
  final int age;
  final String gender;
  final String patientId;
  final _PatientStatus status;
  final bool isFeatured;

  const _PatientData({
    required this.name,
    required this.age,
    required this.gender,
    required this.patientId,
    required this.status,
    this.isFeatured = false,
  });

  String get initial => name.substring(0, 1).toUpperCase();
}

class _PatientCard extends StatelessWidget {
  final _PatientData patient;
  final VoidCallback onTap;

  const _PatientCard({
    required this.patient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        colorScheme.primaryContainer,
                    child: Text(
                      patient.initial,
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient.name,
                          style: textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${patient.age} years • ${patient.gender}',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Patient ID: ${patient.patientId}',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _StatusChip(status: patient.status),
              if (patient.isFeatured) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: onTap,
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                    ),
                    label: const Text('Review Patient'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final _PatientStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    late final String label;
    late final IconData icon;
    late final Color background;
    late final Color foreground;

    switch (status) {
      case _PatientStatus.aiSummaryReady:
        label = 'AI Summary Ready';
        icon = Icons.auto_awesome_rounded;
        background = colorScheme.primaryContainer;
        foreground = colorScheme.onPrimaryContainer;
        break;
      case _PatientStatus.needsReview:
        label = 'Needs Review';
        icon = Icons.flag_outlined;
        background = colorScheme.tertiaryContainer;
        foreground = colorScheme.onTertiaryContainer;
        break;
      case _PatientStatus.processing:
        label = 'Information Processing';
        icon = Icons.hourglass_top_rounded;
        background = colorScheme.surfaceContainerHighest;
        foreground = colorScheme.onSurfaceVariant;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: foreground),
          const SizedBox(width: 6),
          Text(
            label,
            style: textTheme.labelLarge?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  final String query;

  const _EmptyResults({required this.query});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 40,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            'No patients match "$query"',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}