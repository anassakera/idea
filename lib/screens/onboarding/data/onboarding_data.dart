class OnboardingContent {
  final String title;
  final String description;
  final String image;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnboardingContent> onboardingContents = [
  OnboardingContent(
    title: 'Scan & Learn',
    description:
        'Upload your study materials and let AI extract questions and answers for you.',
    image: 'assets/images/onboarding1.png', // Placeholder
  ),
  OnboardingContent(
    title: 'Smart Quizzes',
    description:
        'Generate personalized quizzes based on your documents to test your knowledge.',
    image: 'assets/images/onboarding2.png', // Placeholder
  ),
  OnboardingContent(
    title: 'Track Progress',
    description:
        'Monitor your performance and improve your weak areas with detailed analytics.',
    image: 'assets/images/onboarding3.png', // Placeholder
  ),
];
