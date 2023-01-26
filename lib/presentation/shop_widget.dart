import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insta_poc/api/instagram_api.dart';
import 'package:insta_poc/api/media_model.dart';
import 'package:insta_poc/common/shop_page_singleton.dart';
import 'package:insta_poc/presentation/detailed_item_widget.dart';
import 'package:insta_poc/presentation/filter_widget.dart';
import 'package:insta_poc/presentation/instagram_item_card.dart';
import 'package:insta_poc/presentation/search_delegate.dart';

class ShopSelectionPage extends StatefulWidget {
  final List<InstagramMediaModel> medias;

  ShopSelectionPage({
    super.key,
    required this.medias,
  });

  @override
  _ShopSelectionPageState createState() => _ShopSelectionPageState();
}

class _ShopSelectionPageState extends State<ShopSelectionPage> {
  bool showTags = false;
  late List<InstagramMediaModel> medias;
  late StreamSubscription onTagsSubscription;
  int lasttaglength = 0;

  @override
  void initState() {
    medias = widget.medias;
    onTagsSubscription = TagsStream.onTagsAdd.listen((tags) {
      if (tags.isNotEmpty) {
        if (lasttaglength > tags.length) {
          widget.medias.map((model) {
            model.isHaveTag = false;
          }).toList();
        }
        lasttaglength = tags.length;
        for (var tag in tags) {
          widget.medias.map((model) {
            if (model.caption.contains(tag)) {
              model.isHaveTag = true;
            }
          }).toList();
          medias = widget.medias.where((element) => element.isHaveTag).toList();
          setState(() {});
        }
      } else {
        widget.medias.map((model) {
          model.isHaveTag = false;
        }).toList();
        medias.clear();
        medias = widget.medias;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    onTagsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Search'),
        actions: [
          IconButton(
              onPressed: () => setState(() {
                    showTags = !showTags;
                  }),
              icon: const Icon(Icons.filter_alt_outlined)),
          IconButton(
              onPressed: () => showSearch(
                    context: context,
                    delegate: MediaSearhDelegate(),
                  ),
              icon: const Icon(Icons.search))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          children: [
            Visibility(
                visible: showTags,
                child: Expanded(
                  child: TagsFilter(
                    tags: InstagramApi.tagsModels,
                  ),
                )),
            Expanded(
              child: GridView.builder(
                  itemCount: medias.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (BuildContext _, index) {
                    return Center(
                      child: InstagramItemCard(
                        media: medias[index],
                        onTap: () => Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => DetailedItem(
                              media: widget.medias[index],
                              medias: widget.medias,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
