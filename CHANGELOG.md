## 1.1.0

### 🚀 New features

* **`EasyStarsController`** — programmatically read and change the rating from anywhere (`controller.update(4.5)`, `controller.clear()`); widget taps/drag sync back automatically. `EasyStarsRating` also gained a `controller` parameter and its `initialRating` is now optional
* **`EasyRatingBadge`** — compact, theme-aware `★ 4.2 (156)` badge widget with customizable icon, colors, styles, padding and decoration
* **Haptic feedback** — new `enableHapticFeedback` flag on `EasyStarsRating` / `StarConfig` fires a light haptic pulse when the rating changes via tap or drag
* **Accessibility** — stars now expose a semantic label announcing the current rating ("3 out of 5 stars"), customizable via the new `StarConfig.semanticLabel`

### 🐛 Fixes

* **Fixed a critical regression** from 1.0.10: `EasyStarsReviewBottomSheet`, `ReviewData`, `ReviewType` and the `context.showReviewBottomSheet()` extension were no longer exported from the main library
* **Fixed** star widgets crashing (RangeError) when `starCount` changed at runtime — animation controllers are now rebuilt
* **Fixed** `EasyStarsRating` and `EasyStarsDisplay` ignoring property changes after the first build (configuration was frozen in `initState`)
* **Fixed** potential NaN crash with single-star ratings in arc arrangement and gradient colors
* **Fixed** review bottom sheet calling `setState` after dismissal

### 🔧 Improvements

* `StarConfig.copyWith` — now supports all configuration fields (previously only a subset)
* Emoji widgets now accept any number of custom emojis (previously hardcoded to exactly 5)
* Replaced deprecated `Matrix4.scale`/`translate` APIs (no behavior change)
* Upgraded `flutter_lints` to `^6.0.0` — the whole package now analyzes with zero issues
* Added a proper example package (`example/` with its own `pubspec.yaml`), fully fixed and analyzer-clean
* Rebuilt the test suite (previous tests were failing) — 23 tests covering exports, controller, badge, rating, display, arrangements, emoji widgets, and review summary
* Added pubspec metadata: `topics`, `screenshots`, `repository`, `issue_tracker`

## 1.0.0

* Basic functionality
- EasyStarsRating widget for interactive star rating
- EasyStarsDisplay widget for static star rating
- StarConfig class for configuring star appearance and behavior
- StarAnimationConfig class for configuring star animations
- StarEnums for star layout direction, size variants, star animation types, filling behavior, alignment, interaction mode, and more

## 1.0.1

* Bug fixes and improvements
* Added emoji rating widget
* Added support for animated emoji slider
* Added support for custom emojis

## 1.0.2

* Bug fixes and improvements
* Added support for custom star sizes
* Added support for custom colors

## 1.0.3

* Bug fixes and improvements

## 1.0.4

* Bup fixes 
* Half star filling

## 1.0.5

* Bug fixes and improvements
* Hover for custom star icons
* half star filling fix

## 1.0.6

* Bug fixes and improvements
 
 ## 1.0.7

 * code optimization for future update

 ## 1.0.8
 * Added support for bottom sheet
 * Added support for review bottom sheet

## 1.0.9

* Bug fixes and improvements
* Added support for custom submit and cancel buttons
* Added support for custom button row
* Added support for custom button layout

## 1.0.10
* Added Review Summary widget
 
