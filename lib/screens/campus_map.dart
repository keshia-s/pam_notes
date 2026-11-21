import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class _Place {
  final String name;
  final LatLng point;
  const _Place(this.name, this.point);
}

const _places = [
  _Place('Kampus', LatLng(2.385399, 99.147784)),
  _Place('Horatio Guesthouse', LatLng(2.383119, 99.148090)),
  _Place('Indomaret', LatLng(2.382816, 99.150141)),
];

class CampusMap extends StatelessWidget {
  const CampusMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _places.first.point,
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'del.ac.id.pam_notes',
        ),
        MarkerLayer(
          markers: _places
              .map(
                (p) => Marker(
                  point: p.point,
                  width: 44,
                  height: 44,
                  child: GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(p.name)),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 44,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const RichAttributionWidget(
          attributions: [
            TextSourceAttribution('© OpenStreetMap contributors'),
          ],
        ),
      ],
    );
  }
}