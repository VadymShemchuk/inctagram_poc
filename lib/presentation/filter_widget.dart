import 'package:flutter/material.dart';
import 'package:insta_poc/api/tag_model.dart';
import 'package:insta_poc/common/shop_page_singleton.dart';

class TagsFilter extends StatefulWidget {
  TagsFilter({
    super.key,
    required this.tags,
  });
  List<TagModel> tags;

  @override
  State<TagsFilter> createState() => _TagsFilterState();
}

class _TagsFilterState extends State<TagsFilter> {
  bool value = false;
  List<String> chackedTags = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,
      child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.tags.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            crossAxisCount: 3,
            // childAspectRatio: 0.75,
          ),
          itemBuilder: (BuildContext _, index) {
            final tag = widget.tags[index];
            return Row(
              children: [
                Text(
                  tag.tagName,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                Checkbox(
                    value: tag.isTagChecked,
                    onChanged: ((newValue) {
                      setState(() {
                        tag.isTagChecked = newValue!;
                        if (tag.isTagChecked) {
                          chackedTags.add(tag.tagName);
                          TagsStream.tagChanged(chackedTags);
                        } else {
                          if (chackedTags.contains(tag.tagName)) {
                            chackedTags.remove(tag.tagName);
                            TagsStream.tagChanged(chackedTags);
                          }
                        }
                      });
                    })),
              ],
            );
          }),
    );
  }
}
