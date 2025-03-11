import 'package:flutter/material.dart';
import 'package:josresto/component/detail_restaurant_widget.dart';
import 'package:josresto/component/favorite_icon_widget.dart';
import 'package:josresto/provider/restaurant_detail_provider.dart';
import 'package:josresto/static/restaurant_detail_result_state.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context
            .read<RestaurantDetailProvider>()
            .fetchDetailRestaurant(widget.restaurantId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, detailProvider, child) {
          final state = detailProvider.resultState;

          if (state is RestaurantDetailLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RestaurantDetailLoadedState) {
            final restaurant = state.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  restaurant.name,
                  overflow:
                      TextOverflow.ellipsis, // Supaya tidak terlalu panjang
                  style: const TextStyle(fontSize: 20),
                ),
                centerTitle: true,
                actions: [
                  FavoriteIconWidget(
                      restaurant: restaurant), // Ikon favorit di AppBar
                  const SizedBox(width: 8), // Jarak agar tidak terlalu rapat
                ],
              ),
              body: DetailRestaurantWidget(restaurant: restaurant),
            );
          } else if (state is RestaurantDetailErrorState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Restaurant Detail"),
                centerTitle: true,
              ),
              body: Center(child: Text(state.error)),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
