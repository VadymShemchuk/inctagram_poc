import 'package:flutter/material.dart';
import 'package:insta_poc/api/media_model.dart';
import 'package:insta_poc/presentation/detailed_item_widget.dart';
import 'package:insta_poc/presentation/instagram_item_card.dart';

class MediaSearhDelegate extends SearchDelegate {
  final List<InstagramMediaModel> shopItems;
  final List<String> captionItems;

  MediaSearhDelegate({
    required this.shopItems,
    required this.captionItems,
  });

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) {
    List<InstagramMediaModel> searchResults = [];
    for (var model in shopItems) {
      if (model.caption == query) {
        searchResults.add(model);
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: GridView.builder(
          itemCount: searchResults.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            crossAxisCount: 2,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (BuildContext _, index) {
            return Center(
              child: InstagramItemCard(
                media: searchResults[index],
                onTap: () => Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => DetailedItem(
                      media: searchResults[index],
                      medias: shopItems,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = captionItems.where((element) {
      final result = element.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final caption = suggestions[index];
        return ListTile(
          title: Text(caption),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
