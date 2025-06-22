//pagina del dettaglio, mi faccio passare l'extra
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import 'package:main/data/firestore_api_service.dart';
import 'package:main/domain/models/folder.dart';
import 'package:main/domain/models/trail.dart';
import 'package:main/l10n/app_localizations.dart';
import 'package:main/presentation/routes/app_paths.dart';
import 'package:main/presentation/utils/format_data_utils.dart';
import 'package:main/presentation/utils/map_center.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailDetailsScreen extends StatelessWidget {
  final Trail trail;
  const TrailDetailsScreen({required this.trail, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Text(
          AppLocalizations.of(context)!.trailDetailsTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 30,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppPaths.home);
            }
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, left: 20, right: 20),
            child: Container(
              height: 340,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                    MapCenter.getCenterLat(trail.geometry),
                    MapCenter.getCenterLng(trail.geometry),
                  ),
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: "com.example.TopTrails",
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: trail.geometry,
                        color: Colors.blue,
                        strokeWidth: 4,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(
                          trail.geometry.first.latitude,
                          trail.geometry.first.longitude,
                        ),
                        width: 27,
                        height: 27,
                        child: Icon(
                          Icons.play_arrow,
                          size: 27,
                          color: Colors.red,
                        ),
                      ),
                      Marker(
                        point: LatLng(
                          trail.geometry.last.latitude,
                          trail.geometry.last.longitude,
                        ),
                        width: 27,
                        height: 27,
                        child: Icon(Icons.flag, size: 27, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final uid = FirebaseAuth.instance.currentUser!.uid;
                    final folders = await FirestoreApiService().getFolders(uid);
                    if (!context.mounted) return;
                    List<bool> checked = List.filled(folders.length, false);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.all(20),
                          child: StatefulBuilder(
                            builder: (context, setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.trailDetailsSave,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.trailDetailsAlertText,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  ...List.generate(folders.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50,
                                      ),
                                      child: CheckboxListTile(
                                        title: Text(
                                          folders[index].name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        value: checked[index],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checked[index] = value ?? false;
                                          });
                                        },
                                      ),
                                    );
                                  }),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red,
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.trailDetailsAlertCancel,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          final selectedFolders = <Folder>[];
                                          for (
                                            int i = 0;
                                            i < folders.length;
                                            i++
                                          ) {
                                            if (checked[i]) {
                                              selectedFolders.add(folders[i]);
                                            }
                                          }
                                          for (var folder in selectedFolders) {
                                            FirestoreApiService()
                                                .addTrailToFolder(
                                                  userId: uid,
                                                  folderId: folder.folderId,
                                                  trailId: trail.id,
                                                );
                                          }
                                          context.pop();
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.green,
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.trailDetailsAlertSave,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.trailDetailsSave,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.folder_special_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    final startPoint = trail.geometry.first;
                    final endPoint = trail.geometry.last;
                    final url =
                        'https://www.google.com/maps/dir/?api=1&origin=${startPoint.latitude},${startPoint.longitude}&destination=${endPoint.latitude},${endPoint.longitude}&travelmode=walking';
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(
                        uri,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(
                              context,
                            )!.trailCantOpenGoogleMaps,
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.trailStartTrail,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.map_sharp, size: 25, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.trailDetailsSubtitle(trail.name),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.directions_walk,
                                    size: 27,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.trailDetailsLenght(trail.length),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.grass,
                                    size: 27,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.trailDetailsSurface(
                                      FormatDataUtils.getSurfaceLabel(
                                        context,
                                        trail.surface,
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.flag_circle,
                                    size: 27,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.trailDetailsGrade(
                                      FormatDataUtils.getDifficultyLabel(
                                        context,
                                        trail.grade,
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.landscape,
                                    size: 27,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.trailDetailsType(
                                      FormatDataUtils.getTypeLabel(
                                        context,
                                        trail.type,
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.loop,
                                    size: 27,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    trail.loop
                                        ? AppLocalizations.of(
                                          context,
                                        )!.trailDetailsLoopYes
                                        : AppLocalizations.of(
                                          context,
                                        )!.trailDetailsLoopNo,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
