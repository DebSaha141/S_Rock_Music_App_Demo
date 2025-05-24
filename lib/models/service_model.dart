class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String iconPath;
  final int order;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.order,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map, String id) {
    return ServiceModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      iconPath: map['iconPath'] ?? '',
      order: map['order'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'iconPath': iconPath,
      'order': order,
    };
  }
}