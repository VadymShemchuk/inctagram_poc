import 'package:flutter/material.dart';
import 'package:insta_poc/api/media_model.dart';
import 'package:insta_poc/presentation/instagram_item_image.dart';

class InstagramItemCard extends StatelessWidget {
  final InstagramMediaModel media;
  final double? height;
  final double? width;
  final Function() onTap;

  const InstagramItemCard({
    super.key,
    required this.media,
    required this.onTap,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InstagramItemImage(
                imageUrl: media.url,
                height: height,
              ),
              instagramItemCaption,
              instagramItemPrise,
            ],
          ),
        ),
      ),
    );
  }

  get instagramItemCaption => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          media.caption,
          maxLines: 2,
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
      );

  get instagramItemPrise => const Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(
          '255 USD',
          maxLines: 1,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      );
}
