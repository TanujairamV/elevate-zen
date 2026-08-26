import 'package:flutter/material.dart';
import '../app/widgets/doctor_navigation_bar.dart';

class DoctorPatientsScreen extends StatefulWidget {
  const DoctorPatientsScreen({super.key});

  @override
  State<DoctorPatientsScreen> createState() => _DoctorPatientsScreenState();
}

class _DoctorPatientsScreenState extends State<DoctorPatientsScreen> {
  final TextEditingController patientIdController =
      TextEditingController();

  @override
  void dispose() {
    patientIdController.dispose();
    super.dispose();
  }

  void _lookupPatient() {
    if (patientIdController.text.trim().isEmpty) {
      return;
    }

    Navigator.pushNamed(
      context,
      '/doctor/patient',
    );
  }

  void _navigate(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
          context,
          '/doctor',
        );
        break;
      case 1:
        Navigator.pushReplacementNamed(
          context,
          '/doctor/scan',
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacementNamed(
          context,
          '/doctor/chat',
        );
        break;
      case 4:
        Navigator.pushReplacementNamed(
          context,
          '/doctor/profile',
        );
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _ScannerArea(),
                    const SizedBox(height: 36),
                    Text(
                      'Or enter manually',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 16),
                    _PatientIdField(
                      controller: patientIdController,
                    ),
                    const SizedBox(height: 18),
                    _LookupButton(
                      onPressed: _lookupPatient,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DoctorNavigationBar(
        selectedIndex: 2,
        onSelected: _navigate,
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
            'Doctor Patients',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
          ),
          const Spacer(),
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

class _ScannerArea extends StatelessWidget {
  const _ScannerArea();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: SizedBox(
        height: 496,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.primary.withValues(
                        alpha: 0.45,
                      ),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.qr_code_2,
                      size: 82,
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.45,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              top: 267,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 22,
              child: const _PatientPreviewCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientPreviewCard extends StatelessWidget {
  const _PatientPreviewCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          18,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'RK',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rahul Kumar',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'ID: 8492-491-A',
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
                Icon(
                  Icons.check_circle_outline,
                  size: 31,
                  color: colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/doctor/patient',
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                ),
                label: const Text('View Patient File'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientIdField extends StatelessWidget {
  final TextEditingController controller;

  const _PatientIdField({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) {
        if (controller.text.trim().isNotEmpty) {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: const InputDecoration(
        labelText: 'Patient ID',
        hintText: 'e.g. 1234-567-B',
        prefixIcon: Icon(
          Icons.badge_outlined,
        ),
      ),
    );
  }
}

class _LookupButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _LookupButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.search,
        ),
        label: const Text('Lookup Patient'),
      ),
    );
  }
}