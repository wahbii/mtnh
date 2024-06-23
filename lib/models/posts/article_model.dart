class Article {
  final int id;
  final DateTime date;
  final String content;
  final String streamUrl;
  final int viewsCount7Days;
  final List<String> categoryTitles;
  final String sanitizedTitle;
  final String sanitizedExcerpt;
  final String mrssThumbnail;

  Article({
    required this.id,
    required this.date,
    required this.content,
    required this.streamUrl,
    required this.viewsCount7Days,
    required this.categoryTitles,
    required this.sanitizedTitle,
    required this.sanitizedExcerpt,
    required this.mrssThumbnail,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      date: DateTime.parse(json['date']),
      content: json['content']['rendered'],
      streamUrl: json['wpcf-stream_url'],
      viewsCount7Days: int.parse(json['post_views_count_7_day_total']),
      categoryTitles: List<String>.from(json['category_titles']),
      sanitizedTitle: json['sanitized_title'],
      sanitizedExcerpt: json['sanitized_excerpt'],
      mrssThumbnail: json['mrss_thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'content': {'rendered': content, 'protected': false},
      'wpcf-stream_url': streamUrl,
      'post_views_count_7_day_total': viewsCount7Days.toString(),
      'category_titles': categoryTitles,
      'sanitized_title': sanitizedTitle,
      'sanitized_excerpt': sanitizedExcerpt,
      'mrss_thumbnail': mrssThumbnail,
    };
  }
}
