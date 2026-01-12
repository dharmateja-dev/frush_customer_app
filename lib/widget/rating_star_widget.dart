import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A custom rating star widget that uses SVG icons.
/// Uses ic_star.svg for active (filled) stars and ic_rate.svg for inactive (empty) stars.
class RatingStarWidget extends StatefulWidget {
  final double initialRating;
  final int itemCount;
  final double itemSize;
  final EdgeInsets itemPadding;
  final ValueChanged<double> onRatingUpdate;
  final bool allowHalfRating;
  final bool ignoreGestures;
  final Color? activeColor;
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
class RatingDisplayWidget extends StatelessWidget {
  final double rating;
  final int itemCount;
  final double itemSize;
  final EdgeInsets itemPadding;
  final Color? activeColor;
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

/*******************************************************************************************
 * Copyright (c) 2025 Movenetics Digital. All rights reserved.
 *
 * This software and associated documentation files are the property of 
 * Movenetics Digital. Unauthorized copying, modification, distribution, or use of this 
 * Software, via any medium, is strictly prohibited without prior written permission.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
 * OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR 
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * Company: Movenetics Digital
 * Author: kasa Pogu Dharma Teja
 *******************************************************************************************/
