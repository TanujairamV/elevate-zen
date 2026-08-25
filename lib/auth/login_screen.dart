import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  int selectedNavigationIndex = 0;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FD),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(colorScheme),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(26, 34, 26, 24),
                child: Column(
                  children: [
                    const SizedBox(height: 215),
                    _buildBrand(colorScheme),
                    const SizedBox(height: 238),
                    _buildLoginForm(colorScheme),
                    const SizedBox(height: 26),
                    _buildDivider(colorScheme),
                    const SizedBox(height: 30),
                    _buildCreateAccount(colorScheme),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
            _buildBottomNavigation(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 27),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FD),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.surfaceContainer,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            child: const Icon(
              Icons.medical_information_outlined,
              size: 27,
              color: Color(0xFF5E6EC8),
            ),
          ),
          const SizedBox(width: 11),
          const Text(
            'Patient Home',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 29,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1,
            ),
          ),
          const Spacer(),
          Container(
            width: 43,
            height: 43,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  'https://i.pravatar.cc/150?img=12',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrand(ColorScheme colorScheme) {
    return Column(
      children: [
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 47,
              height: 47,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF5E6EC8),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.medical_information_outlined,
                color: Color(0xFF5E6EC8),
                size: 31,
              ),
            ),
          ),
        ),
        const SizedBox(height: 34),
        const Text(
          'Elevate Zen',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 40,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Clearer history. Better care.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF292A35),
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Email or Phone',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xFF292A35),
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Enter your detail',
            prefixIcon: const Icon(
              Icons.person_outline,
              color: Color(0xFF383944),
              size: 27,
            ),
            filled: true,
            fillColor: const Color(0xFFEDEDF1),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFC6C5D4),
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFC6C5D4),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 23),
        const Text(
          'Password',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xFF292A35),
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: passwordController,
          obscureText: obscurePassword,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF383944),
              size: 27,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            filled: true,
            fillColor: const Color(0xFFEDEDF1),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFC6C5D4),
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFC6C5D4),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Forgot password?',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                color: Color(0xFF183CA8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          height: 68,
          child: FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF4D5FBE),
              foregroundColor: Colors.white,
              elevation: 2,
              shadowColor: Colors.black.withValues(alpha: 0.18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign in',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 12),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 27,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: colorScheme.outlineVariant,
            thickness: 1,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 23),
          child: Text(
            'OR',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Color(0xFF292A35),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: colorScheme.outlineVariant,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccount(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'New to Elevate Zen? ',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 17,
            color: Color(0xFF292A35),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Create account',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              color: Color(0xFF334DB3),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(ColorScheme colorScheme) {
    const items = [
      (Icons.home_outlined, 'Home'),
      (Icons.medical_services_outlined, 'Case'),
      (Icons.chat_bubble_outline, 'Chat'),
      (Icons.description_outlined, 'Records'),
      (Icons.account_circle_outlined, 'Profile'),
    ];

    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FD),
        border: Border(
          top: BorderSide(
            color: colorScheme.surfaceContainer,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: List.generate(
          items.length,
          (index) {
            final selected = selectedNavigationIndex == index;
            final item = items[index];

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedNavigationIndex = index;
                  });
                },
                child: Container(
                  height: 68,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 4,
                  ),
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
                        size: 26,
                        color: const Color(0xFF292A35),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.$2,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight:
                              selected ? FontWeight.w500 : FontWeight.w400,
                          color: const Color(0xFF292A35),
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