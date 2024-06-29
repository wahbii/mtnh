class Show {
  final int id;
  final int count;
  final String description;
  final String link;
  final String name;
  final String slug;
  final Map<String, dynamic> links;

  Show({
    required this.id,
    required this.count,
    required this.description,
    required this.link,
    required this.name,
    required this.slug,
    required this.links,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      count: json['count'],
      description: json['description'],
      link: json['link'],
      name: json['name'],
      slug: json['slug'],
      links: json['_links'],
    );
  }
}
