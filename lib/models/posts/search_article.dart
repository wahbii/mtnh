class PostArticle {
  final int id;
  final String? title;
  final String? url;
  final String? type;
  final String? subtype;
  final String? sanitizedTitle;
  final String? sanitizedExcerpt;
  final String? mrssThumbnail;
  final List<String>? showTitles;
  final List<String>? tagNames;
  final List<String>? categoryTitles;
  final Map<String, dynamic>? links;

  PostArticle({
    required this.id,
    this.title,
    this.url,
    this.type,
    this.subtype,
    this.sanitizedTitle,
    this.sanitizedExcerpt,
    this.mrssThumbnail,
    this.showTitles,
    this.tagNames,
    this.categoryTitles,
    this.links,
  });

  factory PostArticle.fromJson(Map<String, dynamic> json) {
    return PostArticle(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      type: json['type'],
      subtype: json['subtype'],
      sanitizedTitle: json['sanitized_title'],
      sanitizedExcerpt: json['sanitized_excerpt'],
      mrssThumbnail: json['mrss_thumbnail'],
      showTitles: json['show_titles'] != null ? List<String>.from(json['show_titles']) : null,
      tagNames: json['tag_names'] != null ? List<String>.from(json['tag_names']) : null,
      categoryTitles: json['category_titles'] != null ? List<String>.from(json['category_titles']) : null,
      links: json['_links'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'type': type,
      'subtype': subtype,
      'sanitized_title': sanitizedTitle,
      'sanitized_excerpt': sanitizedExcerpt,
      'mrss_thumbnail': mrssThumbnail,
      'show_titles': showTitles,
      'tag_names': tagNames,
      'category_titles': categoryTitles,
      '_links': links,
    };
  }
}
