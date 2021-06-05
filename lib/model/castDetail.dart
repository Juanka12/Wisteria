class CastDetail {
  final int id;
  final String name;
  final String birthday;
  final String deathday;
  final String biography;
  final String birthPlace;
  final String profilePath;

  CastDetail(this.id, this.name, this.birthday, this.deathday, this.biography, this.birthPlace, this.profilePath);

  CastDetail.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        birthday = json["birthday"],
        deathday = json["deathday"],
        biography = json["biography"],
        birthPlace = json["place_of_birth"],
        profilePath = json["profile_path"];
}