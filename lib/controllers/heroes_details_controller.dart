import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rd_test_flutter_heroes/models/heroes_model.dart';
import 'package:rd_test_flutter_heroes/services/heroes_service.dart';

class HeroesDetailsController extends GetxController {
  HeroesDetailsController(this.heroId);
  final int heroId;

  HeroesModel? _heroesModel;
  HeroesModel? get heroesModel => _heroesModel;

  PowerStatsModel? _powerStatsModel;
  AppearanceModel? _appearanceModel;
  BiographyModel? _biographyModel;
  ConnectionsModel? _connectionsModel;
  WorkModel? _workModel;

  PowerStatsModel? get powerStatsModel => _powerStatsModel;
  AppearanceModel? get appearanceModel => _appearanceModel;
  BiographyModel? get biographyModel => _biographyModel;
  ConnectionsModel? get connectionsModel => _connectionsModel;
  WorkModel? get workModel => _workModel;

  bool _loading = true;
  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        final mHero = await HeroesService.instance.getHeroById(heroId);
        if (mHero != null) {
          _heroesModel = mHero;
        }
        _loading = false;
        update();

        HeroesService.instance.getHeroPowerStats(heroId).then(
          (powerStats) {
            _powerStatsModel = powerStats;
            update();
          },
        );
        HeroesService.instance.getHeroAppearance(heroId).then(
          (appearance) {
            _appearanceModel = appearance;
            update();
          },
        );
        HeroesService.instance.getHeroBiography(heroId).then(
          (biography) {
            _biographyModel = biography;
            update();
          },
        );
        HeroesService.instance.getHeroBiography(heroId).then(
          (biography) {
            _biographyModel = biography;
            update();
          },
        );
        HeroesService.instance.getHeroWork(heroId).then(
          (work) {
            _workModel = work;
            update();
          },
        );
        HeroesService.instance.getHeroConnections(heroId).then(
          (connections) {
            _connectionsModel = connections;
            update();
          },
        );
      },
    );
  }
}
