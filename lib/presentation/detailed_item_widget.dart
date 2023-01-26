import 'package:flutter/material.dart';
import 'package:insta_poc/api/media_model.dart';
import 'package:insta_poc/presentation/carousel_item_widget.dart';
import 'package:insta_poc/presentation/instagram_item_image.dart';

class _Constants {
  static const addToCart = 'ADD TO CART';
  static const buyNow = 'BUY NOW';
}

class DetailedItem extends StatelessWidget {
  const DetailedItem({
    super.key,
    required this.media,
    required this.medias,
  });
  final InstagramMediaModel media;
  final List<InstagramMediaModel> medias;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: body,
      );

  get body => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              itemImage,
              itemCaption,
              instagramItemPrise,
              divider,
              addToCart,
              buyNow,
              carousel,
            ],
          ),
        ),
      );

  get itemImage => InstagramItemImage(imageUrl: media.url);

  get itemCaption => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          media.caption,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      );

  get buyButton => ElevatedButton(
      onPressed: () {},
      child: const Text(
        'Buy now',
        style: TextStyle(
          color: Colors.white,
        ),
      ));

  get instagramItemPrise => const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text(
          '255 USD',
          maxLines: 1,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
          ),
        ),
      );

  get divider => const Divider(
        thickness: 1,
        height: 30,
        color: Colors.grey,
      );

  get addToCart => InkWell(
        onTap: () {},
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: const Center(child: Text(_Constants.addToCart)),
        ),
      );

  get buyNow => InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: 50,
          margin: const EdgeInsets.only(top: 8),
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                _Constants.buyNow,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );

  get carousel => Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 32),
          child: ItemsCarouselWidget(
            medias: medias,
          ),
        ),
      );
}
