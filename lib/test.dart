import 'package:rd_test_flutter_heroes/models/heroes_model.dart';
import 'package:rd_test_flutter_heroes/services/heroes_service.dart';

class TestHeroes {
  Future<Iterable<HeroesModel>?> retrieveAll() async {
    final heroes = await HeroesService.instance.getHeroes();
    return heroes;
  }

  Future<HeroesModel?> retrieveHeroById(int heroId) async {
    final hero = await HeroesService.instance.getHeroById(heroId);
    return hero;
  }

  Future<PowerStatsModel?> retrieveHeroPowerStats(int heroId) async {
    final powerStats = await HeroesService.instance.getHeroPowerStats(heroId);
    return powerStats;
  }

  Future<AppearanceModel?> retrieveHeroAppearance(int heroId) async {
    final appearance = await HeroesService.instance.getHeroAppearance(heroId);
    return appearance;
  }

  Future<BiographyModel?> retrieveHeroBiography(int heroId) async {
    final biography = await HeroesService.instance.getHeroBiography(heroId);
    return biography;
  }

  Future<WorkModel?> retrieveHeroWork(int heroId) async {
    final work = await HeroesService.instance.getHeroWork(heroId);
    return work;
  }

  Future<ConnectionsModel?> retrieveHeroConnections(int heroId) async {
    final connections = await HeroesService.instance.getHeroConnections(heroId);
    return connections;
  }
}
