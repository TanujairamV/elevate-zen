import 'package:flutter/material.dart';

class DoctorPatientScreen extends StatelessWidget {
  const DoctorPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FD),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 110),
                child: Column(
                  children: [
                    const _PatientHeader(),
                    const SizedBox(height: 34),
                    const _Timeline(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _DoctorNavigationBar(
        selectedIndex: 2,
        onSelected: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/doctor');
              break;
            case 1:
              Navigator.pushNamed(context, '/doctor/scan');
              break;
            case 2:
              break;
            case 3:
              Navigator.pushNamed(context, '/doctor/chat');
              break;
            case 4:
              Navigator.pushNamed(context, '/doctor/profile');
              break;
          }
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 23),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FD),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEDEDF1),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            color: Colors.white,
            child: const Icon(
              Icons.medical_information_outlined,
              color: Color(0xFF5E6EC8),
              size: 27,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Doctor Patients',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 27,
              fontWeight: FontWeight.w400,
              color: Color(0xFF111216),
            ),
          ),
          const Spacer(),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF4D5FBE),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'AS',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
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
    return Row(
      children: [
        const CircleAvatar(
          radius: 47,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?img=12',
          ),
        ),
        const SizedBox(width: 22),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Robert C. Vance',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 31,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF111216),
                ),
              ),
              SizedBox(height: 5),
              Text(
                '68 yrs • Male • ID: 8943-22X',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 19,
                  color: Color(0xFF454652),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 58,
          height: 58,
          decoration: const BoxDecoration(
            color: Color(0xFF4D5FBE),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            size: 36,
            color: Colors.white,
          ),
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
        ),
        const SizedBox(height: 20),
        _TimelineItem(
          icon: Icons.medical_services_outlined,
          iconBackground: const Color(0xFF5E70CE),
          lineHeight: 35,
          child: const _AppointmentCard(),
        ),
        _TimelineItem(
          icon: Icons.water_drop_outlined,
          iconBackground: const Color(0xFFB5C9FF),
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
          iconBackground: const Color(0xFF6B7BA5),
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
          iconBackground: const Color(0xFFFFD1CD),
          iconColor: const Color(0xFFB71C1C),
          lineHeight: 0,
          child: const _DiagnosisCard(),
        ),
      ],
    );
  }
}

class _YearDivider extends StatelessWidget {
  final String year;

  const _YearDivider({
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: year == '2026'
                ? const Color(0xFFDCE5FF)
                : const Color(0xFFE3E3E8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            year,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Color(0xFF343640),
            ),
          ),
        ),
        const SizedBox(width: 22),
        const Expanded(
          child: Divider(
            color: Color(0xFFE0E0E5),
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color? iconColor;
  final Widget child;
  final double lineHeight;

  const _TimelineItem({
    required this.icon,
    required this.iconBackground,
    required this.child,
    required this.lineHeight,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
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
                    size: 30,
                    color: iconColor ?? Colors.white,
                  ),
                ),
                if (lineHeight > 0)
                  Expanded(
                    child: Container(
                      width: 3,
                      margin: const EdgeInsets.only(top: 2),
                      color: const Color(0xFFE5E5EA),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 34),
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
    return _TimelineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Cardiology Follow-up',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    color: Color(0xFF111216),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4D5FBE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Current',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Today • 10:30 AM',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Color(0xFF454652),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Patient reports mild shortness of breath\nafter moderate exertion. Blood pressur...',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 17,
              height: 1.45,
              color: Color(0xFF454652),
            ),
          ),
          const SizedBox(height: 20),
          _SmallAction(
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
    return _TimelineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Comprehensive Metabolic Panel',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 21,
              color: Color(0xFF111216),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Feb 14, 2026 • Quest Diagnostics',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Color(0xFF454652),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Cholesterol (Total)',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Color(0xFF202126),
                        ),
                      ),
                    ),
                    Text(
                      '240 mg/dL ↑',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Color(0xFFC71919),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Glucose',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Color(0xFF202126),
                        ),
                      ),
                    ),
                    Text(
                      '95 mg/dL',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Color(0xFF202126),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrescriptionCard extends StatelessWidget {
  const _PrescriptionCard();

  @override
  Widget build(BuildContext context) {
    return _TimelineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prescription Updated',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 22,
              color: Color(0xFF111216),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Nov 03, 2025 • Dr. Sarah Jenkins',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Color(0xFF454652),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE5FF),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.medication_outlined,
                    color: Color(0xFF4057A5),
                  ),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Atorvastatin',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        color: Color(0xFF202126),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '20mg • 1 tablet daily at bedtime',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        color: Color(0xFF454652),
                      ),
                    ),
                  ],
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
    return _TimelineCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Initial Diagnosis',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 22,
              color: Color(0xFF111216),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Jun 12, 2024 • General Hospital',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Color(0xFF454652),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(15, 13, 15, 15),
            decoration: BoxDecoration(
              color: const Color(0xFFE9D6D9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Color(0xFFB71C1C),
                  size: 23,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Essential (primary) hypertension',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB71C1C),
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'ICD-10: I10. Patient presented\nwith persistent high blood\npressure readings over 3 visits.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          height: 1.4,
                          color: Color(0xFF343640),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDF1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E2E7),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 19,
            color: const Color(0xFF202126),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              color: Color(0xFF202126),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _DoctorNavigationBar({
    required this.selectedIndex,
    required this.onSelected,
  });

  static const items = [
    (Icons.grid_view_outlined, 'HOME'),
    (Icons.qr_code_scanner_outlined, 'SCAN'),
    (Icons.groups_outlined, 'PATIENTS'),
    (Icons.chat_bubble_outline, 'CHAT'),
    (Icons.account_box_outlined, 'PROFILE'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FD),
        border: Border(
          top: BorderSide(
            color: Color(0xFFEDEDF1),
          ),
        ),
      ),
      child: Row(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];
            final selected = index == selectedIndex;

            return Expanded(
              child: GestureDetector(
                onTap: () => onSelected(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.$1,
                      size: 30,
                      color: selected
                          ? const Color(0xFF334DB3)
                          : const Color(0xFF292A35),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      item.$2,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: selected
                            ? const Color(0xFF334DB3)
                            : const Color(0xFF292A35),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}