import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rd_test_flutter_heroes/models/heroes_model.dart';
import 'package:rd_test_flutter_heroes/services/heroes_service.dart';
import 'package:rd_test_flutter_heroes/views/heroes_details_ui.dart';

class HeroesListController extends GetxController {
  bool _loading = true;
  bool get loading => _loading;

  Iterable<HeroesModel>? _heroes;
  Iterable<HeroesModel> get heroes => _heroes ?? [];

  bool _showChips = false;
  bool get showChips => _showChips;

  final _selectedPublisher = <String, bool>{};
  final _selectedRace = <String, bool>{};
  final _selectedGender = <String, bool>{};

  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        final mHeroes = await HeroesService.instance.getHeroes();
        if (mHeroes != null) {
          _heroes = mHeroes;
        }
        _loading = false;
        update();
      },
    );
  }

  void clearAll() {
    _selectedPublisher.clear();
    _selectedRace.clear();
    _selectedGender.clear();
    searchController.clear();
    update();
  }

  bool get hasPublishFilter =>
      _selectedPublisher.values.where((e) => e).isNotEmpty;
  bool get hasRaceFilter => _selectedRace.values.where((e) => e).isNotEmpty;
  bool get hasGenderFilter => _selectedGender.values.where((e) => e).isNotEmpty;

  bool isPublisherSelected(String publisher) =>
      _selectedPublisher[publisher] ?? false;
  bool isRaceSelected(String race) => _selectedRace[race] ?? false;
  bool isGenderSelected(String gender) => _selectedGender[gender] ?? false;

  String? onChanged(String? text) {
    update();
  }

  void tapPublisher(String publisher) {
    _selectedPublisher[publisher] = !isPublisherSelected(publisher);
    update();
  }

  void tapRace(String race) {
    _selectedRace[race] = !isRaceSelected(race);
    update();
  }

  void tapGender(String gender) {
    _selectedGender[gender] = !isGenderSelected(gender);
    update();
  }

  void toggleChips() {
    _showChips = !_showChips;
    update();
  }

  void onTapHero(HeroesModel hero) => Get.to(
        HeroesDetailsUI(
          hero.id,
          key: Key(hero.hashCode.toString()),
        ),
        curve: Curves.easeIn,
      );
}
