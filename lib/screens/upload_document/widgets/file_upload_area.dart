import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FileUploadArea extends StatelessWidget {
  final VoidCallback onTap;
  final String? fileName;

  const FileUploadArea({super.key, required this.onTap, this.fileName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blueAccent.withOpacity(0.3),
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (fileName != null) ...[
              const Icon(Icons.check_circle, size: 60, color: Colors.green),
              const SizedBox(height: 15),
              Text(
                fileName!,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Tap to change',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ] else ...[
              const Icon(
                Icons.cloud_upload_outlined,
                size: 60,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 15),
              Text(
                'Drag & Drop or Click to Upload',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                'PDF, Word, PPT, Images',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
