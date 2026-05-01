import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/model/unit_model.dart';

class UnitPlaylistCard extends StatelessWidget {
  final UnitModel unitCard;
  final VoidCallback? onTap;

  const UnitPlaylistCard({
    super.key,
    required this.unitCard,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String cardImage =
        (unitCard.image != null && unitCard.image!.trim().isNotEmpty)
            ? unitCard.image!
            : "https://via.placeholder.com/300";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 4),
              color: Colors.black.withValues(alpha: 0.08),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            /// Image section
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 110,
                  child: Image.network(
                    cardImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),

                /// overlay play icon
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.25),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                  ),
                ),

                /// lectures count chip
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "${unitCard.lecturesNumber} درس",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unitCard.name,
                      style: AppTextStyle.primaryStyle.copyWith(
                        fontSize: 16
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      unitCard.description,
                      style: AppTextStyle.secondaryStyle.copyWith(
                        fontSize: 14
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}