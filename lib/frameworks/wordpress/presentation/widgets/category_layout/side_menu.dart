import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/config.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../models/index.dart';
import '../../../../../models/posts/article_provider.dart';
import '../../../../../services/index.dart';
import '../../../../../widgets/blog/blog_action_button_mixin.dart';
import '../../../../../widgets/blog/blog_card_view.dart';

class SideMenuCategories extends StatefulWidget {
  static const String type = 'sideMenu';

  const SideMenuCategories();

  @override
  State<StatefulWidget> createState() {
    return SideMenuCategoriesState();
  }
}

class SideMenuCategoriesState extends State<SideMenuCategories>
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

        return Row(
          children: <Widget>[
            Container(
              width: 100,
              color: Theme.of(context).primaryColorLight,
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 4, right: 4),
                      child: Center(
                        child: Text(
                          categories[index].displayName,
                          style: TextStyle(
                            fontSize: 10,
                            color: selectedIndex == index
                                ? theme.primaryColor
                                : theme.colorScheme.secondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(child: LayoutBuilder(

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
            ))
          ],
        );
      },
    );
  }
}
