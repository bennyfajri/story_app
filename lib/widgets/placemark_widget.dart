import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:story_app/my_app.dart';

class PlacemarkWidget extends StatelessWidget {
  const PlacemarkWidget({
    super.key,
    required this.placemark,
    required this.onSelected,
  });

  final geo.Placemark placemark;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  placemark.street!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: onSelected,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(appLocale.add_location),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
