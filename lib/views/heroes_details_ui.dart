import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rd_test_flutter_heroes/controllers/heroes_details_controller.dart';
import 'package:rd_test_flutter_heroes/models/heroes_model.dart';

class HeroesDetailsUI extends StatelessWidget {
  const HeroesDetailsUI(this.heroId, {Key? key}) : super(key: key);
  final int heroId;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    return GetBuilder<HeroesDetailsController>(
      init: HeroesDetailsController(heroId),
      builder: (controller) {
        final hero = controller.heroesModel;

        final isMarvel = hero?.isMarvel ?? false;
        final isDC = hero?.isDC ?? false;

        final images = hero?.images;
        final thumbnail = images?.xs ?? '';
        // final sm = images?.sm ?? '';
        // final md = images?.md ?? '';
        final lg = images?.lg ?? '';

        final isLoading = controller.loading;

        final powerStats = controller.powerStatsModel;
        final appearance = controller.appearanceModel;
        final biography = controller.biographyModel;
        final work = controller.workModel;
        final connections = controller.connectionsModel;

        final color = isMarvel
            ? Colors.pink
            : isDC
                ? Colors.indigo
                : Colors.green;

        return Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.3),
          appBar: isLoading
              ? null
              : AppBar(
                  backgroundColor: color,
                  title: Text(hero?.safeName ?? ''),
                  actions: [
                    CircleAvatar(backgroundImage: NetworkImage(thumbnail))
                  ],
                ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isMarvel || isDC)
                      Opacity(
                        opacity: 0.1,
                        child: SvgPicture.asset(
                          isMarvel ? 'assets/marvel.svg' : 'assets/dc.svg',
                        ),
                      ),
                    SizedBox(
                      height: size.height,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: kToolbarHeight),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Hero(
                              tag: key ?? '',
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.2,
                                  vertical: 20,
                                ),
                                height: size.height * 0.3,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.3),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: lg,
                                  fit: BoxFit.cover,
                                  placeholderFadeInDuration:
                                      const Duration(seconds: 2),
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color:
                                          isMarvel ? Colors.red : Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            _HeroPowerStatsWidget(powerStats, color),
                            _HeroAppearanceWidget(appearance, color),
                            _HeroBiographyWidget(biography, color),
                            _HeroWorkWidget(work, color),
                            _HeroConnectionsWidget(connections, color),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _HeroPowerStatsWidget extends StatelessWidget {
  const _HeroPowerStatsWidget(this.powerStats, this.color);
  final PowerStatsModel? powerStats;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Power Stats',
            style: TextStyle(
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          powerStats == null
              ? CircularProgressIndicator(
                  color: color,
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: size.width * 0.03,
                              ),
                              child: const Text(
                                '🧠',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Text(powerStats!.combat.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: size.width * 0.03,
                              ),
                              child: const Text(
                                '💪🏻',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Text(powerStats!.strength.toString()),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: size.width * 0.03,
                              ),
                              child: const Text(
                                '🏎',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Text(powerStats!.speed.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: size.width * 0.03,
                              ),
                              child: const Text(
                                '⏳',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Text(powerStats!.durability.toString()),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: size.width * 0.03,
                              ),
                              child: const Text(
                                '⚡️',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Text(powerStats!.power.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: size.width * 0.03,
                              ),
                              child: const Text(
                                '⚔',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Text(powerStats!.combat.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }
}

class _HeroAppearanceWidget extends StatelessWidget {
  const _HeroAppearanceWidget(this.appearance, this.color);
  final AppearanceModel? appearance;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    final gender = appearance?.isMale;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Appearance',
            style: TextStyle(
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          appearance == null
              ? CircularProgressIndicator(
                  color: color,
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Gender: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          gender == null
                              ? '❓'
                              : gender
                                  ? '♂'
                                  : '♀',
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Race: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(appearance!.race),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Height: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(appearance!.height.last),
                            const Text(' / '),
                            Text(appearance!.height.first),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Weight: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(appearance!.weight.last),
                              const Text(' / '),
                              Text(appearance!.weight.first),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Eye Color: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(appearance!.eyeColor),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hair Color: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(appearance!.hairColor),
                        ],
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}

class _HeroBiographyWidget extends StatelessWidget {
  const _HeroBiographyWidget(this.biography, this.color);
  final BiographyModel? biography;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Biography',
            style: TextStyle(
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          biography == null
              ? CircularProgressIndicator(
                  color: color,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Full Name: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(biography!.fullName),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Alter Egos: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(biography!.alterEgos),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Aliases: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              biography!.aliases.map((e) => Text(e)).toList(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Place of Birth: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(biography!.placeOfBirth),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'First Appearance: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(biography!.firstAppearance),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Publisher: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(biography!.publisher),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alignment: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(biography!.alignment),
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }
}

class _HeroWorkWidget extends StatelessWidget {
  const _HeroWorkWidget(this.work, this.color);
  final WorkModel? work;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Work',
            style: TextStyle(
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          work == null
              ? CircularProgressIndicator(
                  color: color,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Occupation: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(work!.occupation),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Base: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(work!.base),
                        ],
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}

class _HeroConnectionsWidget extends StatelessWidget {
  const _HeroConnectionsWidget(this.connections, this.color);
  final ConnectionsModel? connections;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Connections',
            style: TextStyle(
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          connections == null
              ? CircularProgressIndicator(
                  color: color,
                )
              : Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Occupation: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(connections!.groupAffiliation),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Relatives: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(connections!.relatives),
                        ],
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
