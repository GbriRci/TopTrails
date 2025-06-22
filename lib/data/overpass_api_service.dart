// Servizio API che recupera dati da Overpass API
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

import 'package:main/data/utils/overpass_data_utils.dart';
import 'package:main/domain/models/trail.dart';

// Classe che gestisce le richieste all'API Overpass per recuperare i sentieri
class OverpassApiService {
  // URL base dell'API Overpass
  final String _url = 'https://overpass-api.de/api/interpreter';

  // Metodo per recuperare i sentieri
  Future<List<Trail>> trailGetter({
    required double lat,
    required double lon,
  }) async {
    try {
      // Query Overpass per ottenere: NOME, TIPOLOGIA, TERRENO e DIFFICOLTÀ
      final query = '''
      [out:json][timeout:90];
      way(around:30000,$lat,$lon)
        ["highway"~"path|footway"]
        ["name"]
        ["surface"]
        ["sac_scale"];
      out geom;
      ''';

      // Effettua la richiesta POST (secondo la guida overpass è meglio
      //perchè ha un corpo più lungo)
      final response = await http.post(Uri.parse(_url), body: {'data': query});

      //se la richiesta va a buon fine, decodifica la risposta JSON
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Trasfroma la lista degli elementi da JSON a Tral
        final elements = List<Map<String, dynamic>>.from(data['elements']);
        final trails =
            elements
                .map(
                  (item) => Trail(
                    id: item["id"].toString(),
                    name: item["tags"]?["name"] ?? "N/A",
                    length: OverpassDataUtils.calculateLength(item["geometry"]),
                    grade: item["tags"]?["sac_scale"] ?? "N/A",
                    surface: item["tags"]?["surface"] ?? "N/A",
                    type: item["tags"]?["highway"] ?? "N/A",
                    loop: OverpassDataUtils.isLoopTrail(
                      item["geometry"]
                          .map<LatLng>(
                            (point) => LatLng(point["lat"], point["lon"]),
                          )
                          .toList(),
                    ),
                    geometry:
                        item["geometry"]
                            .map<LatLng>(
                              (point) => LatLng(point["lat"], point["lon"]),
                            )
                            .toList(),
                  ),
                )
                .where((trail) => trail.length >= 1000)
                .toList();
        trails.shuffle();
        return trails.take(20).toList();
      }
    } catch (e) {
      debugPrint("Error");
      debugPrint(e.toString());
    }
    //se la chiamata non ha avuto successo allora lancio un'eccezione
    throw Exception("Failed to load trails");
  }

  //Recupero i sentieri in una cartella specifica
  Future<List<Trail>> getTrailsInFolder(List<String> trailsId) async {
    if (trailsId.isEmpty) {
      return [];
    }
    try {
      final ids = trailsId
          .map((id) => id.replaceAll(RegExp(r'^\D+_'), ''))
          .join(',');
      final query = '''
        [out:json];
        way(id:$ids)["highway"~"path|footway"];
        out geom;
      ''';

      final response = await http.post(Uri.parse(_url), body: {'data': query});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final elements = List<Map<String, dynamic>>.from(data['elements']);
        final trails =
            elements.map((item) {
              return Trail(
                id: item["id"].toString(),
                name: item["tags"]?["name"] ?? "N/A",
                length: OverpassDataUtils.calculateLength(item["geometry"]),
                grade: item["tags"]?["sac_scale"] ?? "N/A",
                surface: item["tags"]?["surface"] ?? "N/A",
                type: item["tags"]?["highway"] ?? "N/A",
                loop: OverpassDataUtils.isLoopTrail(
                  item["geometry"]
                      .map<LatLng>(
                        (point) => LatLng(point["lat"], point["lon"]),
                      )
                      .toList(),
                ),
                geometry:
                    item["geometry"]
                        .map<LatLng>(
                          (point) => LatLng(point["lat"], point["lon"]),
                        )
                        .toList(),
              );
            }).toList();
        return trails;
      }
    } catch (e) {
      debugPrint("Error");
      debugPrint(e.toString());
    }
    throw Exception("Failed to load trails");
  }
}
