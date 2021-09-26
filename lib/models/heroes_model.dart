class HeroesModel {
  final int id;
  final String name;
  final String slug;
  final PowerStatsModel powerStats;
  final AppearanceModel appearance;
  final BiographyModel biography;
  final WorkModel work;
  final ConnectionsModel connections;
  final ImagesModel images;

  HeroesModel(
    this.id,
    this.name,
    this.slug,
    this.powerStats,
    this.appearance,
    this.biography,
    this.work,
    this.connections,
    this.images,
  );

  String get safeName => biography.fullName.isNotEmpty
      ? name
      : biography.fullName.isEmpty
          ? name
          : biography.fullName;
  bool get isMarvel => biography.publisher.contains('Marvel');
  bool get isDC => biography.publisher.contains('DC');

  factory HeroesModel.fromJson(Map json) {
    int id = json['id'];
    String name = json['name'];
    String slug = json['slug'];
    PowerStatsModel powerStats = PowerStatsModel.fromJson(json['powerstats']);
    AppearanceModel appearance = AppearanceModel.fromJson(json['appearance']);
    BiographyModel biography = BiographyModel.fromJson(json['biography']);
    WorkModel work = WorkModel.fromJson(json['work']);
    ConnectionsModel connections =
        ConnectionsModel.fromJson(json['connections']);
    ImagesModel images = ImagesModel.fromJson(json['images']);
    return HeroesModel(
      id,
      name,
      slug,
      powerStats,
      appearance,
      biography,
      work,
      connections,
      images,
    );
  }
}

class PowerStatsModel {
  final int intelligence;
  final int strength;
  final int speed;
  final int durability;
  final int power;
  final int combat;

  PowerStatsModel(
    this.intelligence,
    this.strength,
    this.speed,
    this.durability,
    this.power,
    this.combat,
  );

  int get level {
    double xp = intelligence * 1.2;
    xp += strength * 0.5;
    xp += speed * 0.7;
    xp += durability * 0.9;
    xp += power * 0.5;
    xp += combat * 0.6;

    return xp.toInt();
  }

  factory PowerStatsModel.fromJson(Map json) {
    int intelligence = json['intelligence'];
    int strength = json['strength'];
    int speed = json['speed'];
    int durability = json['durability'];
    int power = json['power'];
    int combat = json['combat'];

    return PowerStatsModel(
      intelligence,
      strength,
      speed,
      durability,
      power,
      combat,
    );
  }
}

class AppearanceModel {
  final String gender;
  final String race;
  final Iterable<String> height;
  final Iterable<String> weight;
  final String eyeColor;
  final String hairColor;

  AppearanceModel(
    this.gender,
    this.race,
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
  );

  bool? get isMale => gender == 'Male'
      ? true
      : gender == 'Female'
          ? false
          : null;

  factory AppearanceModel.fromJson(Map json) {
    String gender = json['gender'];
    String race = json['race'] ?? '';
    if (race.isEmpty) {
      race = 'Unknown';
    }
    Iterable<String> height =
        (json['height'] as Iterable).map<String>((e) => e);
    Iterable<String> weight =
        (json['weight'] as Iterable).map<String>((e) => e);
    String eyeColor = json['eyeColor'];
    String hairColor = json['hairColor'];
    return AppearanceModel(
      gender,
      race,
      height,
      weight,
      eyeColor,
      hairColor,
    );
  }
}

class BiographyModel {
  final String fullName;
  final String alterEgos;
  final Iterable<String> aliases;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;

  BiographyModel(
    this.fullName,
    this.alterEgos,
    this.aliases,
    this.placeOfBirth,
    this.firstAppearance,
    this.publisher,
    this.alignment,
  );

  factory BiographyModel.fromJson(Map json) {
    String fullName = json['fullName'];
    String alterEgos = json['alterEgos'];
    Iterable<String> aliases =
        (json['aliases'] as Iterable).map<String>((e) => e);
    String placeOfBirth = json['placeOfBirth'];
    String firstAppearance = json['firstAppearance'];
    String publisher = json['publisher'] ?? '';
    if (publisher.isEmpty) {
      publisher = 'Unknown';
    }
    String alignment = json['alignment'];
    return BiographyModel(
      fullName,
      alterEgos,
      aliases,
      placeOfBirth,
      firstAppearance,
      publisher,
      alignment,
    );
  }
}

class WorkModel {
  final String occupation;
  final String base;

  WorkModel(
    this.occupation,
    this.base,
  );

  factory WorkModel.fromJson(Map json) {
    String occupation = json['occupation'];
    String base = json['base'];
    return WorkModel(occupation, base);
  }
}

class ConnectionsModel {
  final String groupAffiliation;
  final String relatives;

  ConnectionsModel(
    this.groupAffiliation,
    this.relatives,
  );

  factory ConnectionsModel.fromJson(Map json) {
    String groupAffiliation = json['groupAffiliation'];
    String relatives = json['relatives'];
    return ConnectionsModel(groupAffiliation, relatives);
  }
}

class ImagesModel {
  /// `xs` - Thumbnail
  final String xs;

  /// `sm` - Small
  final String sm;

  /// `md` - Medium
  final String md;

  /// `lg` - Large
  final String lg;

  ImagesModel(
    this.xs,
    this.sm,
    this.md,
    this.lg,
  );

  factory ImagesModel.fromJson(Map json) {
    String xs = json['xs'];
    String sm = json['sm'];
    String md = json['md'];
    String lg = json['lg'];

    return ImagesModel(xs, sm, md, lg);
  }
}
