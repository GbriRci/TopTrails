import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:main/common/location/location_bloc.dart';
import 'package:main/common/location/location_event.dart';
import 'package:main/common/location/location_state.dart';
import 'package:main/common/trail/trail_bloc.dart';
import 'package:main/common/trail/trail_event.dart';
import 'package:main/common/trail/trail_state.dart';
import 'package:main/data/open_street_map_api.dart';
import 'package:main/l10n/app_localizations.dart';
import 'package:main/presentation/routes/app_paths.dart';
import 'package:main/presentation/utils/format_data_utils.dart';
import 'package:main/presentation/utils/home_filters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  int? _selectedDifficulty;
  int? _selectedLength;
  LatLng? _selectedPosition;

  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(StartLocationTracking());
  }

  @override
  Widget build(BuildContext context) {
    final userPosition = context.watch<LocationBloc>().state.position;
    if (_selectedPosition == null && userPosition != null) {
      _selectedPosition = LatLng(userPosition.latitude, userPosition.longitude);
      context.read<TrailBloc>().add(
        TrailLoadRequested(
          lat: _selectedPosition!.latitude,
          lon: _selectedPosition!.longitude,
        ),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 30,
                right: 25,
                left: 25,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(51),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        width: 200,
                        height: 40,
                        child: TextFormField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.homeSearchBarHint,
                            hintStyle: TextStyle(color: Colors.white),
                            suffixIcon: Icon(
                              Icons.location_pin,
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          onFieldSubmitted: (query) async {
                            final results =
                                await OpenStreetMapApi.coordinatesFromSearch(
                                  query,
                                );
                            if (results != null) {
                              setState(() {
                                _selectedPosition = results;
                              });
                              _mapController.move(_selectedPosition!, 13);
                              context.read<TrailBloc>().add(
                                TrailLoadRequested(
                                  lat: _selectedPosition!.latitude,
                                  lon: _selectedPosition!.longitude,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.homeSearchError,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                            _searchController.clear();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          context.push(AppPaths.profile);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          context.push(AppPaths.settings);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 13,
                      children: [
                        FilterChip(
                          label: Text(
                            AppLocalizations.of(context)!.homeFilterEasy,
                          ),
                          selected: _selectedDifficulty == 0,
                          avatar: Icon(
                            Icons.sentiment_satisfied_alt,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedDifficulty = selected ? 0 : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(
                            AppLocalizations.of(context)!.homeFilterModerate,
                          ),
                          avatar: Icon(
                            Icons.directions_walk,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          selected: _selectedDifficulty == 1,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDifficulty = selected ? 1 : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(
                            AppLocalizations.of(context)!.homeFilterHard,
                          ),
                          avatar: Icon(
                            Icons.whatshot,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          selected: _selectedDifficulty == 2,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDifficulty = selected ? 2 : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(
                            AppLocalizations.of(context)!.homeExtremeTrail,
                          ),
                          avatar: Icon(
                            Icons.warning_amber,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          selected: _selectedDifficulty == 3,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDifficulty = selected ? 3 : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text("0 - 3 km"),
                          avatar: Icon(
                            Icons.flag,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          selected: _selectedLength == 0,
                          onSelected: (selected) {
                            setState(() {
                              _selectedLength = selected ? 0 : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text("3 - 7 km"),
                          avatar: Icon(
                            Icons.directions_run_rounded,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          selected: _selectedLength == 1,
                          onSelected: (selected) {
                            setState(() {
                              _selectedLength = selected ? 1 : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text("7 - 15 km"),
                          avatar: Icon(
                            Icons.landscape,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          selected: _selectedLength == 2,
                          onSelected: (selected) {
                            setState(() {
                              _selectedLength = selected ? 2 : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text("> 15 km"),
                          avatar: Icon(
                            Icons.hiking,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          selected: _selectedLength == 3,
                          onSelected: (selected) {
                            setState(() {
                              _selectedLength = selected ? 3 : null;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 3,
                      ),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        final position = state.position;
                        if (position == null) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              initialCenter: _selectedPosition!,
                              initialZoom: 8,
                              onTap: (tapPosition, latlng) {
                                setState(() {
                                  _selectedPosition = latlng;
                                });
                                context.read<TrailBloc>().add(
                                  TrailLoadRequested(
                                    lat: latlng.latitude,
                                    lon: latlng.longitude,
                                  ),
                                );
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: "com.example.TopTrails",
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: _selectedPosition!,
                                    width: 40,
                                    height: 40,
                                    child: Icon(
                                      Icons.location_on_rounded,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: FloatingActionButton(
                                  heroTag: null,
                                  backgroundColor: Colors.white,
                                  onPressed: () {
                                    if (userPosition != null) {
                                      setState(() {
                                        _selectedPosition = LatLng(
                                          userPosition.latitude,
                                          userPosition.longitude,
                                        );
                                      });
                                      _mapController.move(
                                        _selectedPosition!,
                                        _mapController.camera.zoom,
                                      );
                                      context.read<TrailBloc>().add(
                                        TrailLoadRequested(
                                          lat: _selectedPosition!.latitude,
                                          lon: _selectedPosition!.longitude,
                                        ),
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.my_location,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TrailBloc, TrailState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                            strokeWidth: 13,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.homeCharging,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                if (state.error != null) {
                  return Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 200,
                          color: Colors.grey,
                        ),
                        Text(
                          state.error!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                final filteredTrails = HomeFilters.filterByLenght(
                  HomeFilters.filterByDifficulty(
                    state.trails,
                    _selectedDifficulty,
                  ),
                  _selectedLength,
                );
                if (filteredTrails.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 200,
                          color: Colors.grey,
                        ),
                        Text(
                          AppLocalizations.of(context)!.homeNoTrails,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                return GridView.builder(
                  padding: EdgeInsets.all(15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // 2 colonne
                    crossAxisCount: 2,
                    // Spaziatura tra le colonne
                    crossAxisSpacing: 15,
                    // Spaziatura tra le righe
                    mainAxisSpacing: 12,
                    // Rapporto di aspetto dei figli
                    childAspectRatio: 1,
                  ),
                  itemCount: filteredTrails.length,
                  itemBuilder: (context, index) {
                    final trail = filteredTrails[index];
                    return InkWell(
                      onTap: () {
                        context.push(AppPaths.trailDetails, extra: trail);
                      },
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 1.5,
                          ),
                        ),
                        child: Stack(
                          children: [
                            //immagine sopra la card
                            Positioned.fill(
                              child: Opacity(
                                opacity: 0.20,
                                child: Image.asset(
                                  FormatDataUtils.getSurfaceImage(
                                    trail.surface,
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            // Contenuto della card
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      trail.name,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            'Montserrat-Italic-VariableFont_wght',
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  SizedBox(height: 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.directions_walk,
                                        size: 20,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                      ),
                                      SizedBox(width: 4),
                                      Text("${trail.length.toString()} m"),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.flag_circle,
                                        size: 20,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                      ),
                                      SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          FormatDataUtils.getDifficultyLabel(
                                            context,
                                            trail.grade,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.grass,
                                        size: 20,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        FormatDataUtils.getSurfaceLabel(
                                          context,
                                          trail.surface,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
