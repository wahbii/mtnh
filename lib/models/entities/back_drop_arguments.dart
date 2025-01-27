class BackDropArguments {
  final String? cateId;
  final String? cateName;
  final String? tag;
  final String? title;
  final List? data;
  final Map? config;
  final String? brandId;
  final String? brandName;
  final String? brandImg;
  final bool showCountdown;

  Duration countdownDuration = Duration.zero;

  BackDropArguments({
    this.cateId,
    this.cateName,
    this.tag,
    this.data,
    this.title,
    this.config,
    this.brandId,
    this.brandName,
    this.brandImg,
    this.showCountdown = false,
    this.countdownDuration = Duration.zero,
  });
}
