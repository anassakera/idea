import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea/screens/upload_document/provider/upload_provider.dart';

class UploadSettingsForm extends StatelessWidget {
  const UploadSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Lesson Name',
                prefixIcon: const Icon(Icons.edit_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: provider.selectedSubject,
              items: provider.subjects.map((String subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
              onChanged: provider.setSubject,
              decoration: InputDecoration(
                labelText: 'Subject',
                prefixIcon: const Icon(Icons.book_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Number of Questions: ${provider.questionCount.round()}',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            Slider(
              value: provider.questionCount,
              min: 5,
              max: 50,
              divisions: 9,
              label: provider.questionCount.round().toString(),
              onChanged: provider.setQuestionCount,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: provider.difficulty,
              items: provider.difficulties.map((String diff) {
                return DropdownMenuItem<String>(value: diff, child: Text(diff));
              }).toList(),
              onChanged: provider.setDifficulty,
              decoration: InputDecoration(
                labelText: 'Difficulty',
                prefixIcon: const Icon(Icons.speed),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Question Types',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            ...provider.questionTypes.keys.map((key) {
              return CheckboxListTile(
                title: Text(key),
                value: provider.questionTypes[key],
                onChanged: (val) => provider.toggleQuestionType(key, val),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              );
            }),
          ],
        );
      },
    );
  }
}
