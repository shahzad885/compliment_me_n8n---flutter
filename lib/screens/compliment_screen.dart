import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/compliment_provider.dart';
import '../widgets/compliment_card.dart';
import '../widgets/glass_container.dart';

class ComplimentScreen extends ConsumerStatefulWidget {
  final File imageFile;

  const ComplimentScreen({
    super.key,
    required this.imageFile,
  });

  @override
  ConsumerState<ComplimentScreen> createState() => _ComplimentScreenState();
}

class _ComplimentScreenState extends ConsumerState<ComplimentScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch compliments when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(complimentProvider.notifier).fetchCompliments(widget.imageFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(complimentProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // Matching Crypto Gradient
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0B2219),
              Color(0xFF05110E),
              Color(0xFF000000),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const GlassContainer(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Your Compliments',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),

              // Content
              Expanded(
                child: _buildContent(state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ComplimentState state) {
    if (state.isLoading) {
      return _buildLoading();
    }

    if (state.error != null) {
      return _buildError(state.error!);
    }

    if (state.response != null && state.response!.compliments.isNotEmpty) {
      return _buildCompliments(state.response!.compliments);
    }

    return const Center(
      child: Text(
        'No compliments available',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlassContainer(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF00D084)), // Neon Green
                  strokeWidth: 3,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Analyzing your amazing self...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Finding what makes you uniquely you',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.redAccent, // Keep error distinct
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(complimentProvider.notifier)
                      .fetchCompliments(widget.imageFile);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D084), // Green Button
                  foregroundColor: Colors.black, // Black text for contrast
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompliments(List<String> compliments) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Image preview
          GlassContainer(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(bottom: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                widget.imageFile,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Compliments header
          const Text(
            'What makes you special:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Compliment cards
          ...compliments.asMap().entries.map(
                (entry) => ComplimentCard(
                  compliment: entry.value,
                  index: entry.key,
                ),
              ),

          const SizedBox(height: 24),

          // Try again button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const GlassContainer(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Try Another Photo',
                style: TextStyle(
                  color: Color(0xFF00D084), // Neon Green Text
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
