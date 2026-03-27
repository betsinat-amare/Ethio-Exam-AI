import 'package:flutter/material.dart';

enum SubjectStream { common, natural, social }

class Subject {
  final String name;
  final String emoji;
  final Color color;
  final List<String> chapters;
  final SubjectStream stream;

  const Subject({
    required this.name,
    required this.emoji,
    required this.color,
    required this.chapters,
    required this.stream,
  });
}

class ExamQuestion {
  final String question;
  final List<String> choices;
  final int correctIndex;
  final String explanation;
  final String subject;
  final int grade;
  final int year;
  final String chapter;

  const ExamQuestion({
    required this.question,
    required this.choices,
    required this.correctIndex,
    required this.explanation,
    required this.subject,
    required this.grade,
    required this.year,
    required this.chapter,
  });
}

class SubjectsData {
  static const List<Subject> subjects = [
    Subject(
      name: 'Mathematics',
      emoji: '📐',
      color: Color(0xFF1A237E),
      chapters: [
        'Algebra', 'Geometry', 'Trigonometry',
        'Calculus', 'Statistics', 'Probability',
      ],
      stream: SubjectStream.common,
    ),
    Subject(
      name: 'Physics',
      emoji: '⚛️',
      color: Color(0xFF1565C0),
      chapters: [
        'Mechanics', 'Thermodynamics', 'Waves & Optics',
        'Electricity', 'Magnetism', 'Modern Physics',
      ],
      stream: SubjectStream.natural,
    ),
    Subject(
      name: 'Chemistry',
      emoji: '🧪',
      color: Color(0xFF2E7D32),
      chapters: [
        'Atomic Structure', 'Chemical Bonding', 'Stoichiometry',
        'Acids & Bases', 'Organic Chemistry', 'Electrochemistry',
      ],
      stream: SubjectStream.natural,
    ),
    Subject(
      name: 'Biology',
      emoji: '🧬',
      color: Color(0xFF388E3C),
      chapters: [
        'Cell Biology', 'Genetics', 'Evolution',
        'Ecology', 'Human Physiology', 'Plant Biology',
      ],
      stream: SubjectStream.natural,
    ),
    Subject(
      name: 'English',
      emoji: '📖',
      color: Color(0xFF6A1B9A),
      chapters: [
        'Reading Comprehension', 'Grammar', 'Vocabulary',
        'Writing Skills', 'Literature', 'Communication',
      ],
      stream: SubjectStream.common,
    ),
    Subject(
      name: 'Civics',
      emoji: '🏛️',
      color: Color(0xFF00695C),
      chapters: [
        'Ethiopian Constitution', 'Democracy & Governance',
        'Human Rights', 'Federal System', 'International Relations',
      ],
      stream: SubjectStream.common,
    ),
    Subject(
      name: 'History',
      emoji: '🗺️',
      color: Color(0xFF4E342E),
      chapters: [
        'Ancient Ethiopia', 'Medieval Period', 'Modern Period',
        'African History', 'World History', 'Independence Movements',
      ],
      stream: SubjectStream.social,
    ),
    Subject(
      name: 'Geography',
      emoji: '🌍',
      color: Color(0xFF00838F),
      chapters: [
        'Physical Geography', 'Human Geography', 'Climate',
        'Ethiopian Geography', 'Economic Geography', 'Maps & Cartography',
      ],
      stream: SubjectStream.social,
    ),
  ];

  static List<ExamQuestion> getQuestions({
    required String subject,
    required int grade,
    required int year,
    required String chapter,
  }) {
    // Mocked questions — replace with real API call
    return [
      ExamQuestion(
        question: 'Which of the following best describes $chapter in $subject for Grade $grade?',
        choices: [
          'Option A — Foundational concept',
          'Option B — Advanced application',
          'Option C — Historical context',
          'Option D — Practical example',
        ],
        correctIndex: 0,
        explanation:
            'This is the correct answer because it directly relates to the core definition covered in the Grade $grade MOE textbook, Chapter "$chapter".',
        subject: subject,
        grade: grade,
        year: year,
        chapter: chapter,
      ),
      ExamQuestion(
        question: 'In the $year Ethiopian University Entrance Exam, which formula is most relevant to $chapter?',
        choices: [
          'Option A — E = mc²',
          'Option B — F = ma',
          'Option C — PV = nRT',
          'Option D — Ohm\'s Law',
        ],
        correctIndex: 1,
        explanation:
            'Option B is correct. This is consistent with the Grade $grade MOE curriculum standard for $subject.',
        subject: subject,
        grade: grade,
        year: year,
        chapter: chapter,
      ),
      ExamQuestion(
        question: 'What is the primary outcome studied in "$chapter" for Grade $grade $subject students?',
        choices: [
          'Option A — Classification of compounds',
          'Option B — Energy transformation',
          'Option C — Cellular respiration',
          'Option D — Newton\'s laws of motion',
        ],
        correctIndex: 2,
        explanation:
            'Option C aligns with the Ethiopian Ministry of Education textbook content for Grade $grade, $subject, "$chapter".',
        subject: subject,
        grade: grade,
        year: year,
        chapter: chapter,
      ),
    ];
  }
}
