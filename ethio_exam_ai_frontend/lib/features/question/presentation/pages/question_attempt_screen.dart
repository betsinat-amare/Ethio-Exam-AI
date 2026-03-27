import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../subjects/data/subjects_data.dart';

class QuestionAttemptScreen extends StatefulWidget {
  final ExamQuestion question;
  final Color subjectColor;
  final List<ExamQuestion> allQuestions;
  final int initialIndex;

  const QuestionAttemptScreen({
    super.key,
    required this.question,
    required this.subjectColor,
    required this.allQuestions,
    required this.initialIndex,
  });

  @override
  State<QuestionAttemptScreen> createState() => _QuestionAttemptScreenState();
}

class _QuestionAttemptScreenState extends State<QuestionAttemptScreen> {
  late int _currentIndex;
  int? _selectedChoice;
  bool _submitted = false;
  bool _explanationExpanded = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  ExamQuestion get _current => widget.allQuestions[_currentIndex];

  void _reset() {
    setState(() {
      _selectedChoice = null;
      _submitted = false;
      _explanationExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _current;
    final bool isCorrect = _submitted && _selectedChoice == q.correctIndex;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F8),
      appBar: AppBar(
        title: Text('${q.subject} · ${q.chapter}'),
        leading: const BackButton(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_currentIndex + 1} / ${widget.allQuestions.length}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar across top
          LinearProgressIndicator(
            value: (_currentIndex + 1) / widget.allQuestions.length,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(widget.subjectColor),
            minHeight: 4,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Year + Grade chips
                  Row(
                    children: [
                      _InfoChip('Grade ${q.grade}', Icons.school_outlined),
                      const SizedBox(width: 8),
                      _InfoChip('${q.year} E.C.', Icons.calendar_today_outlined),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Question text card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      q.question,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Choices
                  ...List.generate(q.choices.length, (i) {
                    return _ChoiceTile(
                      index: i,
                      text: q.choices[i],
                      selected: _selectedChoice == i,
                      submitted: _submitted,
                      correct: q.correctIndex == i,
                      color: widget.subjectColor,
                      onTap: _submitted
                          ? null
                          : () => setState(() => _selectedChoice = i),
                    );
                  }),

                  const SizedBox(height: 20),

                  // Submit or Next button
                  if (!_submitted)
                    ElevatedButton(
                      onPressed: _selectedChoice == null
                          ? null
                          : () => setState(() => _submitted = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.subjectColor,
                        disabledBackgroundColor: Colors.grey.shade300,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Submit Answer',
                          style: TextStyle(fontSize: 16)),
                    )
                  else ...[
                    // Result banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isCorrect
                            ? const Color(0xFFE8F5E9)
                            : const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isCorrect
                              ? AppColors.growthGreen
                              : AppColors.error,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCorrect
                                ? Icons.check_circle_outline
                                : Icons.cancel_outlined,
                            color: isCorrect
                                ? AppColors.growthGreen
                                : AppColors.error,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              isCorrect
                                  ? 'Correct! Well done 🎉'
                                  : 'Incorrect. The right answer is ${String.fromCharCode(65 + q.correctIndex)}.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: isCorrect
                                    ? AppColors.growthGreen
                                    : AppColors.error,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // AI Explanation panel
                    _ExplanationPanel(
                      explanation: q.explanation,
                      expanded: _explanationExpanded,
                      color: widget.subjectColor,
                      onToggle: () => setState(
                          () => _explanationExpanded = !_explanationExpanded),
                    ),
                    const SizedBox(height: 16),

                    // Navigation buttons
                    Row(
                      children: [
                        if (_currentIndex > 0)
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                setState(() => _currentIndex--);
                                _reset();
                              },
                              icon: const Icon(Icons.arrow_back_ios, size: 16),
                              label: const Text('Previous'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: widget.subjectColor,
                                side: BorderSide(color: widget.subjectColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                        if (_currentIndex > 0)
                          const SizedBox(width: 12),
                        if (_currentIndex < widget.allQuestions.length - 1)
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() => _currentIndex++);
                                _reset();
                              },
                              icon: const Icon(Icons.arrow_forward_ios,
                                  size: 16),
                              label: const Text('Next'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.subjectColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          )
                        else
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.flag_outlined, size: 18),
                              label: const Text('Finish'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.growthGreen,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _InfoChip(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  final int index;
  final String text;
  final bool selected;
  final bool submitted;
  final bool correct;
  final Color color;
  final VoidCallback? onTap;

  const _ChoiceTile({
    required this.index,
    required this.text,
    required this.selected,
    required this.submitted,
    required this.correct,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    Color borderColor = Colors.transparent;
    Color textColor = AppColors.textPrimary;
    IconData? trailingIcon;

    if (submitted) {
      if (correct) {
        bgColor = const Color(0xFFE8F5E9);
        borderColor = AppColors.growthGreen;
        textColor = AppColors.growthGreen;
        trailingIcon = Icons.check_circle;
      } else if (selected && !correct) {
        bgColor = const Color(0xFFFFEBEE);
        borderColor = AppColors.error;
        textColor = AppColors.error;
        trailingIcon = Icons.cancel;
      }
    } else if (selected) {
      borderColor = color;
      bgColor = color.withValues(alpha: 0.06);
      textColor = color;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: selected || (submitted && correct)
                    ? borderColor.withValues(alpha: 0.15)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selected || (submitted && correct)
                        ? borderColor
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  height: 1.4,
                ),
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(
                trailingIcon,
                color: correct ? AppColors.growthGreen : AppColors.error,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ExplanationPanel extends StatelessWidget {
  final String explanation;
  final bool expanded;
  final Color color;
  final VoidCallback onToggle;

  const _ExplanationPanel({
    required this.explanation,
    required this.expanded,
    required this.color,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, color: color, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Get AI Explanation',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    expanded ? Icons.expand_less : Icons.expand_more,
                    color: color,
                  ),
                ],
              ),
            ),
            if (expanded) ...[
              Divider(color: color.withValues(alpha: 0.2), height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Step-by-step Explanation:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      explanation,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.book_outlined,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Source: Ethiopian MoE Grade 9-12 Curriculum',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
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
}
