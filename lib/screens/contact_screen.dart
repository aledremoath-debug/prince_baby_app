import 'package:flutter/material.dart';
import 'package:prince_baby_app/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    final l = AppLocalizations.of(context)!;
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.fillAllFields), backgroundColor: Colors.red),
      );
      return;
    }
    setState(() => _submitted = true);
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.sendSuccess), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text(
                l.contactTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ).animate().fadeIn(),
              const SizedBox(height: 4),
              Text(
                l.contactDesc,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Contact info cards
              Row(
                children: [
                  _contactInfoCard(
                    Icons.location_on_outlined,
                    l.address,
                    'صنعاء - شارع الستين',
                    AppColors.primaryPink,
                  ),
                  const SizedBox(width: 10),
                  _contactInfoCard(
                    Icons.phone_outlined,
                    l.phone,
                    '+967 736 499 765',
                    AppColors.babyBlue,
                  ),
                ].map((w) => Expanded(child: w)).toList(),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 10),
              Row(
                children: [
                  _contactInfoCard(
                    Icons.email_outlined,
                    l.emailLabel,
                    'info@princebaby.com',
                    AppColors.softGreen,
                  ),
                  const SizedBox(width: 10),
                  _contactInfoCard(
                    Icons.schedule,
                    l.workingHours,
                    'السبت - الخميس\n8 ص - 6 م',
                    AppColors.gold,
                  ),
                ].map((w) => Expanded(child: w)).toList(),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 24),

              // Contact form
              if (_submitted)
                RepaintBoundary(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.softGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.softGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.softGreen.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: AppColors.softGreen,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l.sendSuccess,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => setState(() => _submitted = false),
                          child: Text(l.sendMessage),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9)),
                )
              else
                RepaintBoundary(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.formTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: l.nameLabel,
                            hintText: l.namePlaceholder,
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: l.emailLabel,
                            hintText: l.emailInputPlaceholder,
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _messageController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: l.messageLabel,
                            hintText: l.messagePlaceholder,
                            alignLabelWithHint: true,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(bottom: 60),
                              child: Icon(Icons.message_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton.icon(
                            onPressed: _submit,
                            icon: const Icon(Icons.send, size: 18),
                            label: Text(l.sendMessage),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                ),

              const SizedBox(height: 24),
              // Map placeholder
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(
                    'https://maps.google.com/?q=15.369,44.191',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.babyBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.babyBlue.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map_outlined,
                        size: 48,
                        color: AppColors.babyBlue,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '📍 صنعاء - شارع الستين',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'اضغط لفتح الخريطة',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryPink,
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 24),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _contactInfoCard(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
