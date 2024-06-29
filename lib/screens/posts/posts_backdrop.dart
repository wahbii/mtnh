import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../generated/l10n.dart';
import '../../models/entities/filter_sorty_by.dart';
import '../../models/index.dart' show AppModel, Blog, BlogModel;
import '../../models/posts/article_model.dart';
import '../../models/shows/shows_model.dart';
import '../../modules/dynamic_layout/config/blog_config.dart';
import '../../services/index.dart';
import '../../widgets/backdrop/backdrop.dart';
import '../../widgets/backdrop/filter.dart';
import '../../widgets/blog/blog_list_backdrop.dart';
import '../common/app_bar_mixin.dart';

class BlogsPage extends StatefulWidget {
  final List<Article>? blogs;
  final List<Show>? shows;
  final String? title ;
  final BlogConfig config;

  const BlogsPage({this.blogs,this.shows ,this.title ,required this.config});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage>
    with SingleTickerProviderStateMixin, AppBarMixin {

  FilterSortBy _currentFilterSortBy = const FilterSortBy();

  late AnimationController _controller;

  BlogModel get blogModel => context.read<BlogModel>();
  AppModel get appModel => context.read<AppModel>();


  // If this blog layout have some special params, such as author, search,
  // include,... then we should disable filter
  bool get isEnableFilter => true;

  bool get allowMultipleCategory => ServerConfig().allowMultipleCategory;

  bool get allowMultipleTag => ServerConfig().allowMultipleTag;

  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
      value: 1.0,
    );

    WidgetsBinding.instance.endOfFrame.then((_) {

    });
  }

  // No need call filter function if this blog layout have some special params
  void onFilter({
    dynamic minPrice,
    dynamic maxPrice,
    List<String>? categoryId,
    String? categoryName,
    List<String>? tagId,
    attribute,
    currentSelectedTerms,
    String? listingLocationId,
    bool? isSearch,
    FilterSortBy? sortBy,
    List<String>? brandIds,
    dynamic attributes,
  }) {
    print("hello : ${sortBy}");
    if(sortBy?.orderByType == OrderByType.title){
      switch( sortBy?.orderType){
        case OrderType.asc :{
          setState(() {
            widget.blogs?.sort((a, b) => (a.date ?? DateTime.timestamp()).compareTo((b.date ?? DateTime.timestamp())));
          });
        }
        case OrderType.desc :{
          setState(() {
            widget.blogs?.sort((a, b) => (b.date ?? DateTime.timestamp()).compareTo((a.date ?? DateTime.timestamp())));
          });
        }
        case null:
        // TODO: Handle this case.
      }
    }else {
      switch( sortBy?.orderType){
        case OrderType.asc :{
          setState(() {
            widget.blogs?.sort((a, b) => (a.sanitizedTitle ?? "").compareTo((b.sanitizedTitle ?? "")));
          });
        }
        case OrderType.desc :{
          setState(() {
            widget.blogs?.sort((a, b) => (b.sanitizedTitle ?? "").compareTo((a.sanitizedTitle ?? "")));

          });
        }
        case null:
        // TODO: Handle this case.
      }
    }

  }

  Future<void> onRefresh() async {

  }

  void onLoadMore(int page) {

  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    var textColor = Colors.white;
    var data = widget.shows == null ? widget.blogs : widget.shows ;

    // list
    _PostBackdrop backdrop({blogs, isFetching, errMsg, isEnd}) => _PostBackdrop(
          backdrop: Backdrop(
            hasAppBar: showAppBar(RouteList.backdrop),
            frontLayer: BlogListBackdrop(
              blog: widget.blogs,
              shows: widget.shows,
              onRefresh: onRefresh,
              onLoadMore: onLoadMore,
              isFetching: false,
              errMsg: errMsg,
              isEnd: isEnd,
              layout: 'list',
            ),
            backLayer: FilterWidget(
              onFilter: onFilter,
              sortBy: _currentFilterSortBy,
              showCategory: false,
              showTag: false,
              showPrice: false,
              showAttribute: false,
              isUseBlog: !ServerConfig().isWordPress,
              isBlog: true,
              categoryId: null,
              tagId: null,
              allowMultipleCategory: allowMultipleCategory,
              allowMultipleTag: allowMultipleTag,
              onApply: () {
                _controller.forward();
              },
            ),
            frontTitle: Text(title ?? "", style: TextStyle(color: textColor)),
            backTitle: Center(
              child: Text(
                S.of(context).filter,
                style: TextStyle(color: textColor),
              ),
            ),
            controller: _controller,
            isBlog: true,
            showFilter: (widget.blogs == null ) ? false : true  ,
          ),
        );
    return  renderScaffold(
      routeName: RouteList.backdrop,
      child: backdrop(
        blogs: data,
        isFetching: false,
        errMsg: "",
        isEnd: false,
      ),
    );
  }
}

class _PostBackdrop extends StatelessWidget {
//  final ExpandingBottomSheet expandingBottomSheet;
  final Backdrop backdrop;

  const _PostBackdrop({required this.backdrop});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        backdrop,
      ],
    );
  }
}
