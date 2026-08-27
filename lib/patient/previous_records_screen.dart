import 'package:flutter/material.dart';
import '../app/widgets/patient_navigation_bar.dart';

class PreviousRecordsScreen extends StatefulWidget {
  const PreviousRecordsScreen({super.key});

  @override
  State<PreviousRecordsScreen> createState() => _PreviousRecordsScreenState();
}

class _PreviousRecordsScreenState extends State<PreviousRecordsScreen> {
  final List<_Document> documents = [
    const _Document(
      name: 'Comprehensive Blood Report.pdf',
      size: '2.4 MB',
      type: _DocumentType.document,
    ),
    const _Document(
      name: 'Nirunjhana_DrSmith.jpg',
      size: '1.1 MB',
      type: _DocumentType.image,
    ),
  ];

  void _addDocument() {
    setState(() {
      documents.add(
        const _Document(
          name: 'New Medical Document.pdf',
          size: '1.8 MB',
          type: _DocumentType.document,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Intro(),
                    const SizedBox(height: 32),
                    _UploadArea(
                      onAddDocument: _addDocument,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Uploaded Documents',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 20),
                    ...documents.map(
                      (document) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _DocumentCard(
                          document: document,
                          onDelete: () {
                            setState(() {
                              documents.remove(document);
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PatientNavigationBar(
        selectedIndex: 3,
        onSelected: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(
                context,
                '/patient',
              );
              break;
            case 1:
              Navigator.pushReplacementNamed(
                context,
                '/patient/case',
              );
              break;
            case 2:
              Navigator.pushReplacementNamed(
                context,
                '/patient/chat',
              );
              break;
            case 3:
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
    );
  }
}

enum _DocumentType {
  document,
  image,
}

class _Document {
  final String name;
  final String size;
  final _DocumentType type;

  const _Document({
    required this.name,
    required this.size,
    required this.type,
  });
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.medical_information_outlined,
              color: colorScheme.onPrimaryContainer,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Patient Records',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
            ),
          ),
          CircleAvatar(
            radius: 23,
            backgroundColor: colorScheme.primaryContainer,
            foregroundColor: colorScheme.onPrimaryContainer,
            child: const Text(
              'N',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Previous Medical Records',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
                height: 1.15,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          'Uploading your past records helps us provide '
          'better care. Our system will automatically read '
          'and organize them.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
        ),
      ],
    );
  }
}

class _UploadArea extends StatelessWidget {
  final VoidCallback onAddDocument;

  const _UploadArea({
    required this.onAddDocument,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        child: Column(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.file_upload_outlined,
                color: colorScheme.onPrimaryContainer,
                size: 44,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Scan or upload a document',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'PDF, JPG, PNG up to 10MB',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: onAddDocument,
                icon: const Icon(Icons.add),
                label: const Text('Add document'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final _Document document;
  final VoidCallback onDelete;

  const _DocumentCard({
    required this.document,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isImage = document.type == _DocumentType.image;

    final iconBackground = isImage
        ? colorScheme.secondaryContainer
        : colorScheme.primaryContainer;

    final iconForeground = isImage
        ? colorScheme.onSecondaryContainer
        : colorScheme.onPrimaryContainer;

    return Card(
      margin: EdgeInsets.zero,
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                isImage
                    ? Icons.image_outlined
                    : Icons.description_outlined,
                size: 32,
                color: iconForeground,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        document.size,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Text(
                          '•',
                          style: TextStyle(
                            color: colorScheme.outline,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_circle_outline,
                        size: 18,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Processed',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'AI SCANNED',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const SizedBox(height: 14),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      onDelete();
                    }
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Remove'),
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