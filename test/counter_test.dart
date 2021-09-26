import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rd_test_flutter_heroes/test.dart';

void main() {
  final lh = LoadHeroes();
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
    'Retrieve all heroes, Retrieve Hero By ID, retrieve other info from splited APIs and matches From Hero Full Object and splited objects APIs',
    () async {
      const heroId = 1;

      final heroes = await lh.retrieveAll();

      final hero = heroes?.firstWhereOrNull((h) => h.id == heroId);

      final heroById = await lh.retrieveHeroById(heroId);

      expect(
        hero?.name == heroById?.name,
        true,
      );
      expect(
        hero?.slug == heroById?.slug,
        true,
      );

      final heroPowerStats = hero?.powerStats;

      final heroPowerStatsById = await lh.retrieveHeroPowerStats(heroId);

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
    },
  );
}
