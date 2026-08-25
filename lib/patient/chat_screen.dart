import 'package:flutter/material.dart';

class PatientChatScreen extends StatefulWidget {
  const PatientChatScreen({super.key});

  @override
  State<PatientChatScreen> createState() => _PatientChatScreenState();
}

class _PatientChatScreenState extends State<PatientChatScreen> {
  int selectedIndex = 2;

  final List<_ChatMessage> messages = [
    const _ChatMessage(
      text: "Hi Rahul. I'm reviewing your latest lipid panel. How can I help you today?",
      isUser: false,
    ),
    const _ChatMessage(
      text: 'What does this report mean? Are my triglycerides too high?',
      isUser: true,
    ),
  ];

  void _sendQuickMessage(String text) {
    setState(() {
      messages.add(
        _ChatMessage(
          text: text,
          isUser: true,
        ),
      );
    });
  }

  void _navigate(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/patient');
        break;
      case 1:
        Navigator.pushNamed(context, '/patient/case');
        break;
      case 2:
        break;
      case 3:
        Navigator.pushNamed(context, '/patient/records');
        break;
      case 4:
        Navigator.pushNamed(context, '/patient/profile');
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
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(26, 30, 26, 20),
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return const _TypingIndicator();
                        }

                        return _MessageBubble(
                          message: messages[index],
                        );
                      },
                    ),
                  ),
                  _QuickActions(
                    onSelected: _sendQuickMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNavigationBar(
        selectedIndex: selectedIndex,
        onSelected: _navigate,
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  const _ChatMessage({
    required this.text,
    required this.isUser,
  });
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
          const SizedBox(width: 12),
          const Text(
            'Patient Chat',
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

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;

  const _MessageBubble({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (message.isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 70,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 6, bottom: 7),
                child: Text(
                  'You',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    color: Color(0xFF292A35),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF4D5FBE),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(3),
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    height: 1.4,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFF5E6EC8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.smart_toy_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'Elevate Assistant',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  color: Color(0xFF292A35),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 21,
              vertical: 20,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFEDEDF1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(22),
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Text(
              message.text,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                height: 1.55,
                color: Color(0xFF17181C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 36),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEDEDF1),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Dot(),
            _Dot(),
            _Dot(),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: const BoxDecoration(
        color: Color(0xFF9AA8D8),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final ValueChanged<String> onSelected;

  const _QuickActions({
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 26),
        children: [
          _ActionChip(
            icon: Icons.trending_up_rounded,
            label: 'Analyze Trends',
            onTap: () => onSelected(
              'Can you analyze my health trends?',
            ),
          ),
          _ActionChip(
            icon: Icons.restaurant_menu_outlined,
            label: 'Diet Tips',
            onTap: () => onSelected(
              'Can you give me some diet tips?',
            ),
          ),
          _ActionChip(
            icon: Icons.access_time_rounded,
            label: 'Next Appointment',
            onTap: () => onSelected(
              'When is my next appointment?',
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ActionChip(
        onPressed: onTap,
        avatar: Icon(
          icon,
          size: 22,
          color: const Color(0xFF334DB3),
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            color: Color(0xFF17181C),
          ),
        ),
        backgroundColor: const Color(0xFFEDEDF1),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _BottomNavigationBar({
    required this.selectedIndex,
    required this.onSelected,
  });

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
            final selected = selectedIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => onSelected(index),
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