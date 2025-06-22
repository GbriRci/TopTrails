import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:main/domain/models/trail.dart';
import 'package:main/presentation/screens/trailDetails/trail_details_screen.dart';

class TrailDetailsPage extends StatelessWidget {
  const TrailDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trail = GoRouterState.of(context).extra as Trail;
    return TrailDetailsScreen(trail: trail);
  }
}
