import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/router/app_router.dart';
import 'package:spaced_learning_app/core/theme/app_theme.dart';
import 'package:spaced_learning_app/presentation/viewmodels/theme_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: SpacedLearningApp()));
}

class SpacedLearningApp extends ConsumerWidget {
  const SpacedLearningApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeStateProvider);
    final goRouter = ref.watch(appRouterProvider); // Đúng tên provider đã sinh

    return MaterialApp.router(
      title: 'Spaced Learning',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: goRouter,
    );
  }
}
