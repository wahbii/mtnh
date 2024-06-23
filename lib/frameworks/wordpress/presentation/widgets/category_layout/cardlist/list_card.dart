import 'package:flutter/material.dart';

import '../../../../../../models/entities/index.dart';
import '../../../../../../models/posts/article_model.dart';
import '../../../../../../widgets/blog/blog_action_button_mixin.dart';
import '../../../../../../widgets/blog/blog_card_view.dart';

class ListCard extends StatelessWidget with BlogActionButtonMixin {
  final List<Article> data;
  final String id;
  final double width;

  const ListCard({required this.data, required this.id, required this.width});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: width * 0.4 + 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            key: ObjectKey(id),
            itemBuilder: (context, index) {
              return BlogCard(
                item: data[index],
                width: constraints.maxWidth * 0.5,
               onTap: (){

               },
               // onTap: () => onTapBlog(article: data[index],),
              );
            },
            itemCount: data.length,
          ),
        );
      },
    );
  }
}
