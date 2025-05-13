import 'package:flutter/material.dart';
import 'package:slt_app/core/constants/app_strings.dart';
import 'package:slt_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:slt_app/presentation/widgets/buttons/slt_secondary_button.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// Score Input Dialog Content
/// A specialized dialog content for inputting scores with a slider and text input
class SltScoreInputDialogContent extends StatefulWidget {
  /// Title of the dialog
  final String title;

  /// Maximum score possible
  final double maxScore;

  /// Minimum score possible
  final double minScore;

  /// Initial score value
  final double initialScore;

  /// Divisions for the slider
  final int? divisions;

  /// Whether to show a text field for numeric input
  final bool showTextField;

  /// Whether to allow comments
  final bool allowComments;

  /// Initial comments
  final String? initialComments;

  /// Comments hint text
  final String commentsHint;

  /// Whether comments are required
  final bool commentsRequired;

  /// Callback when score is saved
  final void Function(double score, String? comments)? onSave;

  /// Save button text
  final String saveButtonText;

  /// Cancel button text
  final String cancelButtonText;

  /// Whether to show score indicators below slider
  final bool showScoreIndicators;

  /// Score indicators (from low to high)
  final List<String> scoreIndicators;

  /// Colors for score indicators
  final List<Color>? scoreIndicatorColors;

  SltScoreInputDialogContent({
    Key? key,
    this.title = AppStrings.enterScore,
    required this.maxScore,
    this.minScore = 0.0,
    this.initialScore = 0.0,
    this.divisions,
    this.showTextField = true,
    this.allowComments = true,
    this.initialComments,
    this.commentsHint = AppStrings.comments,
    this.commentsRequired = false,
    this.onSave,
    this.saveButtonText = AppStrings.saveScore,
    this.cancelButtonText = AppStrings.cancel,
    this.showScoreIndicators = true,
    this.scoreIndicators = const [
      AppStrings.poor,
      AppStrings.fair,
      AppStrings.good,
      AppStrings.excellent,
    ],
    this.scoreIndicatorColors,
  })  : assert(maxScore > minScore, 'Max score must be greater than min score'),
        assert(initialScore >= minScore && initialScore <= maxScore,
            'Initial score must be between min and max score'),
        assert(!showScoreIndicators || scoreIndicators.isNotEmpty,
            'Score indicators must not be empty if shown'),
        super(key: key);

  /// Show the dialog
  static Future<Map<String, dynamic>?> show({
    required BuildContext context,
    String title = AppStrings.enterScore,
    required double maxScore,
    double minScore = 0.0,
    double initialScore = 0.0,
    int? divisions,
    bool showTextField = true,
    bool allowComments = true,
    String? initialComments,
    String commentsHint = AppStrings.comments,
    bool commentsRequired = false,
    String saveButtonText = AppStrings.saveScore,
    String cancelButtonText = AppStrings.cancel,
    bool showScoreIndicators = true,
    List<String> scoreIndicators = const [
      AppStrings.poor,
      AppStrings.fair,
      AppStrings.good,
      AppStrings.excellent,
    ],
    List<Color>? scoreIndicatorColors,
  }) {
    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.dialogBorderRadius),
          ),
          child: SltScoreInputDialogContent(
            title: title,
            maxScore: maxScore,
            minScore: minScore,
            initialScore: initialScore,
            divisions: divisions,
            showTextField: showTextField,
            allowComments: allowComments,
            initialComments: initialComments,
            commentsHint: commentsHint,
            commentsRequired: commentsRequired,
            saveButtonText: saveButtonText,
            cancelButtonText: cancelButtonText,
            showScoreIndicators: showScoreIndicators,
            scoreIndicators: scoreIndicators,
            scoreIndicatorColors: scoreIndicatorColors,
            onSave: (score, comments) {
              Navigator.of(context).pop({
                'score': score,
                'comments': comments,
              });
            },
          ),
        );
      },
    );
  }

  @override
  _SltScoreInputDialogContentState createState() =>
      _SltScoreInputDialogContentState();
}

class _SltScoreInputDialogContentState
    extends State<SltScoreInputDialogContent> {
  late double _score;
  late TextEditingController _scoreController;
  late TextEditingController _commentsController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _score = widget.initialScore;
    _scoreController = TextEditingController(text: _score.toStringAsFixed(0));
    _commentsController =
        TextEditingController(text: widget.initialComments ?? '');
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  void _updateScoreFromSlider(double value) {
    setState(() {
      _score = value;
      _scoreController.text = _score.toStringAsFixed(0);
    });
  }

  void _updateScoreFromTextField(String value) {
    final parsed = double.tryParse(value);
    if (parsed != null &&
        parsed >= widget.minScore &&
        parsed <= widget.maxScore) {
      setState(() {
        _score = parsed;
      });
    }
  }

  Color _getSliderColor(double value) {
    if (widget.scoreIndicatorColors == null ||
        widget.scoreIndicatorColors!.isEmpty) {
      // Default color logic if no colors provided
      if (value <
          widget.minScore + (widget.maxScore - widget.minScore) * 0.25) {
        return AppColors.poor;
      } else if (value <
          widget.minScore + (widget.maxScore - widget.minScore) * 0.5) {
        return AppColors.average;
      } else if (value <
          widget.minScore + (widget.maxScore - widget.minScore) * 0.75) {
        return AppColors.good;
      } else {
        return AppColors.excellent;
      }
    } else {
      // Use provided colors
      final percentage =
          (value - widget.minScore) / (widget.maxScore - widget.minScore);
      final index = (percentage * widget.scoreIndicatorColors!.length).floor();
      return widget.scoreIndicatorColors![
          index.clamp(0, widget.scoreIndicatorColors!.length - 1)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: AppDimens.dialogPadding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              AppDimens.vGapL,

              // Score display
              Center(
                child: Text(
                  '${AppStrings.score}: ${_score.toInt()} ${AppStrings.out} ${widget.maxScore.toInt()}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: _getSliderColor(_score),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppDimens.vGapM,

              // Score slider
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: _getSliderColor(_score),
                  thumbColor: _getSliderColor(_score),
                  inactiveTrackColor:
                      _getSliderColor(_score).withValues(alpha: 0.2),
                ),
                child: Slider(
                  value: _score,
                  min: widget.minScore,
                  max: widget.maxScore,
                  divisions: widget.divisions ??
                      (widget.maxScore - widget.minScore).toInt(),
                  onChanged: _updateScoreFromSlider,
                ),
              ),

              // Score indicators
              if (widget.showScoreIndicators) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.paddingS),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      widget.scoreIndicators.length,
                      (index) {
                        final color = widget.scoreIndicatorColors != null &&
                                index < widget.scoreIndicatorColors!.length
                            ? widget.scoreIndicatorColors![index]
                            : theme.colorScheme.primary;

                        return Text(
                          widget.scoreIndicators[index],
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                AppDimens.vGapM,
              ],

              // Score text field
              if (widget.showTextField) ...[
                TextFormField(
                  controller: _scoreController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.score,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: _updateScoreFromTextField,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.validationRequired;
                    }
                    final score = double.tryParse(value);
                    if (score == null) {
                      return AppStrings.validationNumbersOnly;
                    }
                    if (score < widget.minScore || score > widget.maxScore) {
                      return 'Score must be between ${widget.minScore} and ${widget.maxScore}';
                    }
                    return null;
                  },
                ),
                AppDimens.vGapM,
              ],

              // Comments
              if (widget.allowComments) ...[
                TextFormField(
                  controller: _commentsController,
                  decoration: InputDecoration(
                    labelText: widget.commentsHint,
                    hintText: AppStrings.addFeedback,
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: widget.commentsRequired
                      ? (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.validationRequired;
                          }
                          return null;
                        }
                      : null,
                ),
                AppDimens.vGapL,
              ],

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SltSecondaryButton(
                    text: widget.cancelButtonText,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  AppDimens.hGapM,
                  SltPrimaryButton(
                    text: widget.saveButtonText,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSave?.call(
                          _score,
                          widget.allowComments
                              ? _commentsController.text
                              : null,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
