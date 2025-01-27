import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../models/index.dart';
import '../../../../../../models/posts/article_model.dart';
import '../../../../../../models/posts/article_provider.dart';
import '../../../../../../services/index.dart';
import '../../../../../../widgets/blog/blog_action_button_mixin.dart';
import '../../../../../../widgets/blog/blog_card_view.dart';
import 'list_card.dart';

class MenuCard extends StatefulWidget {
  final List<Category> categories;
  final Category category;

  const MenuCard(this.categories, this.category);

  @override
  State<MenuCard> createState() => _StateMenuCard();
}

class _StateMenuCard extends State<MenuCard> with BlogActionButtonMixin {
  int position = 0;
  int pColor = 0;
  double _width = 0.0;
  int durations = 0;

  Future<List<Blog>> getProductFromCategory(
      {categoryId, minPrice, maxPrice, orderBy, order, lang, page}) async {
    var service = Services();
    final product = await service.api
        .fetchBlogsByCategory(categoryId: categoryId, page: page);
    return product;
  }

  Future<List<List<Blog>>> getAllListProducts({page = 1}) async {
    var products = <List<Blog>>[];
    var service = Services();
    for (var category in widget.categories) {
      var product = await service.api.fetchBlogsByCategory(
        categoryId: category.id,
        page: page,
      );
      products.add(product);
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var productHeight = constraints.maxWidth * 0.5;

        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.category.name!.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              widget.categories.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      height: 26,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              if (position == index) return;
                              setState(() {
                                _width = constraints.maxWidth - 50;
                                durations = 0;
                                pColor = index;
                              });
                              await Future.delayed(
                                  const Duration(milliseconds: 50));
                              setState(() {
                                position = index;
                                durations = 200;
                                _width = 0.0;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: index == pColor
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      child: Center(
                                        child: index == pColor
                                            ? Text(
                                                widget.categories[index].name!,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                widget.categories[index].name!,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: widget.categories.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
              widget.categories.isEmpty
                  ? const SizedBox()
                  : Container(
                      height: 20,
                    ),
              SizedBox(
                height: productHeight,
                child: SingleChildScrollView(
                  child: Row(
                    children: <Widget>[
                      AnimatedContainer(
                        width: _width,
                        duration: Duration(milliseconds: durations),
                        decoration: const BoxDecoration(),
                      ),
                      Expanded(
                        child: ListCard(
                          data: context.read<ArticleNotifier>().articles,
                          width: constraints.maxWidth,
                          id: widget.categories[position].id.toString(),
                        ),
                      )
                    ],
                  ),
                ),
              ),



            ],
          ),
        );
      },
    );
  }
}
