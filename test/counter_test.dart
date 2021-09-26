import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rd_test_flutter_heroes/test.dart';

void main() {
  final lh = TestHeroes();
  test(
    'Retrieve All heroes',
    () async {
      final heroes = await lh.retrieveAll();
      expect(
        heroes != null,
        true,
      );
    },
  );

  test(
    'Retrieve Hero By ID and it is an expected hero',
    () async {
      const heroId = 1;
      final hero = await lh.retrieveHeroById(heroId);
      expect(
        hero?.name,
        'A-Bomb',
      );
    },
  );

  test(
    'Retrieve Hero By ID and it is an unexpected hero',
    () async {
      const heroId = 99;
      final hero = await lh.retrieveHeroById(heroId);
      expect(
        hero?.name,
        isNot('Iron Man'),
      );
    },
  );
  test(
    'Retrieve Hero PowerStats and expected stats',
    () async {
      const heroId = 99;
      final powerStats = await lh.retrieveHeroPowerStats(heroId);
      expect(powerStats?.level, 183);
      expect(
        powerStats?.combat,
        70,
      );
      expect(
        powerStats?.durability,
        10,
      );
      expect(
        powerStats?.intelligence,
        75,
      );
      expect(
        powerStats?.power,
        23,
      );
      expect(
        powerStats?.speed,
        33,
      );
      expect(
        powerStats?.strength,
        16,
      );
    },
  );

  test(
    'Retrieve all APIs and Match with full Hero Object',
    () async {
      const heroId = 1;

      final heroes = await lh.retrieveAll();

      final hero = heroes?.firstWhereOrNull((h) => h.id == heroId);

      final heroPowerStats = hero?.powerStats;
      final heroAppearance = hero?.appearance;
      final heroBiography = hero?.biography;
      final heroConnections = hero?.connections;
      final heroWork = hero?.work;

      final heroById = await lh.retrieveHeroById(heroId);
      expect(heroById != null, true);

      final mHeroId = heroById!.id;

      final heroPowerStatsById = await lh.retrieveHeroPowerStats(mHeroId);
      final heroAppearanceById = await lh.retrieveHeroAppearance(mHeroId);
      final heroBiographyById = await lh.retrieveHeroBiography(mHeroId);
      final heroConnectionsById = await lh.retrieveHeroConnections(mHeroId);
      final heroWorkById = await lh.retrieveHeroWork(mHeroId);

      /// Hero
      expect(
        hero?.id == heroById.id,
        true,
      );
      expect(
        hero?.name == heroById.name,
        true,
      );
      expect(
        hero?.slug == heroById.slug,
        true,
      );

      /// Power Stats
      expect(
        heroPowerStats?.level == heroPowerStatsById?.level,
        true,
      );
      expect(
        heroPowerStats?.combat == heroPowerStatsById?.combat,
        true,
      );
      expect(
        heroPowerStats?.durability == heroPowerStatsById?.durability,
        true,
      );
      expect(
        heroPowerStats?.strength == heroPowerStatsById?.strength,
        true,
      );
      expect(
        heroPowerStats?.speed == heroPowerStatsById?.speed,
        true,
      );
      expect(
        heroPowerStats?.power == heroPowerStatsById?.power,
        true,
      );
      expect(
        heroPowerStats?.intelligence == heroPowerStatsById?.intelligence,
        true,
      );

      /// Appearance
      expect(
        heroAppearance?.gender == heroAppearanceById?.gender,
        true,
      );
      expect(
        heroAppearance?.race == heroAppearanceById?.race,
        true,
      );
      expect(
        const ListEquality().equals(
          heroAppearance?.height.toList(),
          heroAppearanceById?.height.toList(),
        ),
        true,
      );
      expect(
        const ListEquality().equals(
          heroAppearance?.weight.toList(),
          heroAppearanceById?.weight.toList(),
        ),
        true,
      );
      expect(
        heroAppearance?.eyeColor == heroAppearanceById?.eyeColor,
        true,
      );
      expect(
        heroAppearance?.hairColor == heroAppearanceById?.hairColor,
        true,
      );

      /// Biography
      expect(
        heroBiography?.fullName == heroBiographyById?.fullName,
        true,
      );
      expect(
        heroBiography?.alterEgos == heroBiographyById?.alterEgos,
        true,
      );
      expect(
        const ListEquality().equals(
          heroBiography?.aliases.toList(),
          heroBiographyById?.aliases.toList(),
        ),
        true,
      );
      expect(
        heroBiography?.placeOfBirth == heroBiographyById?.placeOfBirth,
        true,
      );
      expect(
        heroBiography?.firstAppearance == heroBiographyById?.firstAppearance,
        true,
      );
      expect(
        heroBiography?.publisher == heroBiographyById?.publisher,
        true,
      );
      expect(
        heroBiography?.alignment == heroBiographyById?.alignment,
        true,
      );

      /// Work
      expect(
        heroWork?.occupation == heroWorkById?.occupation,
        true,
      );
      expect(
        heroWork?.base == heroWorkById?.base,
        true,
      );

      /// Connections
      expect(
        heroConnections?.groupAffiliation ==
            heroConnectionsById?.groupAffiliation,
        true,
      );
      expect(
        heroConnections?.relatives == heroConnectionsById?.relatives,
        true,
      );
    },
  );
}
