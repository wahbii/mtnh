import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../models/posts/article_model.dart';
import '../../../routes/flux_navigate.dart';
import '../../../screens/blog/views/blog_detail_screen.dart';
import '../helper/header_view.dart';
import 'models/story_config.dart';
import 'story_card.dart';
import 'story_collection.dart';
import 'story_constants.dart';

class StoryWidget extends StatefulWidget {
  final bool isFullScreen;
  final List<Article> articles;
  final bool showChat;

  const StoryWidget({
    super.key,
    required this.articles,
    this.isFullScreen = false,
    this.showChat = false,
  });

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  List<Article> get _storyConfig => widget.articles;

  List<StoryCard> renderListStoryCard(
      {double? ratioWidth, double? ratioHeight}) {
    var items = <StoryCard>[];
    for (var item in _storyConfig ?? []) {
      items.add(
        StoryCard(
          story: item,
          key: UniqueKey(),
          ratioWidth: 16,
          ratioHeight: 9,
          buildContext: context,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {


    if (widget.isFullScreen) {
      return StoryCollection(
        listStory: renderListStoryCard(),
        pageCurrent: 0,
        isHorizontal: true,
        showChat: widget.showChat,
        isTab: true,
      );
    } else {
      return _renderListCartStory();
    }
  }

  Widget _renderListCartStory() {
    const space = SizedBox(width: 12.0);
    final screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraint) {

        var listStoryCard = renderListStoryCard(
          ratioWidth: screenSize.width ,
          ratioHeight: screenSize.height,
        );
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    space,
                    ...List.generate(
                      listStoryCard.length,
                      (index) {
                        return
                        InkWell(
                            child:
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                20),child:
                          SizedBox(
                          width: 250,
                          height: 150,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: StoryConstants.spaceBetweenStory),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      20),
                                  child: InteractiveViewer(
                                    minScale: 2,
                                    maxScale: 2,
                                    child: listStoryCard[index],
                                  ),
                                ),
                              ),


                              _openFullScreenStory(context, index),
                            ],
                          ),
                        )));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _openFullScreenStory(BuildContext context, int index) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        key: ValueKey('${StoryConstants.storyTapKey}$index'),
        onTap: () {

          FluxNavigate.pushNamed(
            RouteList.detailBlog,
            arguments: BlogDetailArguments(
              id: widget.articles[index].id.toString(),
              blog: widget.articles[index],
            ),
            forceRootNavigator: false,
          );
          /*FluxNavigate.push(
            MaterialPageRoute(
              builder: (context) => StoryCollection(
                listStory: renderListStoryCard(),
                pageCurrent: index,
                isHorizontal: true,
              ),
            ),
          );*/
        },
      ),
    );
  }
}

