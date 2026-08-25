import 'package:flutter/material.dart';

class PatientCaseScreen extends StatelessWidget {
  const PatientCaseScreen({super.key});

  static const primary = Color(0xFF4D5FBE);
  static const background = Color(0xFFF9F9FD);
  static const cardColor = Color(0xFFEDEDF1);
  static const textColor = Color(0xFF17181C);
  static const secondaryText = Color(0xFF454652);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 180),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Title(),
                    SizedBox(height: 14),
                    _ChiefComplaintCard(),
                    SizedBox(height: 22),
                    _MedicalHistoryCard(),
                    SizedBox(height: 22),
                    _MedicationsCard(),
                    SizedBox(height: 22),
                    _DocumentsCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomArea(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: const BoxDecoration(
        color: PatientCaseScreen.background,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEDEDF1),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            color: Colors.white,
            child: const Icon(
              Icons.medical_information_outlined,
              color: Color(0xFF5E6EC8),
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          const Text(
            'Patient Case',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: PatientCaseScreen.textColor,
            ),
          ),
          const Spacer(),
          const CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=12',
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review your information',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 34,
            fontWeight: FontWeight.w400,
            color: PatientCaseScreen.textColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Please verify the details below before submitting to\nyour care team.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 19,
            height: 1.45,
            color: PatientCaseScreen.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: PatientCaseScreen.cardColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PatientCaseScreen.primary,
          size: 27,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 23,
              fontWeight: FontWeight.w400,
              color: PatientCaseScreen.textColor,
            ),
          ),
        ),
        Container(
          width: 46,
          height: 46,
          decoration: const BoxDecoration(
            color: Color(0xFFE5E5EA),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.edit_outlined,
            size: 22,
            color: PatientCaseScreen.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _ChiefComplaintCard extends StatelessWidget {
  const _ChiefComplaintCard();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            icon: Icons.medical_information_outlined,
            title: 'Chief Complaint',
          ),
          SizedBox(height: 22),
          Text(
            'Persistent lower back pain for the past\n2 weeks, worsening after prolonged\nsitting. Occasional sharp pain radiating\nto the left leg.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              height: 1.7,
              color: PatientCaseScreen.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicalHistoryCard extends StatelessWidget {
  const _MedicalHistoryCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            icon: Icons.history_rounded,
            title: 'Medical History',
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _HistoryChip(
                text: 'Hypertension (Diagnosed 2018)',
              ),
              _HistoryChip(
                text: 'Asthma (Mild)',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryChip extends StatelessWidget {
  final String text;

  const _HistoryChip({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5EA),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          color: PatientCaseScreen.textColor,
        ),
      ),
    );
  }
}

class _MedicationsCard extends StatelessWidget {
  const _MedicationsCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        children: [
          const _SectionHeader(
            icon: Icons.medication_outlined,
            title: 'Current Medications',
          ),
          const SizedBox(height: 18),
          _MedicationItem(
            icon: Icons.medication_outlined,
            name: 'Lisinopril',
            dosage: '10mg, Once daily',
          ),
          const SizedBox(height: 12),
          _MedicationItem(
            icon: Icons.medical_services_outlined,
            name: 'Albuterol Inhaler',
            dosage: 'As needed',
          ),
        ],
      ),
    );
  }
}

class _MedicationItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final String dosage;

  const _MedicationItem({
    required this.icon,
    required this.name,
    required this.dosage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: Color(0xFFD0DAFF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: PatientCaseScreen.primary,
              size: 29,
            ),
          ),
          const SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  color: PatientCaseScreen.textColor,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                dosage,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  color: PatientCaseScreen.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocumentsCard extends StatelessWidget {
  const _DocumentsCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            icon: Icons.description_outlined,
            title: 'Attached Documents',
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4EAFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.image_outlined,
                    color: PatientCaseScreen.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Previous_XRay_Lumbar.jpg',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: PatientCaseScreen.textColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2.4 MB',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: PatientCaseScreen.secondaryText,
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

class _BottomArea extends StatelessWidget {
  const _BottomArea();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9FD),
            border: Border(
              top: BorderSide(
                color: Color(0xFFE3E3E8),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 58,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit_note_outlined,
                      size: 24,
                    ),
                    label: const Text(
                      'Edit Details',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: PatientCaseScreen.textColor,
                      side: const BorderSide(
                        color: Color(0xFFC6C5D4),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 58,
                  child: FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send_outlined,
                      size: 23,
                    ),
                    label: const Text(
                      'Submit History',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: PatientCaseScreen.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const _PatientNavigationBar(),
      ],
    );
  }
}

class _PatientNavigationBar extends StatefulWidget {
  const _PatientNavigationBar();

  @override
  State<_PatientNavigationBar> createState() => _PatientNavigationBarState();
}

class _PatientNavigationBarState extends State<_PatientNavigationBar> {
  int selectedIndex = 1;

  final items = const [
    (Icons.home_outlined, 'Home'),
    (Icons.medical_services_outlined, 'Case'),
    (Icons.chat_bubble_outline, 'Chat'),
    (Icons.description_outlined, 'Records'),
    (Icons.account_circle_outlined, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FD),
      ),
      child: Row(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];
            final selected = selectedIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/patient',
                    );
                  } else if (index == 1) {
                    setState(() {
                      selectedIndex = 1;
                    });
                  } else if (index == 2) {
                    Navigator.pushNamed(
                      context,
                      '/patient/chat',
                    );
                  } else if (index == 3) {
                    Navigator.pushNamed(
                      context,
                      '/patient/records',
                    );
                  } else if (index == 4) {
                    Navigator.pushNamed(
                      context,
                      '/patient/profile',
                    );
                  }
                },
                child: Container(
                  height: 68,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF5E6EC8)
                        : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.$1,
                        size: 28,
                        color: const Color(0xFF292A35),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.$2,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          color: Color(0xFF292A35),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}