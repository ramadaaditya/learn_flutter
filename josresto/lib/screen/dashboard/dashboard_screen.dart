import 'package:flutter/material.dart';
import 'package:josresto/component/restaurant_card.dart';
import 'package:josresto/provider/restaurant_list_provider.dart';
import 'package:josresto/screen/search/search_screen.dart';
import 'package:josresto/static/navigation_route.dart';
import 'package:josresto/static/restaurant_list_result_state.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantListProvider>().fetchRestaurantList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, child) {
          final resultState = provider.resultState;

          if (resultState is RestaurantListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (resultState is RestaurantListLoadedState) {
            final restaurantList = resultState.data;

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
          } else if (resultState is RestaurantListErrorState) {
            return Center(
              child: Text(resultState.error),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
