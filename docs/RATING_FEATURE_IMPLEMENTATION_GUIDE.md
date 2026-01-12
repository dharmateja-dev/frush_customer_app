# Rating Feature Implementation Guide

A complete guide to implement a custom star rating UI using SVG icons in Flutter.

---

## 📁 Project Structure

```
your_project/
├── assets/
│   └── icons/
│       ├── ic_star.svg      # Active/filled star
│       └── ic_rate.svg      # Inactive/empty star
├── lib/
│   ├── widgets/
│   │   └── rating_star_widget.dart
│   ├── models/
│   │   └── rating_model.dart
│   ├── screens/
│   │   └── rate_screen.dart
│   └── main.dart
└── pubspec.yaml
```

---

## 1️⃣ SVG Assets

### `assets/icons/ic_star.svg` (Active/Filled Star - Yellow)
```xml
<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
<g id="star">
<path id="Vector" d="M6.44754 1.02772C6.3629 0.857184 6.18876 0.749513 5.99838 0.750002C5.808 0.750491 5.63441 0.859055 5.55065 1.03002L4.1385 3.91244L0.928262 4.37795C0.740016 4.40525 0.583563 4.53699 0.524623 4.71785C0.465683 4.8987 0.514466 5.09733 0.65048 5.2303L2.97662 7.50444L2.42117 10.6634C2.38805 10.8517 2.46525 11.0425 2.62004 11.1547C2.77483 11.267 2.98009 11.2812 3.14883 11.1912L5.99969 9.6714L8.85119 11.1912C9.01983 11.2811 9.22495 11.267 9.3797 11.1549C9.53446 11.0428 9.61178 10.8523 9.57892 10.664L9.02745 7.50444L11.3499 5.23C11.4857 5.09701 11.5343 4.89853 11.4754 4.71783C11.4165 4.53712 11.2602 4.40543 11.0722 4.37801L7.87924 3.91244L6.44754 1.02772Z" fill="#FFCB39"/>
</g>
</svg>
```

### `assets/icons/ic_rate.svg` (Inactive/Empty Star - Outline)
```xml
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M13.7309 3.51063L15.4909 7.03063C15.7309 7.52063 16.3709 7.99063 16.9109 8.08063L20.1009 8.61062C22.1409 8.95062 22.6209 10.4306 21.1509 11.8906L18.6709 14.3706C18.2509 14.7906 18.0209 15.6006 18.1509 16.1806L18.8609 19.2506C19.4209 21.6806 18.1309 22.6206 15.9809 21.3506L12.9909 19.5806C12.4509 19.2606 11.5609 19.2606 11.0109 19.5806L8.02089 21.3506C5.88089 22.6206 4.58089 21.6706 5.14089 19.2506L5.85089 16.1806C5.98089 15.6006 5.75089 14.7906 5.33089 14.3706L2.85089 11.8906C1.39089 10.4306 1.86089 8.95062 3.90089 8.61062L7.09089 8.08063C7.62089 7.99063 8.26089 7.52063 8.50089 7.03063L10.2609 3.51063C11.2209 1.60063 12.7809 1.60063 13.7309 3.51063Z" stroke="#292D32" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
```

---

## 2️⃣ Update `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_svg: ^2.0.9  # For SVG support

flutter:
  assets:
    - assets/icons/
```

---

## 3️⃣ Rating Star Widget

### `lib/widgets/rating_star_widget.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A custom interactive rating star widget that uses SVG icons.
/// Uses ic_star.svg for active (filled) stars and ic_rate.svg for inactive (empty) stars.
class RatingStarWidget extends StatefulWidget {
  /// Initial rating value (0.0 to itemCount)
  final double initialRating;
  
  /// Number of stars to display
  final int itemCount;
  
  /// Size of each star
  final double itemSize;
  
  /// Padding between stars
  final EdgeInsets itemPadding;
  
  /// Callback when rating changes
  final ValueChanged<double> onRatingUpdate;
  
  /// Whether to allow half ratings (not implemented, for future use)
  final bool allowHalfRating;
  
  /// Whether to ignore user gestures (read-only mode)
  final bool ignoreGestures;
  
  /// Optional color filter for active stars
  final Color? activeColor;
  
  /// Optional color filter for inactive stars
  final Color? inactiveColor;

  const RatingStarWidget({
    super.key,
    this.initialRating = 0.0,
    this.itemCount = 5,
    this.itemSize = 24,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    required this.onRatingUpdate,
    this.allowHalfRating = false,
    this.ignoreGestures = false,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

class _RatingStarWidgetState extends State<RatingStarWidget> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  void didUpdateWidget(RatingStarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      _currentRating = widget.initialRating;
    }
  }

  void _updateRating(int index) {
    if (widget.ignoreGestures) return;
    
    setState(() {
      _currentRating = index + 1.0;
    });
    widget.onRatingUpdate(_currentRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.itemCount, (index) {
        final isActive = index < _currentRating;
        
        return GestureDetector(
          onTap: () => _updateRating(index),
          child: Padding(
            padding: widget.itemPadding,
            child: SvgPicture.asset(
              isActive
                  ? 'assets/icons/ic_star.svg' // Active/filled star
                  : 'assets/icons/ic_rate.svg', // Inactive/empty star
              width: widget.itemSize,
              height: widget.itemSize,
              colorFilter: isActive && widget.activeColor != null
                  ? ColorFilter.mode(widget.activeColor!, BlendMode.srcIn)
                  : (!isActive && widget.inactiveColor != null
                      ? ColorFilter.mode(widget.inactiveColor!, BlendMode.srcIn)
                      : null),
            ),
          ),
        );
      }),
    );
  }
}


/// A read-only rating display widget using SVG icons.
/// Use this when you only need to display a rating without user interaction.
class RatingDisplayWidget extends StatelessWidget {
  /// The rating value to display
  final double rating;
  
  /// Number of stars to display
  final int itemCount;
  
  /// Size of each star
  final double itemSize;
  
  /// Padding between stars
  final EdgeInsets itemPadding;
  
  /// Optional color filter for active stars
  final Color? activeColor;
  
  /// Optional color filter for inactive stars
  final Color? inactiveColor;

  const RatingDisplayWidget({
    super.key,
    required this.rating,
    this.itemCount = 5,
    this.itemSize = 16,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 2.0),
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final isActive = index < rating;
        
        return Padding(
          padding: itemPadding,
          child: SvgPicture.asset(
            isActive
                ? 'assets/icons/ic_star.svg' // Active/filled star
                : 'assets/icons/ic_rate.svg', // Inactive/empty star
            width: itemSize,
            height: itemSize,
            colorFilter: isActive && activeColor != null
                ? ColorFilter.mode(activeColor!, BlendMode.srcIn)
                : (!isActive && inactiveColor != null
                    ? ColorFilter.mode(inactiveColor!, BlendMode.srcIn)
                    : null),
          ),
        );
      }),
    );
  }
}


/// A compact rating widget showing a single star with rating value.
/// Use this for displaying ratings in lists or cards.
class RatingBadgeWidget extends StatelessWidget {
  /// The rating value to display
  final double rating;
  
  /// Size of the star icon
  final double iconSize;
  
  /// Text style for the rating value
  final TextStyle? textStyle;
  
  /// Spacing between icon and text
  final double spacing;

  const RatingBadgeWidget({
    super.key,
    required this.rating,
    this.iconSize = 16,
    this.textStyle,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/ic_star.svg',
          width: iconSize,
          height: iconSize,
        ),
        SizedBox(width: spacing),
        Text(
          rating.toStringAsFixed(1),
          style: textStyle ?? const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
```

---

## 4️⃣ Rating Model

### `lib/models/rating_model.dart`

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  String? id;
  double? rating;
  List<dynamic>? photos;
  String? comment;
  String? orderId;
  String? customerId;
  String? vendorId;
  String? productId;
  String? driverId;
  String? userName;
  String? userProfile;
  Map<String, dynamic>? reviewAttributes;
  Timestamp? createdAt;

  RatingModel({
    this.id,
    this.comment,
    this.photos,
    this.rating,
    this.orderId,
    this.vendorId,
    this.productId,
    this.driverId,
    this.customerId,
    this.userName,
    this.createdAt,
    this.reviewAttributes,
    this.userProfile,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      comment: json['comment'] ?? '',
      photos: json['photos'] ?? [],
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      id: json['id'] ?? '',
      orderId: json['orderId'] ?? '',
      vendorId: json['vendorId'] ?? '',
      productId: json['productId'] ?? '',
      driverId: json['driverId'] ?? '',
      customerId: json['customerId'] ?? '',
      userName: json['userName'] ?? '',
      reviewAttributes: json['reviewAttributes'] ?? {},
      createdAt: json['createdAt'] ?? Timestamp.now(),
      userProfile: json['userProfile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'photos': photos,
      'rating': rating,
      'id': id,
      'orderId': orderId,
      'vendorId': vendorId,
      'productId': productId,
      'driverId': driverId,
      'customerId': customerId,
      'userName': userName,
      'userProfile': userProfile,
      'reviewAttributes': reviewAttributes ?? {},
      'createdAt': createdAt,
    };
  }
}
```

---

## 5️⃣ Usage Examples

### Example 1: Interactive Rating (User Input)

```dart
import 'package:flutter/material.dart';
import 'package:your_project/widgets/rating_star_widget.dart';

class RateDriverScreen extends StatefulWidget {
  const RateDriverScreen({super.key});

  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
  double _rating = 0.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rate Driver')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate for',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // ⭐ Interactive Rating Widget
            Center(
              child: RatingStarWidget(
                initialRating: _rating,
                itemCount: 5,
                itemSize: 40,
                itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                  print('Selected rating: $rating');
                },
              ),
            ),
            
            const SizedBox(height: 30),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Add a comment (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _rating > 0 ? _submitRating : null,
                child: const Text('Submit Rating'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitRating() {
    // Save rating to database
    print('Rating: $_rating');
    print('Comment: ${_commentController.text}');
    // Navigate back or show success message
  }
}
```

### Example 2: Display-Only Rating (Read-Only)

```dart
import 'package:flutter/material.dart';
import 'package:your_project/widgets/rating_star_widget.dart';

class ReviewCard extends StatelessWidget {
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // ⭐ Read-Only Rating Display
            RatingDisplayWidget(
              rating: rating,
              itemCount: 5,
              itemSize: 18,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            ),
            
            const SizedBox(height: 8),
            Text(comment),
            const SizedBox(height: 8),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Example 3: Rating Badge in List/Card

```dart
import 'package:flutter/material.dart';
import 'package:your_project/widgets/rating_star_widget.dart';

class DriverCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double rating;
  final int totalReviews;

  const DriverCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.totalReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(name),
        subtitle: Row(
          children: [
            // ⭐ Compact Rating Badge
            RatingBadgeWidget(
              rating: rating,
              iconSize: 16,
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '($totalReviews reviews)',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Navigate to rate driver screen
          },
          child: const Text('Rate'),
        ),
      ),
    );
  }
}
```

### Example 4: Custom Colored Stars

```dart
// Using custom colors
RatingStarWidget(
  initialRating: 3.0,
  itemCount: 5,
  itemSize: 32,
  activeColor: Colors.amber,      // Custom active color
  inactiveColor: Colors.grey[400], // Custom inactive color
  onRatingUpdate: (rating) {
    print('Rating: $rating');
  },
),
```

---

## 6️⃣ Icon Comparison

| Property          | `ic_star.svg`     | `ic_rate.svg`         |
| ----------------- | ----------------- | --------------------- |
| **State**         | Active (Selected) | Inactive (Unselected) |
| **Fill**          | Solid filled      | Outline only          |
| **Default Color** | Yellow (#FFCB39)  | Grey (#292D32)        |
| **Usage**         | Selected stars    | Unselected stars      |

---

## 7️⃣ Widget Comparison

| Widget                | Purpose         | Interactive | Use Case     |
| --------------------- | --------------- | ----------- | ------------ |
| `RatingStarWidget`    | Input rating    | ✅ Yes       | Rating forms |
| `RatingDisplayWidget` | Show rating     | ❌ No        | Review lists |
| `RatingBadgeWidget`   | Compact display | ❌ No        | Cards, lists |

---

## 8️⃣ Quick Start Checklist

- [ ] Add `flutter_svg` to `pubspec.yaml`
- [ ] Create `assets/icons/` folder
- [ ] Add `ic_star.svg` (filled star)
- [ ] Add `ic_rate.svg` (empty star)
- [ ] Register assets in `pubspec.yaml`
- [ ] Create `rating_star_widget.dart`
- [ ] Import and use in your screens

---

## 9️⃣ Run Commands

```bash
# Get dependencies
flutter pub get

# Run app
flutter run
```

---

That's it! You now have a complete, reusable rating system with custom SVG icons! 🌟
