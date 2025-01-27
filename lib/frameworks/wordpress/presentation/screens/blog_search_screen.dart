import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/config.dart';
import '../../../../common/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/blog_search_model.dart';
import '../../../../models/posts/article_provider.dart';
import '../../../../models/posts/search_provider.dart';
import '../../../../screens/common/app_bar_mixin.dart';
import '../../../../screens/search/widgets/search_empty_result.dart';
import '../widgets/blog_list.dart';
import '../widgets/blog_recent_search.dart';

class BlogSearchScreen extends StatefulWidget {
  final bool? boostEngine;

  const BlogSearchScreen({
    super.key,
    this.boostEngine,
  });

  @override
  State<BlogSearchScreen> createState() => _StateSearchScreen();
}

class _StateSearchScreen extends State<BlogSearchScreen> with AppBarMixin {
  bool isVisibleSearch = false;
  String searchText = '';
  var textController = TextEditingController();
  Timer? _timer;
  late FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isVisibleSearch = _focus.hasFocus;
    });
  }

  Widget _renderSearchLayout() {
    return searchText.isEmpty
        ? BlogRecentSearch(
            onTap: (text) {
              setState(() {
                searchText = text;
              });
              textController.text = text;
              FocusScope.of(context)
                  .requestFocus(FocusNode()); //dismiss keyboard
              Provider.of<BlogSearchModel>(context, listen: false).searchBlogs(
                name: text,
                boostEngine: widget.boostEngine,
              );
            },
          )
        : Consumer<SearchNotifier>(builder: (context, articleNotifier, child) {
            if (articleNotifier.isLoadingSearch) {
              return kLoadingWidget(context);
            }

            if (articleNotifier.errorMessageSearch != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                    child: Text(articleNotifier.errorMessageSearch.toString(),
                        style: const TextStyle(color: kErrorRed))),
              );
            }
            if (articleNotifier.searchArticles.isEmpty) {
              return const EmptySearch();
            } else {
              return Column(
                children: <Widget>[

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface),
                      child: BlogListSearch(
                          name: searchText,
                          blogs: articleNotifier.searchArticles),
                    ),
                  )
                ],
              );
            }
            return Container();
          });
  }

  AppBar? renderAppBar() {
    if (Navigator.canPop(context)) {
      return AppBar(
        elevation: 0.1,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          S.of(context).search,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        leading: Navigator.of(context).canPop()
            ? Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              )
            : const SizedBox(),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return renderScaffold(
      routeName: RouteList.search,
      secondAppBar: renderAppBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      child: Column(
        children: <Widget>[
          if (!Navigator.canPop(context)) ...[
            AnimatedContainer(
              height: isVisibleSearch ? 0 : 40,
              padding: const EdgeInsets.only(left: 15, top: 10),
              duration: const Duration(milliseconds: 250),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(S.of(context).search,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
          Row(children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.search,
                      color: Colors.black45,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: textController,
                        focusNode: _focus,
                        onChanged: (text) {

                              setState(() {
                                searchText = text;
                              });

                        },
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).colorScheme.secondary,
                          border: InputBorder.none,
                          hintText: S.of(context).searchForItems,
                        ),
                      ),
                    ),
                    InkWell(child: Container(
                      padding: EdgeInsets.only(left:  10,right: 10,top: 5,bottom: 5),
                      width: 70,
                      child: Text("search",style: TextStyle(fontWeight: FontWeight.w700),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                    ),onTap: (){
                      if(searchText.isNotEmpty){
                        context
                            .read<SearchNotifier>()
                            .searcharticles(searchText);
                      };
                    },)
                  ],
                ),
              ),
            ),
          ]),
          Expanded(child: _renderSearchLayout()),
        ],
      ),
    );
  }
}
