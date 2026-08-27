import 'package:flutter/material.dart';
import '../app/widgets/patient_navigation_bar.dart';

enum _InputMethod {
  speech,
  text,
  document,
}

class PatientCaseScreen extends StatefulWidget {
  const PatientCaseScreen({super.key});

  @override
  State<PatientCaseScreen> createState() => _PatientCaseScreenState();
}

class _PatientCaseScreenState extends State<PatientCaseScreen> {
  _InputMethod? _selectedInput;
  bool _isProcessing = false;
  bool _isListening = false;
  bool _isVerified = false;

  String _extractedText =
      'Persistent lower back pain for the past 2 weeks, worsening after prolonged sitting. Occasional sharp pain radiating to the left leg.';

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = _extractedText;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _selectInput(_InputMethod method) {
    setState(() {
      _selectedInput = method;
      _isListening = false;
      _isProcessing = false;
    });

    if (method == _InputMethod.speech) {
      _startSpeech();
    }

    if (method == _InputMethod.document) {
      _processDocument();
    }
  }

  Future<void> _startSpeech() async {
    setState(() {
      _isListening = true;
      _isProcessing = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isListening = false;
      _isProcessing = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isProcessing = false;
      _extractedText =
          'Persistent lower back pain for the past 2 weeks, worsening after prolonged sitting. Occasional sharp pain radiating to the left leg.';
      _textController.text = _extractedText;
    });
  }

  Future<void> _processDocument() async {
    setState(() {
      _isProcessing = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isProcessing = false;
      _extractedText =
          'Previous report indicates persistent lower back pain with occasional radiation to the left leg. Previous lumbar X-ray was attached for review.';
      _textController.text = _extractedText;
    });
  }

  void _openTextInput() {
    setState(() {
      _selectedInput = _InputMethod.text;
      _isListening = false;
      _isProcessing = false;
    });

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final colorScheme = Theme.of(sheetContext).colorScheme;

        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 8,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Describe your concern',
                style: Theme.of(sheetContext).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the information you would like to add to your case.',
                style: Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _textController,
                maxLines: 6,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Describe your symptoms, history or concerns...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _extractedText = _textController.text.trim().isEmpty
                          ? _extractedText
                          : _textController.text.trim();
                    });
                    Navigator.pop(sheetContext);
                  },
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Add information'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _editInformation() {
    _openTextInput();
  }

  void _submitHistory() {
    setState(() {
      _isVerified = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your information has been submitted for review.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        titleSpacing: 28,
        title: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.medical_information_outlined,
                color: colorScheme.onPrimaryContainer,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              'Patient Case',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 28),
            child: CircleAvatar(
              radius: 23,
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              child: const Text(
                'N',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                )
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Title(),
            const SizedBox(height: 24),
            _InputMethodsCard(
              selectedInput: _selectedInput,
              isListening: _isListening,
              isProcessing: _isProcessing,
              onSpeech: () => _selectInput(_InputMethod.speech),
              onText: _openTextInput,
              onDocument: () => _selectInput(_InputMethod.document),
            ),
            const SizedBox(height: 18),
            if (_isListening) ...[
              const _ListeningCard(),
              const SizedBox(height: 18),
            ],
            if (_isProcessing) ...[
              const _ProcessingCard(),
              const SizedBox(height: 18),
            ],
            _ExtractedInformationCard(
              text: _extractedText,
              source: _selectedInput,
              onEdit: _editInformation,
            ),
            const SizedBox(height: 18),
            const _ChiefComplaintCard(),
            const SizedBox(height: 18),
            const _MedicalHistoryCard(),
            const SizedBox(height: 18),
            const _MedicationsCard(),
            const SizedBox(height: 18),
            const _DocumentsCard(),
            const SizedBox(height: 18),
            _ReviewStatusCard(
              verified: _isVerified,
              onVerify: () {
                setState(() {
                  _isVerified = !_isVerified;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionBar(
            verified: _isVerified,
            onEdit: _editInformation,
            onSubmit: _submitHistory,
          ),
          PatientNavigationBar(
            selectedIndex: 1,
            onSelected: (index) {
              switch (index) {
                case 0:
                  Navigator.pushReplacementNamed(context, '/patient');
                  break;
                case 1:
                  break;
                case 2:
                  Navigator.pushReplacementNamed(context, '/patient/chat');
                  break;
                case 3:
                  Navigator.pushReplacementNamed(
                    context,
                    '/patient/records',
                  );
                  break;
                case 4:
                  Navigator.pushReplacementNamed(
                    context,
                    '/patient/profile',
                  );
                  break;
              }
            },
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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Build your medical history',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Share your information through speech, text, or previous medical documents.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
        ),
      ],
    );
  }
}

class _InputMethodsCard extends StatelessWidget {
  final _InputMethod? selectedInput;
  final bool isListening;
  final bool isProcessing;
  final VoidCallback onSpeech;
  final VoidCallback onText;
  final VoidCallback onDocument;

  const _InputMethodsCard({
    required this.selectedInput,
    required this.isListening,
    required this.isProcessing,
    required this.onSpeech,
    required this.onText,
    required this.onDocument,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How would you like to provide your information?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose the method that is most convenient for you.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 650;

                final children = [
                  _InputMethodTile(
                    icon: Icons.mic_none_rounded,
                    title: 'Speak',
                    subtitle: 'Describe your concern',
                    selected: selectedInput == _InputMethod.speech,
                    active: isListening,
                    onTap: onSpeech,
                  ),
                  _InputMethodTile(
                    icon: Icons.edit_outlined,
                    title: 'Type',
                    subtitle: 'Enter information',
                    selected: selectedInput == _InputMethod.text,
                    onTap: onText,
                  ),
                  _InputMethodTile(
                    icon: Icons.upload_file_outlined,
                    title: 'Upload',
                    subtitle: 'Previous medical report',
                    selected: selectedInput == _InputMethod.document,
                    active: isProcessing &&
                        selectedInput == _InputMethod.document,
                    onTap: onDocument,
                  ),
                ];

                if (isCompact) {
                  return Column(
                    children: [
                      children[0],
                      const SizedBox(height: 12),
                      children[1],
                      const SizedBox(height: 12),
                      children[2],
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: children[0]),
                    const SizedBox(width: 12),
                    Expanded(child: children[1]),
                    const SizedBox(width: 12),
                    Expanded(child: children[2]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InputMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final bool active;
  final VoidCallback onTap;

  const _InputMethodTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: selected
          ? colorScheme.secondaryContainer
          : colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: selected
                      ? colorScheme.primary
                      : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: active
                    ? Padding(
                        padding: const EdgeInsets.all(14),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: selected
                              ? colorScheme.onPrimary
                              : colorScheme.primary,
                        ),
                      )
                    : Icon(
                        icon,
                        color: selected
                            ? colorScheme.onPrimary
                            : colorScheme.onPrimaryContainer,
                      ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? colorScheme.onSecondaryContainer
                                    : colorScheme.onSurface,
                              ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: selected
                                ? colorScheme.onSecondaryContainer
                                : colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(
                  Icons.check_circle_rounded,
                  color: colorScheme.primary,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListeningCard extends StatelessWidget {
  const _ListeningCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.primaryContainer,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mic_rounded,
                color: colorScheme.onPrimary,
                size: 27,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Listening...',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Speak naturally about your symptoms or medical history.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProcessingCard extends StatelessWidget {
  const _ProcessingCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.secondaryContainer,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Processing information...',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSecondaryContainer,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _ProcessingStep(
              icon: Icons.text_fields_rounded,
              label: 'Converting input to text',
              completed: true,
            ),
            const SizedBox(height: 8),
            const _ProcessingStep(
              icon: Icons.psychology_outlined,
              label: 'Identifying clinical information',
              completed: false,
            ),
            const SizedBox(height: 8),
            const _ProcessingStep(
              icon: Icons.account_tree_outlined,
              label: 'Organizing patient history',
              completed: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProcessingStep extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool completed;

  const _ProcessingStep({
    required this.icon,
    required this.label,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          completed
              ? Icons.check_circle_rounded
              : Icons.radio_button_unchecked_rounded,
          size: 20,
          color: completed
              ? colorScheme.primary
              : colorScheme.onSecondaryContainer.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 10),
        Icon(
          icon,
          size: 19,
          color: colorScheme.onSecondaryContainer,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSecondaryContainer,
              ),
        ),
      ],
    );
  }
}

class _ExtractedInformationCard extends StatelessWidget {
  final String text;
  final _InputMethod? source;
  final VoidCallback onEdit;

  const _ExtractedInformationCard({
    required this.text,
    required this.source,
    required this.onEdit,
  });

  String get _sourceLabel {
    switch (source) {
      case _InputMethod.speech:
        return 'Speech';
      case _InputMethod.text:
        return 'Manual entry';
      case _InputMethod.document:
        return 'Medical document';
      case null:
        return 'Existing case information';
    }
  }

  IconData get _sourceIcon {
    switch (source) {
      case _InputMethod.speech:
        return Icons.mic_none_rounded;
      case _InputMethod.text:
        return Icons.edit_outlined;
      case _InputMethod.document:
        return Icons.description_outlined;
      case null:
        return Icons.medical_information_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.auto_awesome_outlined,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Information captured',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.onSurface,
                                ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            _sourceIcon,
                            size: 15,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Source: $_sourceLabel',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  tooltip: 'Edit information',
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.surfaceContainerHighest,
                  ),
                  icon: Icon(
                    Icons.edit_outlined,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.6,
                  ),
            ),
            const SizedBox(height: 20),
            Divider(color: colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text(
              'Structured information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 14),
            const _ExtractedItem(
              icon: Icons.sick_outlined,
              title: 'Symptoms',
              value: 'Lower back pain, occasional pain radiating to left leg',
            ),
            const SizedBox(height: 10),
            const _ExtractedItem(
              icon: Icons.schedule_outlined,
              title: 'Duration',
              value: '2 weeks',
            ),
            const SizedBox(height: 10),
            const _ExtractedItem(
              icon: Icons.warning_amber_outlined,
              title: 'Pattern',
              value: 'Worsens after prolonged sitting',
            ),
          ],
        ),
      ),
    );
  }
}

class _ExtractedItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ExtractedItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
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
                const SizedBox(height: 3),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
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

class _ReviewStatusCard extends StatelessWidget {
  final bool verified;
  final VoidCallback onVerify;

  const _ReviewStatusCard({
    required this.verified,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: verified
          ? colorScheme.primaryContainer
          : colorScheme.surfaceContainerLow,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            Icon(
              verified
                  ? Icons.verified_rounded
                  : Icons.fact_check_outlined,
              size: 30,
              color: verified
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    verified ? 'Information reviewed' : 'Review your information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: verified
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    verified
                        ? 'You have confirmed that the information is ready to submit.'
                        : 'Review the captured information before submitting your case.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: verified
                              ? colorScheme.onPrimaryContainer
                              : colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Switch(
              value: verified,
              onChanged: (_) => onVerify(),
            ),
          ],
        ),
      ),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: child,
      ),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: colorScheme.onPrimaryContainer,
            size: 25,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
          ),
        ),
        IconButton(
          onPressed: () {},
          tooltip: 'Edit',
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surfaceContainerHighest,
          ),
          icon: Icon(
            Icons.edit_outlined,
            color: colorScheme.onSurfaceVariant,
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
    final colorScheme = Theme.of(context).colorScheme;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            icon: Icons.medical_information_outlined,
            title: 'Chief Complaint',
          ),
          const SizedBox(height: 22),
          Text(
            'Persistent lower back pain for the past 2 weeks, worsening after prolonged sitting. Occasional sharp pain radiating to the left leg.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.65,
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
            children: const [
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
    final colorScheme = Theme.of(context).colorScheme;

    return Chip(
      avatar: Icon(
        Icons.check_circle_outline,
        size: 18,
        color: colorScheme.onSecondaryContainer,
      ),
      label: Text(text),
      backgroundColor: colorScheme.secondaryContainer,
      labelStyle: TextStyle(
        color: colorScheme.onSecondaryContainer,
        fontWeight: FontWeight.w500,
      ),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
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
        children: const [
          _SectionHeader(
            icon: Icons.medication_outlined,
            title: 'Current Medications',
          ),
          SizedBox(height: 18),
          _MedicationItem(
            icon: Icons.medication_outlined,
            name: 'Lisinopril',
            dosage: '10mg, Once daily',
          ),
          SizedBox(height: 12),
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
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surface,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: colorScheme.tertiaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: colorScheme.onTertiaryContainer,
                size: 28,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    dosage,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentsCard extends StatelessWidget {
  const _DocumentsCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            icon: Icons.description_outlined,
            title: 'Attached Documents',
          ),
          const SizedBox(height: 18),
          Card(
            margin: EdgeInsets.zero,
            color: colorScheme.surface,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      color: colorScheme.onPrimaryContainer,
                      size: 29,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Previous_XRay_Lumbar.jpg',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '2.4 MB • Ready for OCR',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    tooltip: 'View document',
                    icon: const Icon(Icons.open_in_new_outlined),
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

class _ActionBar extends StatelessWidget {
  final bool verified;
  final VoidCallback onEdit;
  final VoidCallback onSubmit;

  const _ActionBar({
    required this.verified,
    required this.onEdit,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 14, 28, 14),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_note_outlined),
                label: const Text('Edit Details'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton.icon(
                onPressed: verified ? onSubmit : null,
                icon: const Icon(Icons.send_outlined),
                label: Text(
                  verified ? 'Submit History' : 'Review to Submit',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}