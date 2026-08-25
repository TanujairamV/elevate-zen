import 'package:flutter/material.dart';

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
      name: 'Prescription_DrSmith.jpg',
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
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FD),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(32, 56, 32, 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Intro(),
                    const SizedBox(height: 38),
                    _UploadArea(
                      onAddDocument: _addDocument,
                    ),
                    const SizedBox(height: 54),
                    const Text(
                      'Uploaded Documents',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF111216),
                      ),
                    ),
                    const SizedBox(height: 26),
                    ...documents.map(
                      (document) => Padding(
                        padding: const EdgeInsets.only(bottom: 22),
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
            'Patient Case',
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

class _Intro extends StatelessWidget {
  const _Intro();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Previous Medical Records',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 35,
            fontWeight: FontWeight.w400,
            color: Color(0xFF111216),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Uploading your past records helps us provide\nbetter care. Our system will automatically read and\norganize them.',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            height: 1.55,
            color: Color(0xFF454652),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 38,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FA),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFC7C8D8),
          width: 3,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 102,
            height: 102,
            decoration: const BoxDecoration(
              color: Color(0xFF5E70CE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.file_upload_outlined,
              color: Colors.white,
              size: 47,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Scan or upload a document',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Color(0xFF111216),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'PDF, JPG, PNG up to 10MB',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 17,
              color: Color(0xFF454652),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 60,
            child: FilledButton.icon(
              onPressed: onAddDocument,
              icon: const Icon(
                Icons.add,
                size: 29,
              ),
              label: const Text(
                'Add document',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF4D5FBE),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
        ],
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
    final isImage = document.type == _DocumentType.image;

    return Container(
      width: double.infinity,
      height: 146,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDF1),
        borderRadius: BorderRadius.circular(24),
        border: const Border(
          left: BorderSide(
            color: Color(0xFF5066B9),
            width: 5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: isImage
                  ? const Color(0xFFE2E2E7)
                  : const Color(0xFFB9CBFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              isImage
                  ? Icons.image_outlined
                  : Icons.description_outlined,
              size: 39,
              color: const Color(0xFF5066B9),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 19,
                    color: Color(0xFF111216),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      document.size,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Color(0xFF454652),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9),
                      child: Text(
                        '•',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFB6B6C0),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.check_circle_outline,
                      size: 19,
                      color: Color(0xFF3857C2),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Processed',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Color(0xFF3857C2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7BA5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'AI SCANNED',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    onDelete();
                  }
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Color(0xFF393A44),
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
          padding: const EdgeInsets.fromLTRB(32, 18, 32, 20),
          color: const Color(0xFFF9F9FD),
          child: SizedBox(
            width: double.infinity,
            height: 62,
            child: FilledButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/patient/case',
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF4D5FBE),
                foregroundColor: Colors.white,
                elevation: 3,
                shadowColor: Colors.black.withValues(
                  alpha: 0.18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue to Review',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 29,
                  ),
                ],
              ),
            ),
          ),
        ),
        const _PatientNavigationBar(),
      ],
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
            final selected = index == 1;

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
                      break;
                    case 2:
                      Navigator.pushNamed(
                        context,
                        '/patient/chat',
                      );
                    case 3:
                      Navigator.pushNamed(
                        context,
                        '/patient/records',
                      );
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