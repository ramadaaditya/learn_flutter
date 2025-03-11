import 'package:flutter/material.dart';
import 'package:josresto/component/restaurant_card.dart';
import 'package:josresto/provider/database_provider.dart';
import 'package:josresto/static/navigation_route.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<DatabaseProvider>().loadAllRestaurantValue();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          final restaurantList = provider.restaurantList;

          if (restaurantList.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada restoran favorit",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: restaurantList.length,
            itemBuilder: (context, index) {
              final restaurant = restaurantList[index];

              return RestaurantCard(
                restaurant: restaurant,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NavigationRoute.detailRoute.name,
                    arguments: restaurant.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
