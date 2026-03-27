import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/subjects_data.dart';
import 'questions_list_screen.dart';

class QuestionFilterScreen extends StatefulWidget {
  final Subject subject;
  const QuestionFilterScreen({super.key, required this.subject});

  @override
  State<QuestionFilterScreen> createState() => _QuestionFilterScreenState();
}

class _QuestionFilterScreenState extends State<QuestionFilterScreen> {
  int _selectedGrade = 12;
  int _selectedYear = 2023;
  String? _selectedChapter;

  final List<int> _grades = [9, 10, 11, 12];
  final List<int> _years =
      List.generate(10, (i) => 2024 - i); // 2024 down to 2015

  @override
  Widget build(BuildContext context) {
    final subject = widget.subject;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F8),
      appBar: AppBar(
        title: Text(subject.name),
        leading: const BackButton(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header banner ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            decoration: BoxDecoration(
              color: subject.color,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(subject.emoji,
                      style: const TextStyle(fontSize: 32)),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${subject.chapters.length} chapters available',
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // --- Filter form ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Questions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Grade
                  _buildLabel('Grade Level'),
                  const SizedBox(height: 8),
                  Row(
                    children: _grades.map((g) {
                      final selected = g == _selectedGrade;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedGrade = g),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: selected ? subject.color : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Text(
                            'Grade $g',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: selected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Year
                  _buildLabel('Exam Year'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _selectedYear,
                        isExpanded: true,
                        items: _years
                            .map((y) => DropdownMenuItem(
                                value: y, child: Text('$y E.C.')))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedYear = v!),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Chapter
                  _buildLabel('Chapter'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedChapter,
                        isExpanded: true,
                        hint: const Text('Select a chapter'),
                        items: subject.chapters
                            .map((c) => DropdownMenuItem(
                                value: c, child: Text(c)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedChapter = v),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // CTA button
                  ElevatedButton.icon(
                    onPressed: _selectedChapter == null
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuestionsListScreen(
                                  subject: widget.subject,
                                  grade: _selectedGrade,
                                  year: _selectedYear,
                                  chapter: _selectedChapter!,
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: subject.color,
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    icon: const Icon(Icons.search),
                    label: const Text('Find Questions'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}
