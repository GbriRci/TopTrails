import 'package:flutter/material.dart';

import 'package:main/l10n/app_localizations.dart';

class FormatDataUtils {
  static String getSurfaceLabel(BuildContext context, String surface) {
    switch (surface.toLowerCase()) {
      case 'asphalt':
      case 'concrete':
      case 'paved':
        return AppLocalizations.of(context)!.homeSurfaceAsphalt;
      case 'unpaved':
        return AppLocalizations.of(context)!.homeSurfaceUnpaved;
      case 'gravel':
      case 'fine_gravel':
      case 'pebblestone':
        return AppLocalizations.of(context)!.homeSurfaceGravel;
      case 'ground':
      case 'dirt':
      case 'earth':
      case 'mud':
      case 'clay':
        return AppLocalizations.of(context)!.homeSurfaceGround;
      case 'grass':
        return AppLocalizations.of(context)!.homeSurfaceGrass;
      case 'compacted':
      case 'compact':
        return AppLocalizations.of(context)!.homeSurfaceCompacted;
      case 'sand':
        return AppLocalizations.of(context)!.homeSurfaceSand;
      case 'cobblestone':
      case 'sett':
        return AppLocalizations.of(context)!.homeSurfaceCobblestone;
      case 'rock':
        return AppLocalizations.of(context)!.homeSurfaceRock;
      case 'wood':
      case 'woodchips':
        return AppLocalizations.of(context)!.homeSurfaceWood;
      default:
        return AppLocalizations.of(context)!.homeDefault;
    }
  }

  static String getDifficultyLabel(BuildContext context, String grade) {
    switch (grade.toLowerCase()) {
      case 'hiking':
        return AppLocalizations.of(context)!.homeEasyTrail;
      case 'mountain_hiking':
        return AppLocalizations.of(context)!.homeModerateTrail;
      case 'demanding_mountain_hiking':
        return AppLocalizations.of(context)!.homeDemandingTrail;
      case 'demanding_alpine_hiking':
      case 'alpine_hiking':
        return AppLocalizations.of(context)!.homeHardTrail;
      case 'difficult_alpine_hiking':
        return AppLocalizations.of(context)!.homeExtremeTrail;
      default:
        return AppLocalizations.of(context)!.homeDefault;
    }
  }

  static String getTypeLabel(BuildContext context, String type) {
    switch (type.toLowerCase()) {
      case 'motorway':
      case 'trunk':
      case 'primary':
      case 'secondary':
      case 'tertiary':
      case 'unclassified':
      case 'residential':
      case 'service':
      case 'living_street':
      case 'road':
        return AppLocalizations.of(context)!.homeFilterRoad;
      case 'footway':
      case 'pedestrian':
      case 'steps':
        return AppLocalizations.of(context)!.homeFilterPedestrian;
      case 'cycleway':
        return AppLocalizations.of(context)!.homeFilterCycleway;
      case 'path':
      case 'track':
      case 'bridleway':
        return AppLocalizations.of(context)!.homeFilterPedestrian;
      default:
        return AppLocalizations.of(context)!.homeDefault;
    }
  }

  static String getSurfaceImage(String surface) {
    switch (surface.toLowerCase()) {
      case 'gravel':
      case 'fine_gravel':
        return 'assets/images/gravel.png';
      case 'dirt':
      case 'grass':
        return 'assets/images/ground.png';
      case 'ground':
      case 'compact':
        return 'assets/images/rock.png';
      case 'unpaved':
      case 'asphalt':
        return 'assets/images/unpaved.png';
      default:
        return 'assets/images/other.png';
    }
  }
}
