import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// Clean dashboard screen displayed after successful login.
class HomeView extends StatelessWidget {
  const HomeView({
    required this.userEmail,
    required this.onLogout,
    super.key,
  });

  final String userEmail;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 72,
                color: AppColors.success,
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome Back!',
                style: AppTextStyles.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                userEmail,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              AppButton(
                text: 'Log Out',
                onPressed: onLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
