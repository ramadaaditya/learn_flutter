import 'package:flutter/material.dart';
import 'package:josresto/component/restaurant_card.dart';
import 'package:josresto/provider/restaurant_search_provider.dart';
import 'package:josresto/static/navigation_route.dart';
import 'package:josresto/static/restaurant_search_result_state.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantSearchProvider>().resetSearchState();
      }
    });
  }

  @override
  void dispose() {
    context.read<RestaurantSearchProvider>().resetSearchState();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Restaurant"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Type restaurant name...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context
                      .read<RestaurantSearchProvider>()
                      .fetchRestaurantData(query);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<RestaurantSearchProvider>(
              builder: (context, provider, child) {
                final resultState = provider.resultState;

                if (resultState is RestaurantSearchLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (resultState is RestaurantSearchLoadedState) {
                  final restaurants = resultState.data;

                  if (restaurants.isEmpty) {
                    return const Center(
                      child: Text("No restaurants found."),
                    );
                  }

                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return RestaurantCard(
                        restaurant: restaurant,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NavigationRoute.detailRoute.name,
                            arguments: restaurant.id,
                          );
                          // Navigate to the restaurant detail
                        },
                      );
                    },
                  );
                } else if (resultState is RestaurantSearchErrorState) {
                  return Center(
                    child: Text(resultState.error),
                  );
                } else {
                  return const Center(
                    child: Text("Start searching your favorite restaurants!"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
