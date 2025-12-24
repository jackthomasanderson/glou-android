import 'package:flutter/material.dart';

/// Alpha Banner Widget
/// Displays a prominent banner at the bottom of the app indicating the project is in alpha
/// Works across all screen sizes (mobile, tablet, desktop)
class AlphaBanner extends StatelessWidget {
  const AlphaBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        elevation: 4,
        color: const Color(0xFFF59E0B),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Alpha — Features may change between pre-release builds',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
