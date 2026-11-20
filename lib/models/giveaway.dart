class Giveaway {
  final int id;
  final String title;
  final String worth;
  final String thumbnail;
  final String image;
  final String description;
  final String instructions;
  final String openGiveawayUrl;
  final String publishedDate;
  final String type;
  final String platforms;
  final String endDate;
  final int users;
  final String status;

  Giveaway({
    required this.id,
    required this.title,
    required this.worth,
    required this.thumbnail,
    required this.image,
    required this.description,
    required this.instructions,
    required this.openGiveawayUrl,
    required this.publishedDate,
    required this.type,
    required this.platforms,
    required this.endDate,
    required this.users,
    required this.status,
  });

  factory Giveaway.fromJson(Map<String, dynamic> json) {
    return Giveaway(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      worth: json['worth'] ?? 'N/A',
      thumbnail: json['thumbnail'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      instructions: json['instructions'] ?? '',
      openGiveawayUrl: json['open_giveaway_url'] ?? '',
      publishedDate: json['published_date'] ?? '',
      type: json['type'] ?? '',
      platforms: json['platforms'] ?? '',
      endDate: json['end_date'] ?? 'N/A',
      users: json['users'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}
