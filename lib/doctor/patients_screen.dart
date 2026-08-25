import 'package:flutter/material.dart';

class DoctorPatientsScreen extends StatefulWidget {
  const DoctorPatientsScreen({super.key});

  @override
  State<DoctorPatientsScreen> createState() => _DoctorPatientsScreenState();
}

class _DoctorPatientsScreenState extends State<DoctorPatientsScreen> {
  final TextEditingController patientIdController = TextEditingController();

  @override
  void dispose() {
    patientIdController.dispose();
    super.dispose();
  }

  void _lookupPatient() {
    if (patientIdController.text.trim().isEmpty) {
      return;
    }

    Navigator.pushNamed(context, '/doctor/patient');
  }

  void _navigate(int index) {
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
  }

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
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _ScannerArea(),
                    const SizedBox(height: 37),
                    const Text(
                      'Or enter manually',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22,
                        color: Color(0xFF111216),
                      ),
                    ),
                    const SizedBox(height: 19),
                    _PatientIdField(
                      controller: patientIdController,
                    ),
                    const SizedBox(height: 22),
                    _LookupButton(
                      onPressed: _lookupPatient,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _DoctorNavigationBar(
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

class _ScannerArea extends StatelessWidget {
  const _ScannerArea();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 496,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFB9BDE0),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Icon(
                    Icons.qr_code_2,
                    size: 82,
                    color: Color(0xFFC3C4CF),
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
              height: 1,
              color: const Color(0xFF7584C8),
            ),
          ),
          Positioned(
            left: 22,
            right: 22,
            bottom: 22,
            child: _PatientPreviewCard(),
          ),
        ],
      ),
    );
  }
}

class _PatientPreviewCard extends StatelessWidget {
  const _PatientPreviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFF),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: const BoxDecoration(
                  color: Color(0xFF5E70CE),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'RK',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rahul Kumar',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 21,
                        color: Color(0xFF111216),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'ID: 8492-491-A',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        color: Color(0xFF454652),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.check_circle_outline,
                size: 31,
                color: Color(0xFF3857C2),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 66,
            child: FilledButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/doctor/patient',
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF4D5FBE),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Patient File',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 13),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 29,
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

class _PatientIdField extends StatelessWidget {
  final TextEditingController controller;

  const _PatientIdField({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      decoration: const BoxDecoration(
        color: Color(0xFFEDEDF1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFB9B9C5),
            width: 1,
          ),
        ),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          color: Color(0xFF111216),
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(22, 16, 22, 12),
          border: InputBorder.none,
          labelText: 'Patient ID',
          labelStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 19,
            color: Color(0xFF454652),
          ),
          hintText: 'e.g. 1234-567-B',
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            color: Color(0xFF9899A5),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
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
      height: 73,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(0xFFB4C7FF),
          foregroundColor: const Color(0xFF41568E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lookup Patient',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 21,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.search,
              size: 29,
            ),
          ],
        ),
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