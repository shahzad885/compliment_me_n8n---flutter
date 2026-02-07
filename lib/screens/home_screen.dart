import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/glass_container.dart';
import 'compliment_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _pickImage(
    BuildContext context,
    WidgetRef ref,
    ImageSource source,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null && context.mounted) {
        final imageFile = File(image.path);

        // Navigate to compliment screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComplimentScreen(imageFile: imageFile),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: const Color(0xFF0B2219), // Dark green snackbar
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // Deep dark green/crypto gradient
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0B2219), // Dark Green
              Color(0xFF05110E), // Darker Green
              Color(0xFF000000), // Black
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                const Text(
                  ' Compliment Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'Get AI-powered compliments that truly see you',
                  style: TextStyle(
                    color:
                        Colors.white.withOpacity(0.7), // Slightly dimmed white
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),

                // Camera Button
                GestureDetector(
                  onTap: () => _pickImage(context, ref, ImageSource.camera),
                  child: GlassContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Crypto App Green Accent
                            color: const Color(0xFF00D084).withOpacity(0.2),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Color(0xFF00D084), // Neon Green
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Take a Photo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Gallery Button
                GestureDetector(
                  onTap: () => _pickImage(context, ref, ImageSource.gallery),
                  child: GlassContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Crypto App Green Accent
                            color: const Color(0xFF00D084).withOpacity(0.2),
                          ),
                          child: const Icon(
                            Icons.photo_library,
                            color: Color(0xFF00D084), // Neon Green
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Choose from Gallery',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Footer
                Text(
                  'Your compliments are unique to you',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4), // Muted text
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
