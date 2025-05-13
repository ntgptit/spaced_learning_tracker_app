import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slt_app/core/constants/app_strings.dart';
import 'package:slt_app/core/di/dependency_injection.dart';
import 'package:slt_app/presentation/widgets/dialogs/slt_confirm_dialog.dart';
import 'package:slt_app/presentation/widgets/dialogs/slt_input_dialog.dart';
import 'package:slt_app/presentation/widgets/dialogs/slt_score_input_dialog_content.dart';
import 'package:slt_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:slt_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:slt_app/presentation/widgets/states/slt_loading_state_widget.dart';
import 'package:slt_app/presentation/widgets/states/slt_offline_state_widget.dart';
import 'package:slt_app/presentation/widgets/states/slt_unauthorized_state_widget.dart';

import '../../../core/services/slt_ui_notifier_service.dart';
import '../../../core/theme/app_dimens.dart';
import '../../viewmodels/home/home_viewmodel.dart';
import '../../widgets/common/slt_app_bar.dart';

/// Home screen
/// The main screen of the app
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final uiNotifier = DependencyInjection.locator<UiNotifierService>();

    return Scaffold(
      appBar: SltAppBar(
        title: AppStrings.appName,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              uiNotifier.showSnackBar(
                context,
                'Notifications tapped',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              uiNotifier.showSnackBar(
                context,
                'Settings tapped',
              );
            },
          ),
        ],
      ),
      body: homeState.when(
        loading: () => const SltLoadingStateWidget(
          message: 'Loading demo page...',
        ),
        error: (error, stackTrace) => SltErrorStateWidget(
          message: error.toString(),
          onRetry: () => ref.refresh(homeViewModelProvider),
        ),
        data: (data) => _buildHomeContent(context, ref),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    return SingleChildScrollView(
      padding: AppDimens.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'State Widgets Demo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppDimens.vGapL,

          // State widgets
          Wrap(
            spacing: AppDimens.gapM,
            runSpacing: AppDimens.gapM,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: SltLoadingStateWidget(
                          message: 'Loading...',
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Loading State'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: SltErrorStateWidget(
                          message: 'Something went wrong',
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Error State'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: SltEmptyStateWidget(
                          message: 'No data available',
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Empty State'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: SltOfflineStateWidget(
                          message: 'No internet connection',
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Offline State'),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: SltUnauthorizedStateWidget(
                          message:
                              'You are not authorized to access this resource',
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Unauthorized State'),
              ),
            ],
          ),

          AppDimens.vGapXL,
          const Text(
            'Dialog Widgets Demo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppDimens.vGapL,

          // Dialog widgets
          Wrap(
            spacing: AppDimens.gapM,
            runSpacing: AppDimens.gapM,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await SltConfirmDialog.show(
                    context: context,
                    title: 'Confirm Action',
                    message: 'Are you sure you want to perform this action?',
                    confirmText: 'Yes, I\'m sure',
                    cancelText: 'No, cancel',
                    icon: Icons.warning_amber_rounded,
                  );

                  if (result == true) {
                    final uiNotifier =
                        DependencyInjection.locator<UiNotifierService>();
                    uiNotifier.showSnackBar(
                      context,
                      'Action confirmed!',
                      isSuccess: true,
                    );
                  }
                },
                child: const Text('Confirm Dialog'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await SltInputDialog.show(
                    context: context,
                    title: 'Enter your name',
                    hintText: 'John Doe',
                    labelText: 'Full Name',
                    icon: Icons.person,
                  );

                  if (result != null && result.isNotEmpty) {
                    final uiNotifier =
                        DependencyInjection.locator<UiNotifierService>();
                    uiNotifier.showSnackBar(
                      context,
                      'Hello, $result!',
                      isSuccess: true,
                    );
                  }
                },
                child: const Text('Input Dialog'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await SltScoreInputDialogContent.show(
                    context: context,
                    title: 'Rate this app',
                    maxScore: 5,
                    initialScore: 4,
                    commentsHint: 'Your feedback',
                  );

                  if (result != null) {
                    final uiNotifier =
                        DependencyInjection.locator<UiNotifierService>();
                    final score = result['score'] as double;
                    final comments = result['comments'] as String?;

                    uiNotifier.showSnackBar(
                      context,
                      'Rating: ${score.toInt()}/5${comments != null && comments.isNotEmpty ? '\nFeedback: $comments' : ''}',
                      isSuccess: true,
                    );
                  }
                },
                child: const Text('Score Input Dialog'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await SltConfirmDialog.show(
                    context: context,
                    title: 'Delete Item',
                    message:
                        'Are you sure you want to delete this item? This action cannot be undone.',
                    confirmText: 'Delete',
                    cancelText: 'Cancel',
                    isDestructive: true,
                    icon: Icons.delete_outline,
                  );

                  if (result == true) {
                    final uiNotifier =
                        DependencyInjection.locator<UiNotifierService>();
                    uiNotifier.showSnackBar(
                      context,
                      'Item deleted successfully',
                      isSuccess: true,
                    );
                  }
                },
                child: const Text('Destructive Confirm Dialog'),
              ),
            ],
          ),

          AppDimens.vGapXL,
          const Text(
            'UI Notification Demo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          AppDimens.vGapL,

          // UI Notification Demo
          Wrap(
            spacing: AppDimens.gapM,
            runSpacing: AppDimens.gapM,
            children: [
              ElevatedButton(
                onPressed: () {
                  final uiNotifier =
                      DependencyInjection.locator<UiNotifierService>();
                  uiNotifier.showSnackBar(
                    context,
                    'This is a normal snackbar',
                  );
                },
                child: const Text('Show Snackbar'),
              ),
              ElevatedButton(
                onPressed: () {
                  final uiNotifier =
                      DependencyInjection.locator<UiNotifierService>();
                  uiNotifier.showSuccessSnackBar(
                    context,
                    'Operation completed successfully!',
                  );
                },
                child: const Text('Success Snackbar'),
              ),
              ElevatedButton(
                onPressed: () {
                  final uiNotifier =
                      DependencyInjection.locator<UiNotifierService>();
                  uiNotifier.showErrorSnackBar(
                    context,
                    'Something went wrong!',
                  );
                },
                child: const Text('Error Snackbar'),
              ),
              ElevatedButton(
                onPressed: () {
                  final uiNotifier =
                      DependencyInjection.locator<UiNotifierService>();
                  uiNotifier.showWarningSnackBar(
                    context,
                    'Warning: This action might have consequences',
                  );
                },
                child: const Text('Warning Snackbar'),
              ),
              ElevatedButton(
                onPressed: () {
                  final uiNotifier =
                      DependencyInjection.locator<UiNotifierService>();
                  uiNotifier.showToast(
                    context,
                    'This is a toast message',
                  );
                },
                child: const Text('Show Toast'),
              ),
              ElevatedButton(
                onPressed: () {
                  final uiNotifier =
                      DependencyInjection.locator<UiNotifierService>();
                  uiNotifier.showLoadingDialog(
                    context: context,
                    message: 'Processing...',
                  );

                  // Simulate a delay then close the dialog
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                    uiNotifier.showSuccessSnackBar(
                      context,
                      'Processing completed!',
                    );
                  });
                },
                child: const Text('Show Loading Dialog'),
              ),
            ],
          ),

          // Add more sections as needed...
          AppDimens.vGapXL,
        ],
      ),
    );
  }
}
