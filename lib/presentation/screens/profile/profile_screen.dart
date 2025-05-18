// lib/presentation/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/core/utils/string_utils.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/theme_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/user_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_outlined_button.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_toggle_button.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../../core/router/app_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Load user data on screen initialization
    Future.microtask(() {
      ref.read(userStateProvider.notifier).loadCurrentUser();
    });
  }

  @override
  void dispose() {
    // Cleanup text controller
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final userState = ref.watch(userStateProvider);
    final userError = ref.watch(userErrorProvider);
    final isDark = ref.watch(isDarkModeProvider);

    // Set text field value when user data is loaded
    userState.whenData((user) {
      if (user != null && !_isEditing) {
        _displayNameController.text = user.displayName ?? user.username;
      }
    });

    return SltScaffold(
      appBar: const SltAppBar(title: 'My Profile', centerTitle: true),
      body: userState.when(
        data: (user) {
          if (user == null) {
            return _buildNotLoggedInState(context);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimens.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile avatar
                _buildProfileAvatar(user, theme, colorScheme),
                const SizedBox(height: AppDimens.spaceM),

                // Display name (editable)
                _isEditing
                    ? SltTextField(
                        controller: _displayNameController,
                        label: 'Display Name',
                        hint: 'Enter your display name',
                        prefixIcon: Icons.person,
                      )
                    : Text(
                        user.displayName ?? user.username,
                        style: theme.textTheme.headlineSmall,
                      ),
                const SizedBox(height: AppDimens.spaceXS),

                // Email
                Text(
                  user.email,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppDimens.spaceM),

                // Edit/Save button
                _buildEditButtons(user),

                // Display error if exists
                if (userError != null) ...[
                  const SizedBox(height: AppDimens.spaceM),
                  Text(
                    userError,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],

                // Divider
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppDimens.paddingL),
                  child: Divider(),
                ),

                // Settings section
                _buildSettingsSection(context, isDark),

                const SizedBox(height: AppDimens.spaceXL),

                // Logout button
                SltPrimaryButton(
                  text: 'Logout',
                  prefixIcon: Icons.logout,
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                  onPressed: _handleLogout,
                ),
              ],
            ),
          );
        },
        loading: () =>
            const SltLoadingStateWidget(message: 'Loading profile...'),
        error: (error, stack) => SltErrorStateWidget(
          title: 'Error Loading Profile',
          message: error.toString(),
          onRetry: () {
            ref.read(userStateProvider.notifier).loadCurrentUser();
          },
        ),
      ),
    );
  }

  // Build profile avatar with user initials
  Widget _buildProfileAvatar(user, ThemeData theme, ColorScheme colorScheme) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: colorScheme.primaryContainer,
      child: Text(
        StringUtils.getInitials(user.displayName ?? user.username),
        style: theme.textTheme.displayMedium?.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }

  // Build edit/save buttons based on edit state
  Widget _buildEditButtons(user) {
    return _isEditing
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SltOutlinedButton(
                text: 'Cancel',
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                    _displayNameController.text =
                        user.displayName ?? user.username;
                  });
                },
              ),
              const SizedBox(width: AppDimens.spaceM),
              SltPrimaryButton(
                text: 'Save',
                prefixIcon: Icons.save,
                onPressed: _saveProfile,
              ),
            ],
          )
        : SltOutlinedButton(
            text: 'Edit Profile',
            prefixIcon: Icons.edit,
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
          );
  }

  // Build "not logged in" state UI
  Widget _buildNotLoggedInState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Not logged in', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppDimens.spaceM),
          SltPrimaryButton(
            text: 'Log In',
            prefixIcon: Icons.login,
            onPressed: () {
              context.go(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }

  // Build settings section
  Widget _buildSettingsSection(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppDimens.spaceM),

        // Dark mode toggle
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingM),
            child: Row(
              children: [
                Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                const SizedBox(width: AppDimens.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dark Mode', style: textTheme.titleMedium),
                      Text(
                        'Toggle between light and dark theme',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                SltToggleButton(
                  toggleId: 'darkMode',
                  initialValue: isDark,
                  onChanged: (value) {
                    ref.read(themeStateProvider.notifier).setDarkMode(value);
                  },
                ),
              ],
            ),
          ),
        ),

        // Notifications settings
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingM),
            child: Row(
              children: [
                const Icon(Icons.notifications_outlined),
                const SizedBox(width: AppDimens.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Notifications', style: textTheme.titleMedium),
                      Text(
                        'Configure learning reminders',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    // Navigate to notifications settings
                    // context.push(AppRoutes.notificationSettings);
                  },
                ),
              ],
            ),
          ),
        ),

        // Account settings
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingM),
            child: Row(
              children: [
                const Icon(Icons.security_outlined),
                const SizedBox(width: AppDimens.spaceM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Account Security', style: textTheme.titleMedium),
                      Text(
                        'Change password and security settings',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    // Navigate to account settings
                    // context.push(AppRoutes.accountSettings);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Save profile changes
  Future<void> _saveProfile() async {
    if (_displayNameController.text.trim().isEmpty) {
      return;
    }

    final success = await ref
        .read(userStateProvider.notifier)
        .updateProfile(displayName: _displayNameController.text.trim());

    if (success) {
      setState(() {
        _isEditing = false;
      });
    }
  }

  // Handle logout with confirmation dialog
  Future<void> _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await ref.read(authStateProvider.notifier).logout();
      if (context.mounted) {
        context.go(AppRoutes.login);
      }
    }
  }
}
