import 'package:flutter/material.dart';
import '../app/widgets/patient_navigation_bar.dart';

class PatientChatScreen extends StatefulWidget {
  const PatientChatScreen({super.key});

  @override
  State<PatientChatScreen> createState() => _PatientChatScreenState();
}

class _PatientChatScreenState extends State<PatientChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      message:
          'Hello Nirunjhana. Tell me what brings you in today. You can type your symptoms, speak naturally, or add an old medical report.',
      isUser: false,
    ),
  ];

  bool _isListening = false;
  bool _isProcessing = false;
  bool _showHistory = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();

    if (message.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(
        _ChatMessage(
          message: message,
          isUser: true,
        ),
      );
      _messageController.clear();
    });

    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _messages.add(
          const _ChatMessage(
            message:
                'I have added that information to your current consultation history. You can continue describing any other symptoms, medical history, or test results.',
            isUser: false,
          ),
        );
      });

      _scrollToBottom();
    });
  }

  void _startVoiceInput() {
    if (_isListening) {
      return;
    }

    setState(() {
      _isListening = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _isListening = false;
        _messageController.text =
            'I have been experiencing headaches and tiredness for the past few days.';
      });
    });
  }

  void _openDocumentSheet() {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: colorScheme.surface,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add medical document',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Upload an old medical report so its information can be organized into your history.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                ),
                const SizedBox(height: 20),
                _DocumentOption(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'Medical report',
                  subtitle: 'Previous report or prescription',
                  onTap: () {
                    Navigator.pop(context);
                    _simulateUpload('Previous Medical Report.pdf');
                  },
                ),
                const SizedBox(height: 10),
                _DocumentOption(
                  icon: Icons.image_outlined,
                  title: 'Report image',
                  subtitle: 'Photo or scanned medical document',
                  onTap: () {
                    Navigator.pop(context);
                    _simulateUpload('Medical Report.jpg');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _simulateUpload(String fileName) {
    setState(() {
      _messages.add(
        _ChatMessage(
          message: 'Medical document uploaded',
          isUser: true,
          attachment: fileName,
        ),
      );
      _isProcessing = true;
    });

    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1700), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _isProcessing = false;
        _messages.add(
          const _ChatMessage(
            message:
                'The document has been processed. Relevant information can now be organized into your clinical history for doctor review.',
            isUser: false,
          ),
        );
      });

      _scrollToBottom();
    });
  }

  void _toggleHistory() {
    setState(() {
      _showHistory = !_showHistory;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _navigate(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/patient');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/patient/case');
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/patient/records');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/patient/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.auto_awesome_outlined,
                color: colorScheme.onPrimaryContainer,
                size: 23,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health Assistant',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Ready',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'More options',
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSafetyBanner(colorScheme),
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                ..._messages.map(
                  (message) => _buildMessage(
                    message,
                    colorScheme,
                  ),
                ),
                if (_isProcessing) _buildProcessing(colorScheme),
                _buildHistoryCard(colorScheme),
              ],
            ),
          ),
          _buildComposer(colorScheme),
        ],
      ),
      bottomNavigationBar: PatientNavigationBar(
        selectedIndex: 2,
        onSelected: _navigate,
      ),
    );
  }

  Widget _buildSafetyBanner(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 7),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.verified_user_outlined,
            size: 19,
            color: colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'AI organizes your information for doctor review. It does not replace the final medical record.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSecondaryContainer,
                    height: 1.35,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(
    _ChatMessage message,
    ColorScheme colorScheme,
  ) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        margin: EdgeInsets.only(
          left: isUser ? 45 : 0,
          right: isUser ? 0 : 45,
          bottom: 12,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUser
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 6),
            bottomRight: Radius.circular(isUser ? 6 : 20),
          ),
          border: isUser
              ? null
              : Border.all(
                  color: colorScheme.outlineVariant,
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser)
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 15,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Elevate Zen',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            Text(
              message.message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isUser
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurface,
                    height: 1.4,
                  ),
            ),
            if (message.attachment != null) ...[
              const SizedBox(height: 12),
              _buildAttachment(
                message.attachment!,
                colorScheme,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAttachment(
    String fileName,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.description_outlined,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Uploaded successfully',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: colorScheme.primary,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildProcessing(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Analyzing document',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Extracting relevant information…',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(ColorScheme colorScheme) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(
        top: 4,
        bottom: 8,
      ),
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    Icons.timeline_outlined,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Clinical history',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Structured patient information',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _toggleHistory,
                  icon: Icon(
                    _showHistory
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ),
              ],
            ),
            if (_showHistory) ...[
              const SizedBox(height: 14),
              Divider(
                color: colorScheme.outlineVariant,
              ),
              const SizedBox(height: 15),
              _HistoryItem(
                icon: Icons.sick_outlined,
                title: 'Symptoms',
                value: 'Headache and tiredness',
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 14),
              _HistoryItem(
                icon: Icons.history_outlined,
                title: 'Medical history',
                value: 'No information added yet',
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 14),
              _HistoryItem(
                icon: Icons.science_outlined,
                title: 'Test results',
                value: 'No results added yet',
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      size: 20,
                      color: colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        'Doctor verification is required before this information becomes part of the final medical record.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onErrorContainer,
                              height: 1.35,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildComposer(ColorScheme colorScheme) {
    return Material(
      color: colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            13,
            8,
            13,
            10,
          ),
          child: Column(
            children: [
              if (_isListening)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.mic,
                        color: colorScheme.onPrimaryContainer,
                        size: 20,
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'Listening… speak naturally',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      SizedBox(
                        width: 17,
                        height: 17,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton.filledTonal(
                    tooltip: 'Upload medical document',
                    onPressed: _openDocumentSheet,
                    icon: const Icon(
                      Icons.attach_file,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        hintText: 'Describe your symptoms…',
                        prefixIcon: const Icon(
                          Icons.chat_bubble_outline,
                        ),
                        suffixIcon: IconButton(
                          tooltip: 'Voice input',
                          onPressed:
                              _isListening ? null : _startVoiceInput,
                          icon: Icon(
                            _isListening
                                ? Icons.mic
                                : Icons.mic_none_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  IconButton.filled(
                    tooltip: 'Send',
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.arrow_upward_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                'Type, speak, or upload a previous medical report',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String message;
  final bool isUser;
  final String? attachment;

  const _ChatMessage({
    required this.message,
    required this.isUser,
    this.attachment,
  });
}

class _DocumentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DocumentOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      tileColor: colorScheme.surfaceContainerLow,
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(
        Icons.chevron_right,
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final ColorScheme colorScheme;

  const _HistoryItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}