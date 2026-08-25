import 'package:flutter/material.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FD),
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(36, 32, 36, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Greeting(),
                    const SizedBox(height: 42),
                    const _ConsultationCard(),
                    const SizedBox(height: 48),
                    const _AppointmentSection(),
                    const SizedBox(height: 48),
                    const _RecordsSection(),
                    const SizedBox(height: 100),
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
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 36),
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
            width: 58,
            height: 58,
            color: Colors.white,
            child: const Icon(
              Icons.medical_information_outlined,
              size: 34,
              color: Color(0xFF5E6EC8),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Patient Home',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 34,
              fontWeight: FontWeight.w400,
              color: Color(0xFF111216),
            ),
          ),
          const Spacer(),
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFFE2E2E6),
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=12',
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
          'Hello, Rahul 👋',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 42,
            fontWeight: FontWeight.w400,
            color: Color(0xFF111216),
            height: 1.15,
          ),
        ),
        SizedBox(height: 18),
        Text(
          "Let's prepare for your visit.",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Color(0xFF343640),
          ),
        ),
      ],
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  const _ConsultationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(44, 44, 44, 42),
      decoration: BoxDecoration(
        color: const Color(0xFF5E6EC8),
        borderRadius: BorderRadius.circular(42),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4454AD).withValues(alpha: 0.16),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  color: Color(0xFF4454AD),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.assignment_add,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 18),
              const Expanded(
                child: Text(
                  'Prepare for your\nconsultation',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 34),
          const Text(
            'Complete your health history to help Dr.\nSharma understand your symptoms better\nbefore your visit.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 19,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 38),
          SizedBox(
            width: double.infinity,
            height: 62,
            child: FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, '/patient/case');
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF4454AD),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start Case Taking',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 14),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentSection extends StatelessWidget {
  const _AppointmentSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming appointment',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 26,
            fontWeight: FontWeight.w400,
            color: Color(0xFF111216),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 24,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFEDEDF1),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: Color(0xFFB6C8FF),
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=47',
                ),
              ),
              const SizedBox(width: 24),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Ananya Sharma',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111216),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'General Practitioner',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        color: Color(0xFF454652),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7BA5),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Text(
                      'Today',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '10:20 AM',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF111216),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RecordsSection extends StatelessWidget {
  const _RecordsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Recent records',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 26,
                fontWeight: FontWeight.w400,
                color: Color(0xFF111216),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/patient/records');
              },
              child: const Text(
                'See all',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17,
                  color: Color(0xFF334DB3),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const _RecordCard(
          icon: Icons.science_outlined,
          title: 'Blood Test Results',
          subtitle: '12 Aug • Quest Diagnostics',
          status: 'Reviewed',
          iconColor: Color(0xFFB6C8FF),
          statusColor: Color(0xFF5E6EC8),
        ),
        const SizedBox(height: 18),
        const _RecordCard(
          icon: Icons.medical_services_outlined,
          title: 'Prescription Refill',
          subtitle: '08 Aug • Dr. Sharma',
          status: 'Active',
          iconColor: Color(0xFF6B7BA5),
          statusColor: Color(0xFFB6C8FF),
        ),
      ],
    );
  }
}

class _RecordCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final Color iconColor;
  final Color statusColor;

  const _RecordCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.iconColor,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F5),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
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
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF111216),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 17,
                    color: Color(0xFF454652),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                color: statusColor == const Color(0xFFB6C8FF)
                    ? const Color(0xFF415382)
                    : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientNavigationBar extends StatefulWidget {
  const _PatientNavigationBar();

  @override
  State<_PatientNavigationBar> createState() => _PatientNavigationBarState();
}

class _PatientNavigationBarState extends State<_PatientNavigationBar> {
  int selectedIndex = 0;

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
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });

                  if (index == 1) {
                    Navigator.pushNamed(context, '/patient/case');
                  }

                  if (index == 2) {
                    Navigator.pushNamed(context, '/patient/chat');
                  }

                  if (index == 3) {
                    Navigator.pushNamed(context, '/patient/records');
                  }

                  if (index == 4) {
                    Navigator.pushNamed(context, '/patient/profile');
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