class AboutUs {
  final String content;
  AboutUs({
    this.content,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) {
    return AboutUs(
      content: json['content'],
    );
  }
}

class BannerImage {
  String images;
  String content;

  BannerImage(
    this.images,
    this.content,
  );

  BannerImage.fromJson(Map<String, dynamic> json) {
    images = json['images'];
    content = json['content'];
  }
}
