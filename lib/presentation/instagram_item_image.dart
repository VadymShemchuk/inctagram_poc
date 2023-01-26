import 'package:flutter/material.dart';

class InstagramItemImage extends StatelessWidget {
  final String imageUrl;
  final double? height;

  const InstagramItemImage({
    Key? key,
    required this.imageUrl,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Image.network(
          imageUrl,
          height: height,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.grey,
                      Colors.grey,
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
