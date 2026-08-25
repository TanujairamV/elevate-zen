import 'package:flutter/material.dart';

class PatientRecordsScreen extends StatefulWidget {
  const PatientRecordsScreen({super.key});

  @override
  State<PatientRecordsScreen> createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  int selectedIndex = 2;

  final tabs = const [
    'History',
    'Medications',
    'Documents',
  ];

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
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _PatientSummary(),
                    const SizedBox(height: 48),
                    const Text(
                      'Medical Profile',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF111216),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _MedicalProfileCard(),
                    const SizedBox(height: 48),
                    const Text(
                      'Active Records',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF111216),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _RecordTabs(
                      selectedIndex: selectedIndex,
                      onSelected: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    const SizedBox(height: 28),
                    _buildSelectedRecords(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _PatientNavigationBar(),
    );
  }

  Widget _buildSelectedRecords() {
    switch (selectedIndex) {
      case 0:
        return const _HistoryRecords();
      case 1:
        return const _MedicationRecords();
      case 2:
        return const _DocumentRecords();
      default:
        return const _HistoryRecords();
    }
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
            'Patient Records',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Color(0xFF111216),
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

class _PatientSummary extends StatelessWidget {
  const _PatientSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 23,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE4E5F0),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: const BoxDecoration(
              color: Color(0xFF5E70CE),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'RK',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 22),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rahul Kumar',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF111216),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '52 years • Male • O+',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 19,
                    color: Color(0xFF454652),
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

class _MedicalProfileCard extends StatelessWidget {
  const _MedicalProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F5),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          _ProfileItem(
            icon: Icons.badge_outlined,
            iconBackground: const Color(0xFFB9CBFF),
            title: 'Personal Information',
            subtitle: 'Contact, Emergency, Addr...',
          ),
          const _ProfileDivider(),
          _ProfileItem(
            icon: Icons.monitor_heart_outlined,
            iconBackground: const Color(0xFF6B7BA5),
            title: 'Physical Vitals',
            subtitle: 'Height, Weight, BMI',
          ),
          const _ProfileDivider(),
          _ProfileItem(
            icon: Icons.coronavirus_outlined,
            iconBackground: const Color(0xFFFFD0CD),
            iconColor: const Color(0xFFB71C1C),
            title: 'Allergies & Reactions',
            subtitle: 'Penicillin, Peanuts',
          ),
        ],
      ),
    );
  }
}

class _ProfileDivider extends StatelessWidget {
  const _ProfileDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: Divider(
        height: 1,
        color: Color(0xFFDCDCE2),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color? iconColor;
  final String title;
  final String subtitle;

  const _ProfileItem({
    required this.icon,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 20,
      ),
      child: Row(
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
              color: iconColor ?? const Color(0xFF5066B9),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    color: Color(0xFF111216),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    color: Color(0xFF454652),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 30,
            color: Color(0xFF393A44),
          ),
        ],
      ),
    );
  }
}

class _RecordTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _RecordTabs({
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (index) {
          final selected = selectedIndex == index;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index == 2 ? 0 : 10,
              ),
              child: GestureDetector(
                onTap: () => onSelected(index),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF4D5FBE)
                        : const Color(0xFFE7E7EC),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Center(
                    child: Text(
                      [
                        'History',
                        'Medications',
                        'Documents',
                      ][index],
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF454652),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HistoryRecords extends StatelessWidget {
  const _HistoryRecords();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 25),
          decoration: BoxDecoration(
            color: const Color(0xFFEDEDF1),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB9CBFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      color: Color(0xFF5066B9),
                      size: 36,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Hypertension\nDiagnosed 2018',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 19,
                        height: 1.4,
                        color: Color(0xFF202126),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5E6EC8),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Primary essential hypertension. Blood\npressure currently managed with daily...',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  height: 1.5,
                  color: Color(0xFF454652),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MedicationRecords extends StatelessWidget {
  const _MedicationRecords();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDF1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: const BoxDecoration(
                  color: Color(0xFF6B7BA5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.medication_outlined,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amlodipine',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        color: Color(0xFF111216),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '5mg • Once daily',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                        color: Color(0xFF454652),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              _MedicationTag('Morning'),
              const SizedBox(width: 10),
              _MedicationTag('With Food'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MedicationTag extends StatelessWidget {
  final String text;

  const _MedicationTag(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE1E1E6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          color: Color(0xFF454652),
        ),
      ),
    );
  }
}

class _DocumentRecords extends StatelessWidget {
  const _DocumentRecords();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 22,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDF1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: const BoxDecoration(
              color: Color(0xFFE2E2E7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.description_outlined,
              size: 34,
              color: Color(0xFF353640),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lipid Panel Report',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    color: Color(0xFF111216),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Oct 12, 2023 • Dr. Sharma',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Color(0xFF454652),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.download_outlined,
            size: 28,
            color: Color(0xFF334DB3),
          ),
        ],
      ),
    );
  }
}

class _PatientNavigationBar extends StatelessWidget {
  const _PatientNavigationBar();

  static const items = [
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
            final selected = index == 3;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.pushReplacementNamed(
                        context,
                        '/patient',
                      );
                    case 1:
                      Navigator.pushNamed(
                        context,
                        '/patient/case',
                      );
                    case 2:
                      Navigator.pushNamed(
                        context,
                        '/patient/chat',
                      );
                    case 3:
                      break;
                    case 4:
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