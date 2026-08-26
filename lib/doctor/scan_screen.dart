import 'package:flutter/material.dart';
import '../app/widgets/doctor_navigation_bar.dart';

class DoctorScanScreen extends StatefulWidget {
  const DoctorScanScreen({super.key});

  @override
  State<DoctorScanScreen> createState() => _DoctorScanScreenState();
}

class _DoctorScanScreenState extends State<DoctorScanScreen> {
  final TextEditingController patientIdController =
      TextEditingController();

  @override
  void dispose() {
    patientIdController.dispose();
    super.dispose();
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
          '/doctor/patients',
        );
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

  void _scanPatient() {
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
              children: [
                Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 48,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'QR Scanner',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Position the patient QR code inside the scanning frame.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Start Scanner'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _lookupPatient() {
    final id = patientIdController.text.trim();

    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a patient ID first.'),
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/doctor/patient',
    );
  }

  void _openRecentPatient() {
    Navigator.pushNamed(
      context,
      '/doctor/patient',
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
              'Doctor Scan',
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
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 21,
              backgroundColor:
                  colorScheme.primaryContainer,
              child: Text(
                'AS',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                      color:
                          colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 28),
        children: [
          const SizedBox(height: 12),
          const _ScannerPreview(),
          _ScanControls(
            patientIdController: patientIdController,
            onScan: _scanPatient,
            onLookup: _lookupPatient,
          ),
          const SizedBox(height: 20),
          _RecentScanCard(
            onTap: _openRecentPatient,
          ),
          const SizedBox(height: 12),
        ],
      ),
      bottomNavigationBar: DoctorNavigationBar(
        selectedIndex: 1,
        onSelected: _navigate,
      ),
    );
  }
}

class _ScannerPreview extends StatelessWidget {
  const _ScannerPreview();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 310,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: colorScheme.surfaceContainerLowest,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius:
                          BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.qr_code_2_rounded,
                        size: 82,
                        color:
                            colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const _ScannerCorner(
                    top: 0,
                    left: 0,
                    borderTop: true,
                    borderLeft: true,
                  ),
                  const _ScannerCorner(
                    top: 0,
                    right: 0,
                    borderTop: true,
                    borderRight: true,
                  ),
                  const _ScannerCorner(
                    bottom: 0,
                    left: 0,
                    borderBottom: true,
                    borderLeft: true,
                  ),
                  const _ScannerCorner(
                    bottom: 0,
                    right: 0,
                    borderBottom: true,
                    borderRight: true,
                  ),
                  Positioned(
                    left: 18,
                    right: 18,
                    top: 123,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius:
                            BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 18,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.inverseSurface,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  'Align QR code within frame',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(
                        color:
                            colorScheme.onInverseSurface,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerCorner extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final bool borderTop;
  final bool borderBottom;
  final bool borderLeft;
  final bool borderRight;

  const _ScannerCorner({
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.borderTop = false,
    this.borderBottom = false,
    this.borderLeft = false,
    this.borderRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: SizedBox(
        width: 48,
        height: 48,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: borderTop
                  ? BorderSide(
                      color: colorScheme.primary,
                      width: 6,
                    )
                  : BorderSide.none,
              bottom: borderBottom
                  ? BorderSide(
                      color: colorScheme.primary,
                      width: 6,
                    )
                  : BorderSide.none,
              left: borderLeft
                  ? BorderSide(
                      color: colorScheme.primary,
                      width: 6,
                    )
                  : BorderSide.none,
              right: borderRight
                  ? BorderSide(
                      color: colorScheme.primary,
                      width: 6,
                    )
                  : BorderSide.none,
            ),
            borderRadius: BorderRadius.only(
              topLeft: borderTop && borderLeft
                  ? const Radius.circular(16)
                  : Radius.zero,
              topRight: borderTop && borderRight
                  ? const Radius.circular(16)
                  : Radius.zero,
              bottomLeft: borderBottom && borderLeft
                  ? const Radius.circular(16)
                  : Radius.zero,
              bottomRight: borderBottom && borderRight
                  ? const Radius.circular(16)
                  : Radius.zero,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanControls extends StatelessWidget {
  final TextEditingController patientIdController;
  final VoidCallback onScan;
  final VoidCallback onLookup;

  const _ScanControls({
    required this.patientIdController,
    required this.onScan,
    required this.onLookup,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        26,
        28,
        26,
        28,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 58,
            child: FilledButton.icon(
              onPressed: onScan,
              icon: const Icon(
                Icons.qr_code_scanner_rounded,
              ),
              label: const Text(
                'Scan Patient QR',
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: colorScheme.outlineVariant,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Text(
                  'OR',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color:
                            colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: colorScheme.outlineVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Manual Entry',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: patientIdController,
                  textInputAction:
                      TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Patient ID',
                    hintText: 'e.g. EZ-8902',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 112,
                height: 56,
                child: FilledButton(
                  onPressed: onLookup,
                  child: const Text('Lookup'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentScanCard extends StatelessWidget {
  final VoidCallback onTap;

  const _RecentScanCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      colorScheme.primaryContainer,
                  child: Text(
                    'R',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          color: colorScheme
                              .onPrimaryContainer,
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
                        'Recent Scan',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(
                              color: colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Rahul Kumar',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight:
                                  FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '52M • ID: #EZ-8902',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 30,
                  color:
                      colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}