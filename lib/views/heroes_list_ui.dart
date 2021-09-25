import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rd_test_flutter_heroes/controllers/heroes_list_controller.dart';
import 'package:rd_test_flutter_heroes/models/heroes_model.dart';

class HeroesListUI extends StatelessWidget {
  const HeroesListUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.7),
      body: GetBuilder<HeroesListController>(
        init: HeroesListController(),
        builder: (controller) {
          Iterable<HeroesModel> heroes = controller.heroes;

          final publishers = Set.of(heroes.map((e) => e.biography.publisher));
          final races = Set.of(heroes.map((e) => e.appearance.race));
          final gender = Set.of(heroes.map((e) => e.appearance.gender));

          final hasPublishFilter = controller.hasPublishFilter;
          final hasRaceFilter = controller.hasRaceFilter;
          final hasGenderFilter = controller.hasGenderFilter;

          final hasFilter =
              hasPublishFilter || hasRaceFilter || hasGenderFilter;

          final search = controller.searchController.text.toLowerCase();
          if (search.isNotEmpty) {
            heroes = heroes.where(
              (h) {
                final name = h.safeName.toLowerCase();
                final publisher = h.biography.publisher.toLowerCase();

                return name.contains(search) || publisher.contains(search);
              },
            );
          } else {
            if (hasFilter) {
              if (hasGenderFilter) {
                heroes = heroes.where(
                    (h) => controller.isGenderSelected(h.appearance.gender));
              }
              if (hasRaceFilter) {
                heroes = heroes
                    .where((h) => controller.isRaceSelected(h.appearance.race));
              }
              if (hasPublishFilter) {
                heroes = heroes.where((h) =>
                    controller.isPublisherSelected(h.biography.publisher));
              }
            }
          }

          return controller.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                )
              : Stack(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: kToolbarHeight * 2.5,
                      ),
                      itemCount: heroes.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final hero = heroes.elementAt(index);

                        final fullName = hero.safeName;

                        final images = hero.images;
                        final thumbnail = images.sm;

                        final isMarvel = hero.isMarvel;
                        final isDC = hero.isDC;

                        final publisher = hero.biography.publisher;

                        return InkWell(
                          onTap: () => controller.onTapHero(hero),
                          borderRadius: BorderRadius.circular(
                            size.width * 0.1,
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                size.width * 0.1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isMarvel
                                      ? Colors.pink
                                      : isDC
                                          ? Colors.indigo
                                          : Colors.green,
                                  blurRadius: 10.0,
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.15,
                                  child: Hero(
                                    tag: Key(hero.hashCode.toString()),
                                    child: CachedNetworkImage(
                                      imageUrl: thumbnail,
                                      fit: BoxFit.fill,
                                      height: size.width * 0.2,
                                      placeholderFadeInDuration:
                                          const Duration(seconds: 2),
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: isMarvel
                                              ? Colors.red
                                              : Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  width: size.width * 0.7,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      if (isMarvel || isDC)
                                        Opacity(
                                          opacity: 0.3,
                                          child: SvgPicture.asset(
                                            isMarvel
                                                ? 'assets/marvel.svg'
                                                : 'assets/dc.svg',
                                            width: size.width * 0.1,
                                          ),
                                        ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            fullName,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * 0.05,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            publisher,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: size.width * 0.03,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        !controller.showChips
                            ? Container(
                                width: size.width,
                                margin: const EdgeInsets.symmetric(
                                  vertical: kToolbarHeight,
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber.withOpacity(0.1),
                                      blurRadius: 10.0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (!hasFilter)
                                      Container(
                                        height: 50,
                                        width: size.width * 0.5,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            size.width * 0.2,
                                          ),
                                        ),
                                        child: TextField(
                                          controller:
                                              controller.searchController,
                                          onChanged: controller.onChanged,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Search...',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (search.isEmpty)
                                      IconButton(
                                        onPressed: controller.toggleChips,
                                        icon: const Icon(
                                          Icons.grid_view,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                      ),
                                    if (controller.heroes.length !=
                                        heroes.length)
                                      IconButton(
                                        onPressed: controller.clearAll,
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                height: size.height,
                                width: size.width,
                                color: Colors.black.withOpacity(0.6),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: controller.toggleChips,
                                        icon: const Icon(
                                          Icons.cancel_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'GENDER',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 0.1,
                                        ),
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        children: gender
                                            .map(
                                              (e) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: InkWell(
                                                  onTap: () =>
                                                      controller.tapGender(e),
                                                  child: ChoiceChip(
                                                    label: Text(
                                                      e,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    selected: controller
                                                        .isGenderSelected(e),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      Text(
                                        'RACES',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 0.1,
                                        ),
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        children: races
                                            .map(
                                              (e) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: InkWell(
                                                  onTap: () =>
                                                      controller.tapRace(e),
                                                  child: ChoiceChip(
                                                    label: Text(
                                                      e,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    selected: controller
                                                        .isRaceSelected(e),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      Text(
                                        'PUBLISHERS',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 0.1,
                                        ),
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        children: publishers
                                            .map(
                                              (e) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: InkWell(
                                                  onTap: () => controller
                                                      .tapPublisher(e),
                                                  child: ChoiceChip(
                                                    label: Text(
                                                      e,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    selected: controller
                                                        .isPublisherSelected(e),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      IconButton(
                                        onPressed: controller.toggleChips,
                                        icon: const Icon(
                                          Icons.cancel_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                );
        },
      ),
    );
  }
}
