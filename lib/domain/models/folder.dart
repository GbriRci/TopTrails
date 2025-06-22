class Folder {
  final String folderId;
  final String name;
  final List<String> trailsId;
  final String imageUrl;

  Folder({
    required this.folderId,
    required this.name,
    required this.trailsId,
    required this.imageUrl,
  });

  factory Folder.fromFirestore(String uid, Map<String, dynamic> data) {
    return Folder(
      folderId: uid,
      name: data['name'] ?? '',
      trailsId: List<String>.from(data['trailsId'] ?? []),
      imageUrl: data['imageUrl'] ?? 'assets/images/logo.png',
    );
  }

  Folder copyWith({
    String? folderId,
    String? name,
    List<String>? trailsId,
    String? imageUrl,
  }) {
    return Folder(
      folderId: folderId ?? this.folderId,
      name: name ?? this.name,
      trailsId: trailsId ?? this.trailsId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return "Uid: $folderId, Name: $name, TrailsId: $trailsId, ImageUrl: $imageUrl";
  }
}
