import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/config.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/index.dart';
import '../../../../../models/posts/article_provider.dart';
import '../../../../../services/index.dart';
import '../../../../../widgets/blog/blog_action_button_mixin.dart';
import '../../../../../widgets/blog/blog_card_view.dart';

class SubCategories extends StatefulWidget {
  static const String type = 'subCategories';

  final ScrollController? scrollController;

  const SubCategories({
    this.scrollController,
  });

  @override
  State<StatefulWidget> createState() {
    return SubCategoriesState();
  }
}

class SubCategoriesState extends State<SubCategories>
    with BlogActionButtonMixin {
  int selectedIndex = 0;
  final Services _service = Services();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<CategoryModel>(
      builder: (context, value, child) {
        if (value.isFirstLoad) {
          return kLoadingWidget(context);
        }
        var categories = value.categories
                ?.where((item) => item.parent.toString() == '0')
                .toList() ??
            [];
        if (categories.isEmpty) {
          return Center(
            child: Text(S.of(context).noData),
          );
        }
        return Column(
          children: <Widget>[
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Center(
                        child: Text(categories[index].displayName,
                            style: TextStyle(
                                fontSize: 18,
                                color: selectedIndex == index
                                    ? theme.primaryColor
                                    : theme.hintColor)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  var data = context.read<ArticleNotifier>().articles ;
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: data?.length,
                    itemBuilder: (context, index) => BlogCard(
                      item: data![index],
                      width: constraints.maxWidth,
                      onTap: () {

                        onTapBlog(article: data[index],);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
