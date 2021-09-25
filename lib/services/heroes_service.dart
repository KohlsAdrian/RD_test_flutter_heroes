import 'package:rd_test_flutter_heroes/models/heroes_model.dart';
import 'package:rd_test_flutter_heroes/utils/heroes_http.dart';

class HeroesService {
  HeroesService._();
  static HeroesService instance = HeroesService._();

  static const _base =
      'https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api';

  final _all = '$_base/all.json';
  final _id = '$_base/id/%.json';
  final _powerStats = '$_base/powerstats/%.json';
  final _appearance = '$_base/appearance/%.json';
  final _biography = '$_base/biography/%.json';
  final _connections = '$_base/connections/%.json';
  final _work = '$_base/work/%.json';

  Future<Iterable<HeroesModel>?> getHeroes() async {
    Iterable<HeroesModel>? heroes;

    await HeroesHttp.instance.request(
      _all,
      onSuccess: (result) {
        if (result is Iterable) {
          final mHeroes = result.map((e) => HeroesModel.fromJson(e));
          heroes = mHeroes;
        }
      },
    );

    return heroes;
  }

  Future<HeroesModel?> getHeroById(int heroId) async {
    HeroesModel? heroModel;

    await HeroesHttp.instance.request(
      _id.replaceAll('%', '$heroId'),
      onSuccess: (result) {
        if (result is Map) {
          final mHeroModel = HeroesModel.fromJson(result);
          heroModel = mHeroModel;
        }
      },
    );

    return heroModel;
  }

  Future<PowerStatsModel?> getHeroPowerStats(int heroId) async {
    PowerStatsModel? powerStatsModel;

    await HeroesHttp.instance.request(
      _powerStats.replaceAll('%', '$heroId'),
      onSuccess: (result) {
        if (result is Map) {
          final mPowerStatsModel = PowerStatsModel.fromJson(result);
          powerStatsModel = mPowerStatsModel;
        }
      },
    );

    return powerStatsModel;
  }

  Future<AppearanceModel?> getHeroAppearance(int heroId) async {
    AppearanceModel? appearanceModel;

    await HeroesHttp.instance.request(
      _appearance.replaceAll('%', '$heroId'),
      onSuccess: (result) {
        if (result is Map) {
          final mAppearanceModel = AppearanceModel.fromJson(result);
          appearanceModel = mAppearanceModel;
        }
      },
    );

    return appearanceModel;
  }

  Future<BiographyModel?> getHeroBiography(int heroId) async {
    BiographyModel? biographyModel;

    await HeroesHttp.instance.request(
      _biography.replaceAll('%', '$heroId'),
      onSuccess: (result) {
        if (result is Map) {
          final mBiographyModel = BiographyModel.fromJson(result);
          biographyModel = mBiographyModel;
        }
      },
    );

    return biographyModel;
  }

  Future<WorkModel?> getHeroWork(int heroId) async {
    WorkModel? workModel;

    await HeroesHttp.instance.request(
      _work.replaceAll('%', '$heroId'),
      onSuccess: (result) {
        if (result is Map) {
          final mWorkModel = WorkModel.fromJson(result);
          workModel = mWorkModel;
        }
      },
    );

    return workModel;
  }

  Future<ConnectionsModel?> getHeroConnections(int heroId) async {
    ConnectionsModel? connectionsModel;

    await HeroesHttp.instance.request(
      _connections.replaceAll('%', '$heroId'),
      onSuccess: (result) {
        if (result is Map) {
          final mConnectionsModel = ConnectionsModel.fromJson(result);
          connectionsModel = mConnectionsModel;
        }
      },
    );

    return connectionsModel;
  }
}
