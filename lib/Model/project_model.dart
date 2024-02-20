class ProjectList {
  String id;
  String project_name;
  String project_image;
  String location_name;

  ProjectList(
    this.id,
    this.project_name,
    this.project_image,
    this.location_name,
  );

  ProjectList.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    project_name = json['project_name'];
    project_image = json['project_image'];
    location_name = json['location_name'];
  }
}

class ProjectDetail {
  final String project_name;
  final String location_name;
  final String project_image;
  final String project_description;
  final String download_brochure;
  final String download_layout;
  ProjectDetail({
    this.project_name,
    this.location_name,
    this.project_image,
    this.project_description,
    this.download_brochure,
    this.download_layout,
  });

  factory ProjectDetail.fromJson(Map<String, dynamic> json) {
    return ProjectDetail(
      project_name: json['project_name'],
      location_name: json['location_name'],
      project_image: json['project_image'],
      project_description: json['project_description'],
      download_brochure: json['download_brochure'],
      download_layout: json['download_layout'],
    );
  }
}

class GallaryView {
  String image_url;

  GallaryView(
    this.image_url,
  );

  GallaryView.fromJson(Map<String, dynamic> json) {
    image_url = json['image_url'];
  }
}

class Videos {
  String video_link;

  Videos(
    this.video_link,
  );

  Videos.fromJson(Map<String, dynamic> json) {
    video_link = json['video_link'];
  }
}

class Gallery {
  String gallery_folder;
  String gallery_id;
  String total_count;

  Gallery(
    this.gallery_folder,
    this.gallery_id,
    this.total_count,
  );

  Gallery.fromJson(Map<String, dynamic> json) {
    gallery_folder = json['gallery_folder'];
    gallery_id = json['gallery_id'];
    total_count = json['total_count'];
  }
}

class Project_Gallery {
  String id;
  String project_id;
  String gallery_date;
  String gallery_name;
  String gallery_description;
  String udpated_at;

  Project_Gallery(
    this.id,
    this.project_id,
    this.gallery_date,
    this.gallery_name,
    this.gallery_description,
    this.udpated_at,
  );

  Project_Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    project_id = json['project_id'];
    gallery_date = json['gallery_date'];
    gallery_name = json['gallery_name'];
    gallery_description = json['gallery_description'];
    udpated_at = json['udpated_at'];
  }
}
