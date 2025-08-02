import 'package:flutter/material.dart';
import 'easy_stars_rating.dart';
import 'emoji_rating_widgets.dart';
import 'enums/star_enums.dart';
import 'models/star_animation_config.dart';

/// Review data model
class ReviewData {
  final double rating;
  final String comment;
  final ReviewType reviewType;
  final DateTime timestamp;

  ReviewData({
    required this.rating,
    required this.comment,
    required this.reviewType,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

/// Review type enum
enum ReviewType { stars, emoji }

/// Comprehensive review bottom sheet widget
class EasyStarsReviewBottomSheet extends StatefulWidget {
  /// Initial rating value
  final double initialRating;

  /// Number of stars (for star rating mode)
  final int starCount;

  /// Size of stars/emojis
  final double ratingSize;

  /// Colors for filled and empty states
  final Color filledColor;
  final Color emptyColor;

  /// Animation configuration
  final StarAnimationConfig animationConfig;

  /// Review type (stars or emoji)
  final ReviewType reviewType;

  /// Whether to allow switching between star and emoji modes
  final bool allowModeSwitch;

  /// Whether to allow half ratings
  final bool allowHalfRating;

  /// Maximum character limit for review text
  final int maxCharacters;

  /// Minimum character requirement
  final int minCharacters;

  /// Whether review text is required
  final bool isCommentRequired;

  /// Custom hint text for review input
  final String? hintText;

  /// Title of the bottom sheet
  final String title;

  /// Subtitle or description
  final String? subtitle;

  /// Submit button text
  final String submitButtonText;

  /// Cancel button text
  final String cancelButtonText;

  /// Callback when review is submitted
  final Function(ReviewData reviewData)? onReviewSubmitted;

  /// Callback when bottom sheet is dismissed
  final VoidCallback? onDismissed;

  /// Custom validation function for review text
  final String? Function(String?)? textValidator;

  /// Whether to show character counter
  final bool showCharacterCounter;

  /// Custom emoji list for emoji mode
  final List<String>? customEmojis;

  /// Whether to show rating labels
  final bool showRatingLabels;

  /// Custom rating labels
  final List<String>? customRatingLabels;

  /// Background color of the bottom sheet
  final Color? backgroundColor;

  /// Border radius of the bottom sheet
  final double borderRadius;

  /// Additional widgets to show above the rating
  final List<Widget>? headerWidgets;

  /// Additional widgets to show below the text field
  final List<Widget>? footerWidgets;

  final Widget? customSubmitButton;

  /// Custom cancel button widget (overrides cancelButtonText and cancelButtonStyle)
  final Widget? customCancelButton;

  /// Submit button style customization
  final ButtonStyle? submitButtonStyle;

  /// Cancel button style customization
  final ButtonStyle? cancelButtonStyle;

  /// Additional custom buttons to show in the action row
  final List<Widget>? additionalButtons;

  /// Button layout configuration
  final ButtonLayoutConfig buttonLayoutConfig;

  /// Whether to show the default cancel button
  final bool showCancelButton;

  /// Whether to show the default submit button
  final bool showSubmitButton;

  /// Custom button row widget (completely replaces default buttons)
  final Widget? customButtonRow;

  /// Submit button icon
  final Icon? submitButtonIcon;

  /// Cancel button icon
  final Icon? cancelButtonIcon;

  /// Button spacing
  final double buttonSpacing;

  /// Button height
  final double? buttonHeight;

  const EasyStarsReviewBottomSheet({
    super.key,
    this.initialRating = 0.0,
    this.starCount = 5,
    this.ratingSize = 32.0,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
    this.animationConfig = StarAnimationConfig.scale,
    this.reviewType = ReviewType.stars,
    this.allowModeSwitch = true,
    this.allowHalfRating = false,
    this.maxCharacters = 500,
    this.minCharacters = 0,
    this.isCommentRequired = false,
    this.hintText,
    this.title = 'Write a Review',
    this.subtitle,
    this.submitButtonText = 'Submit Review',
    this.cancelButtonText = 'Cancel',
    this.onReviewSubmitted,
    this.onDismissed,
    this.textValidator,
    this.showCharacterCounter = true,
    this.customEmojis,
    this.showRatingLabels = false,
    this.customRatingLabels,
    this.backgroundColor,
    this.borderRadius = 16.0,
    this.headerWidgets,
    this.footerWidgets,
    this.customSubmitButton,
    this.customCancelButton,
    this.submitButtonStyle,
    this.cancelButtonStyle,
    this.additionalButtons,
    this.buttonLayoutConfig = ButtonLayoutConfig.row,
    this.showCancelButton = true,
    this.showSubmitButton = true,
    this.customButtonRow,
    this.submitButtonIcon,
    this.cancelButtonIcon,
    this.buttonSpacing = 16.0,
    this.buttonHeight,
  });

  /// Show the review bottom sheet
  static Future<ReviewData?> show({
    required BuildContext context,
    double initialRating = 0.0,
    int starCount = 5,
    double ratingSize = 32.0,
    Color filledColor = Colors.amber,
    Color emptyColor = Colors.grey,
    StarAnimationConfig animationConfig = StarAnimationConfig.scale,
    ReviewType reviewType = ReviewType.stars,
    bool allowModeSwitch = true,
    bool allowHalfRating = false,
    int maxCharacters = 500,
    int minCharacters = 0,
    bool isCommentRequired = false,
    String? hintText,
    String title = 'Write a Review',
    String? subtitle,
    String submitButtonText = 'Submit Review',
    String cancelButtonText = 'Cancel',
    bool showCharacterCounter = true,
    List<String>? customEmojis,
    bool showRatingLabels = false,
    List<String>? customRatingLabels,
    Color? backgroundColor,
    double borderRadius = 16.0,
    List<Widget>? headerWidgets,
    List<Widget>? footerWidgets,
    Widget? customSubmitButton,
    Widget? customCancelButton,
    ButtonStyle? submitButtonStyle,
    ButtonStyle? cancelButtonStyle,
    List<Widget>? additionalButtons,
    ButtonLayoutConfig buttonLayoutConfig = ButtonLayoutConfig.row,
    bool showCancelButton = true,
    bool showSubmitButton = true,
    Widget? customButtonRow,
    Icon? submitButtonIcon,
    Icon? cancelButtonIcon,
    double buttonSpacing = 16.0,
    double? buttonHeight,
  }) {
    return showModalBottomSheet<ReviewData>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EasyStarsReviewBottomSheet(
        initialRating: initialRating,
        starCount: starCount,
        ratingSize: ratingSize,
        filledColor: filledColor,
        emptyColor: emptyColor,
        animationConfig: animationConfig,
        reviewType: reviewType,
        allowModeSwitch: allowModeSwitch,
        allowHalfRating: allowHalfRating,
        maxCharacters: maxCharacters,
        minCharacters: minCharacters,
        isCommentRequired: isCommentRequired,
        hintText: hintText,
        title: title,
        subtitle: subtitle,
        submitButtonText: submitButtonText,
        cancelButtonText: cancelButtonText,
        showCharacterCounter: showCharacterCounter,
        customEmojis: customEmojis,
        showRatingLabels: showRatingLabels,
        customRatingLabels: customRatingLabels,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        headerWidgets: headerWidgets,
        footerWidgets: footerWidgets,
        customSubmitButton: customSubmitButton,
        customCancelButton: customCancelButton,
        submitButtonStyle: submitButtonStyle,
        cancelButtonStyle: cancelButtonStyle,
        additionalButtons: additionalButtons,
        buttonLayoutConfig: buttonLayoutConfig,
        showCancelButton: showCancelButton,
        showSubmitButton: showSubmitButton,
        customButtonRow: customButtonRow,
        submitButtonIcon: submitButtonIcon,
        cancelButtonIcon: cancelButtonIcon,
        buttonSpacing: buttonSpacing,
        buttonHeight: buttonHeight,
      ),
    );
  }

  @override
  State<EasyStarsReviewBottomSheet> createState() =>
      _EasyStarsReviewBottomSheetState();
}

class _EasyStarsReviewBottomSheetState
    extends State<EasyStarsReviewBottomSheet> {
  late double _currentRating;
  late ReviewType _currentReviewType;
  late TextEditingController _textController;
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  // Default rating labels
  static const List<String> _defaultRatingLabels = [
    'Terrible',
    'Poor',
    'Average',
    'Good',
    'Excellent'
  ];

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
    _currentReviewType = widget.reviewType;
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  List<String> get _ratingLabels =>
      widget.customRatingLabels ?? _defaultRatingLabels;

  String _getRatingLabel() {
    if (!widget.showRatingLabels || _currentRating <= 0) return '';
    int index = (_currentRating - 1).floor().clamp(0, _ratingLabels.length - 1);
    return _ratingLabels[index];
  }

  void _onRatingChanged(double rating) {
    setState(() {
      _currentRating = rating;
    });
  }

  String? _validateText(String? value) {
    if (widget.textValidator != null) {
      return widget.textValidator!(value);
    }

    if (widget.isCommentRequired && (value == null || value.trim().isEmpty)) {
      return 'Review comment is required';
    }

    if (value != null && value.length < widget.minCharacters) {
      return 'Review must be at least ${widget.minCharacters} characters';
    }

    if (value != null && value.length > widget.maxCharacters) {
      return 'Review cannot exceed ${widget.maxCharacters} characters';
    }

    return null;
  }

  void _submitReview() async {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) return;

    if (_currentRating <= 0) {
      _showSnackBar('Please provide a rating');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final reviewData = ReviewData(
      rating: _currentRating,
      comment: _textController.text.trim(),
      reviewType: _currentReviewType,
    );

    try {
      if (widget.onReviewSubmitted != null) {
        widget.onReviewSubmitted!(reviewData);
      }

      Navigator.of(context).pop(reviewData);
    } catch (e) {
      _showSnackBar('Failed to submit review. Please try again.');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildRatingWidget() {
    switch (_currentReviewType) {
      case ReviewType.stars:
        return EasyStarsRating(
          initialRating: _currentRating,
          starCount: widget.starCount,
          starSize: widget.ratingSize,
          filledColor: widget.filledColor,
          emptyColor: widget.emptyColor,
          animationConfig: widget.animationConfig,
          allowHalfRating: widget.allowHalfRating,
          onRatingChanged: _onRatingChanged,
        );
      case ReviewType.emoji:
        return EasyStarsEmoji(
          initialRating: _currentRating,
          emojiSize: widget.ratingSize,
          animationConfig: widget.animationConfig,
          customEmojis: widget.customEmojis,
          onRatingChanged: _onRatingChanged,
        );
    }
  }

  Widget _buildModeSwitch() {
    if (!widget.allowModeSwitch) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SegmentedButton<ReviewType>(
          segments: const [
            ButtonSegment(
              value: ReviewType.stars,
              label: Text('Stars'),
              icon: Icon(Icons.star, size: 16),
            ),
            ButtonSegment(
              value: ReviewType.emoji,
              label: Text('Emoji'),
              icon: Icon(Icons.emoji_emotions, size: 16),
            ),
          ],
          selected: {_currentReviewType},
          onSelectionChanged: (Set<ReviewType> selection) {
            setState(() {
              _currentReviewType = selection.first;
            });
          },
        ),
      ],
    );
  }

  /// Build the submit button
  Widget _buildSubmitButton() {
    if (widget.customSubmitButton != null) {
      return widget.customSubmitButton!;
    }

    final button = ElevatedButton(
      onPressed: _isSubmitting ? null : _submitReview,
      style: widget.submitButtonStyle ??
          ElevatedButton.styleFrom(
            minimumSize: widget.buttonHeight != null
                ? Size.fromHeight(widget.buttonHeight!)
                : null,
          ),
      child: _isSubmitting
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.submitButtonIcon != null) ...[
                  widget.submitButtonIcon!,
                  const SizedBox(width: 8),
                ],
                Text(widget.submitButtonText),
              ],
            ),
    );

    return button;
  }

  /// Build the cancel button
  Widget _buildCancelButton() {
    if (widget.customCancelButton != null) {
      return widget.customCancelButton!;
    }

    return OutlinedButton(
      onPressed: _isSubmitting
          ? null
          : () {
              widget.onDismissed?.call();
              Navigator.of(context).pop();
            },
      style: widget.cancelButtonStyle ??
          OutlinedButton.styleFrom(
            minimumSize: widget.buttonHeight != null
                ? Size.fromHeight(widget.buttonHeight!)
                : null,
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.cancelButtonIcon != null) ...[
            widget.cancelButtonIcon!,
            const SizedBox(width: 8),
          ],
          Text(widget.cancelButtonText),
        ],
      ),
    );
  }

  /// Build the action buttons section
  Widget _buildActionButtons() {
    // If custom button row is provided, use it
    if (widget.customButtonRow != null) {
      return widget.customButtonRow!;
    }

    List<Widget> buttons = [];

    // Add additional buttons first
    if (widget.additionalButtons != null) {
      buttons.addAll(widget.additionalButtons!);
    }

    // Add default buttons based on configuration
    if (widget.showCancelButton) {
      buttons.add(_buildCancelButton());
    }

    if (widget.showSubmitButton) {
      buttons.add(_buildSubmitButton());
    }

    if (buttons.isEmpty) {
      return const SizedBox.shrink();
    }

    switch (widget.buttonLayoutConfig) {
      case ButtonLayoutConfig.row:
        return Row(
          children: buttons
              .map((button) => Expanded(child: button))
              .expand((b) => [
                    b,
                    if (b != buttons.last && buttons.length > 1)
                      SizedBox(width: widget.buttonSpacing),
                  ])
              .where((widget) => widget is! SizedBox || buttons.length > 1)
              .toList(),
        );

      case ButtonLayoutConfig.column:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: buttons
              .expand((button) => [
                    button,
                    if (button != buttons.last && buttons.length > 1)
                      SizedBox(height: widget.buttonSpacing),
                  ])
              .where((widget) => widget is! SizedBox || buttons.length > 1)
              .toList(),
        );

      case ButtonLayoutConfig.submitOnly:
        return widget.showSubmitButton
            ? SizedBox(width: double.infinity, child: _buildSubmitButton())
            : const SizedBox.shrink();

      case ButtonLayoutConfig.cancelOnly:
        return widget.showCancelButton
            ? SizedBox(width: double.infinity, child: _buildCancelButton())
            : const SizedBox.shrink();

      case ButtonLayoutConfig.custom:
        return Wrap(
          spacing: widget.buttonSpacing,
          runSpacing: widget.buttonSpacing,
          children: buttons,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(widget.borderRadius),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title and subtitle
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      widget.subtitle!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Header widgets
                  if (widget.headerWidgets != null) ...widget.headerWidgets!,

                  // Mode switch
                  _buildModeSwitch(),
                  const SizedBox(height: 16),

                  // Rating widget
                  Center(child: _buildRatingWidget()),

                  // Rating label
                  if (widget.showRatingLabels &&
                      _getRatingLabel().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      _getRatingLabel(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: widget.filledColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Review text field
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _textController,
                            validator: _validateText,
                            maxLines: 5,
                            maxLength: widget.maxCharacters,
                            decoration: InputDecoration(
                              hintText:
                                  widget.hintText ?? 'Share your experience...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              counterText:
                                  widget.showCharacterCounter ? null : '',
                              suffixIcon: widget.isCommentRequired
                                  ? const Icon(Icons.star,
                                      color: Colors.red, size: 16)
                                  : null,
                            ),
                          ),

                          // Footer widgets
                          if (widget.footerWidgets != null) ...[
                            const SizedBox(height: 16),
                            ...widget.footerWidgets!,
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Action buttons
                  _buildActionButtons(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Extension methods for easier usage
extension EasyStarsReviewExtension on BuildContext {
  /// Show review bottom sheet with default settings
  Future<ReviewData?> showReviewBottomSheet({
    double initialRating = 0.0,
    String title = 'Write a Review',
    String? subtitle,
    ReviewType reviewType = ReviewType.stars,
    bool allowModeSwitch = true,
  }) {
    return EasyStarsReviewBottomSheet.show(
      context: this,
      initialRating: initialRating,
      title: title,
      subtitle: subtitle,
      reviewType: reviewType,
      allowModeSwitch: allowModeSwitch,
    );
  }
}
