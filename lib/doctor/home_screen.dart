import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int selectedFilter = 0;
  int selectedNavigation = 0;

  final patients = const [
    _Patient(
      name: 'Rahul Kumar',
      details: '45M • ID: RK-8902',
      time: '09:30 AM',
      status: 'Summary Ready',
      statusType: _PatientStatus.ready,
      image: 'https://i.pravatar.cc/150?img=11',
    ),
    _Patient(
      name: 'Anita Rao',
      details: '32F • ID: AR-4419',
      time: '10:15 AM',
      status: 'Needs Review',
      statusType: _PatientStatus.review,
      image: 'https://i.pravatar.cc/150?img=47',
    ),
    _Patient(
      name: 'Sanjay Joshi',
      details: '58M • ID: SJ-1104',
      time: '11:00 AM',
      status: 'Processing Scan',
      statusType: _PatientStatus.processing,
    ),
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
                padding: const EdgeInsets.fromLTRB(29, 43, 29, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Greeting(),
                    const SizedBox(height: 59),
                    const _Statistics(),
                    const SizedBox(height: 58),
                    _PatientsHeader(
                      onViewAll: () {
                        Navigator.pushNamed(
                          context,
                          '/doctor/patients',
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    _FilterBar(
                      selectedIndex: selectedFilter,
                      onSelected: (index) {
                        setState(() {
                          selectedFilter = index;
                        });
                      },
                    ),
                    const SizedBox(height: 37),
                    ...patients.map(
                      (patient) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _PatientCard(
                          patient: patient,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/doctor/patient',
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/doctor/scan',
          );
        },
        backgroundColor: const Color(0xFF4D5FBE),
        foregroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
      bottomNavigationBar: _DoctorNavigationBar(
        selectedIndex: selectedNavigation,
        onSelected: (index) {
          setState(() {
            selectedNavigation = index;
          });

          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushNamed(
                context,
                '/doctor/scan',
              );
            case 2:
              Navigator.pushNamed(
                context,
                '/doctor/patients',
              );
            case 3:
              Navigator.pushNamed(
                context,
                '/doctor/chat',
              );
            case 4:
              Navigator.pushNamed(
                context,
                '/doctor/profile',
              );
          }
        },
      ),
    );
  }
}

enum _PatientStatus {
  ready,
  review,
  processing,
}

class _Patient {
  final String name;
  final String details;
  final String time;
  final String status;
  final _PatientStatus statusType;
  final String? image;

  const _Patient({
    required this.name,
    required this.details,
    required this.time,
    required this.status,
    required this.statusType,
    this.image,
  });
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 29),
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
            width: 52,
            height: 52,
            color: Colors.white,
            child: const Icon(
              Icons.medical_information_outlined,
              color: Color(0xFF5E6EC8),
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          const Text(
            'Doctor Home',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 31,
              fontWeight: FontWeight.w400,
              color: Color(0xFF111216),
            ),
          ),
          const Spacer(),
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Color(0xFF4D5FBE),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'AS',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
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

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning, Dr. Sharma',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 42,
            fontWeight: FontWeight.w400,
            color: Color(0xFF111216),
            height: 1.15,
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(
              Icons.medical_services_outlined,
              size: 29,
              color: Color(0xFF454652),
            ),
            SizedBox(width: 9),
            Text(
              'General Medicine',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                color: Color(0xFF454652),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Statistics extends StatelessWidget {
  const _Statistics();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatisticCard(
            title: "TODAY'S PATIENTS",
            value: '24',
            backgroundColor: const Color(0xFF5E70CE),
            foregroundColor: Colors.white,
            icon: Icons.person_outline,
          ),
        ),
        const SizedBox(width: 29),
        Expanded(
          child: _StatisticCard(
            title: 'PENDING REVIEWS',
            value: '6',
            backgroundColor: const Color(0xFFB9CBFF),
            foregroundColor: const Color(0xFF3D568F),
            icon: Icons.description_outlined,
          ),
        ),
      ],
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;

  const _StatisticCard({
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 202,
      padding: const EdgeInsets.fromLTRB(29, 31, 20, 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  letterSpacing: 0.5,
                  color: foregroundColor.withValues(alpha: 0.85),
                ),
              ),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 78,
                  height: 0.95,
                  fontWeight: FontWeight.w300,
                  color: foregroundColor,
                ),
              ),
            ],
          ),
          Positioned(
            right: -5,
            top: -5,
            child: Icon(
              icon,
              size: 95,
              color: foregroundColor.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientsHeader extends StatelessWidget {
  final VoidCallback onViewAll;

  const _PatientsHeader({
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Today's Patients",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 32,
            fontWeight: FontWeight.w400,
            color: Color(0xFF111216),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onViewAll,
          child: const Row(
            children: [
              Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  color: Color(0xFF334DB3),
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.chevron_right_rounded,
                size: 27,
                color: Color(0xFF334DB3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilterBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _FilterBar({
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const labels = [
      '✓  All',
      'Ready',
      'Needs Review',
    ];

    return Row(
      children: List.generate(
        labels.length,
        (index) {
          final selected = selectedIndex == index;

          return Padding(
            padding: EdgeInsets.only(
              right: index == labels.length - 1 ? 0 : 13,
            ),
            child: GestureDetector(
              onTap: () => onSelected(index),
              child: Container(
                height: 57,
                padding: const EdgeInsets.symmetric(horizontal: 28),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFD7E1FF)
                      : const Color(0xFFE8E8ED),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index == 2)
                      Container(
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFC71919),
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        color: selected
                            ? const Color(0xFF111216)
                            : const Color(0xFF202126),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PatientCard extends StatelessWidget {
  final _Patient patient;
  final VoidCallback onTap;

  const _PatientCard({
    required this.patient,
    required this.onTap,
  });

  Color get statusBackground {
    switch (patient.statusType) {
      case _PatientStatus.ready:
        return const Color(0xFFD4DFFF);
      case _PatientStatus.review:
        return const Color(0xFFFFD4D0);
      case _PatientStatus.processing:
        return const Color(0xFFE5E5EA);
    }
  }

  Color get statusForeground {
    switch (patient.statusType) {
      case _PatientStatus.ready:
        return const Color(0xFF304A9E);
      case _PatientStatus.review:
        return const Color(0xFFB71C1C);
      case _PatientStatus.processing:
        return const Color(0xFF454652);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 195,
        padding: const EdgeInsets.fromLTRB(21, 21, 17, 20),
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDF1),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Row(
              children: [
                _PatientAvatar(patient: patient),
                const SizedBox(width: 22),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.name,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 25,
                          color: Color(0xFF111216),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        patient.details,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          color: Color(0xFF454652),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  patient.time,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 17,
                    color: patient.statusType == _PatientStatus.review
                        ? const Color(0xFFC71919)
                        : const Color(0xFF343640),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: statusBackground,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        patient.statusType == _PatientStatus.ready
                            ? Icons.verified_outlined
                            : patient.statusType == _PatientStatus.review
                                ? Icons.error_outline
                                : Icons.more_horiz,
                        size: 20,
                        color: statusForeground,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        patient.status,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: statusForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (_) {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Color(0xFFB8B8C4),
                    size: 29,
                  ),
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'view',
                      child: Text('View patient'),
                    ),
                    PopupMenuItem(
                      value: 'review',
                      child: Text('Review records'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientAvatar extends StatelessWidget {
  final _Patient patient;

  const _PatientAvatar({
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    if (patient.image == null) {
      return Container(
        width: 86,
        height: 86,
        decoration: const BoxDecoration(
          color: Color(0xFF5368AD),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            'SJ',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 23,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: 43,
      backgroundImage: NetworkImage(patient.image!),
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
            final selected = selectedIndex == index;

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