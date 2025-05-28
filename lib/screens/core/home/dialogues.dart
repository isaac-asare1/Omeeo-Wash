import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/custom_theme/font_size.dart';

class Dialogues {
  void submitOrder(
    BuildContext context,
    List<dynamic> reviews, {
    required String overallRating,
    required String washersName,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: scaffoldBackground,
      builder:
          (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                // Top Bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: darkPurple,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: whiteText,
                          size: FontSizes.lg,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              "Harrison L.'s Reviews",
                              fontSize: FontSizes.lg,
                              color: whiteText,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${overallRating} stars',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ).copyWith(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                      top: 16,
                    ),
                    child: ListView(
                      children:
                          reviews
                              .map((review) => _buildReviewCard(review: review))
                              .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildReviewCard({required Map<String, dynamic> review}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              int.parse(review['rating']),

              (index) => Icon(Icons.star, color: amber, size: 20),
            ),
          ),
          if (review['message'] != null) ...[
            const SizedBox(height: 12),
            Text(review['message'], style: const TextStyle(fontSize: 14)),
          ],
          const SizedBox(height: 12),
          Text(
            "${review['name']} | ${review['date']}",
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
