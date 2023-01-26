import 'package:flutter/material.dart';
import 'package:insta_poc/presentation/detailed_item_widget.dart';
import 'package:insta_poc/presentation/instagram_item_card.dart';

import '../api/media_model.dart';

class ItemsCarouselWidget extends StatelessWidget {
  final List<InstagramMediaModel> medias;

  const ItemsCarouselWidget({
    Key? key,
    required this.medias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: medias.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: InstagramItemCard(
            media: medias[index],
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => DetailedItem(
                  media: medias[index],
                  medias: medias,
                ),
              ),
            ),
            width: 100,
          ),
        );
      },
    );
  }
}
